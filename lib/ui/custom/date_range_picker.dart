import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

// import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/auth/Auth.dart';
import 'package:flutter_sheplates/auth/RestApiCalls.dart';
import 'package:flutter_sheplates/modals/response/HolidayListResponse.dart';
import 'event.dart';

/// Page with the [RangePicker].
enum RangeSelectionType { Weekly, Monthly, Custom }

class RangePickerPage extends StatefulWidget {
  /// Custom events.
  final List<Event> events;
  final RangeSelectionType selectionType;

  ///
  const RangePickerPage({Key key, this.events, this.selectionType})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _RangePickerPageState(this.selectionType);
}

class _RangePickerPageState extends State<RangePickerPage> {
  DateTime _firstDate;
  DateTime _lastDate;
  DatePeriod _selectedPeriod;

  Color selectedPeriodStartColor;
  Color selectedPeriodLastColor;
  Color selectedPeriodMiddleColor;

  final RangeSelectionType selectionType;

  List<DateTime> listOfSundays = List();
  List<HolidayDateArray> listOfHolidays = List();
  List<DateTime> listOfHolidaysBetweenDateRange = List();
  List<DateTime> listOfDeliveryDatesBetweenDateRange = List();

  StreamController<List<HolidayDateArray>> holidayStreamController;

  _RangePickerPageState(this.selectionType);

  int byDefaultSelectedDays;

  @override
  void initState() {
    super.initState();

    _firstDate = DateTime.now().add(Duration(days: 1));
    _lastDate = DateTime.now().add(Duration(days: 365));

    holidayStreamController = StreamController.broadcast();

    if (selectionType == RangeSelectionType.Weekly) {
      byDefaultSelectedDays = 7;
    } else if (selectionType == RangeSelectionType.Monthly) {
      byDefaultSelectedDays = 30;
    } else {
      byDefaultSelectedDays = 0;
    }

    DateTime selectedPeriodStart = DateTime.now().add(Duration(days: 1));
    DateTime selectedPeriodEnd = DateTime.now();
    _selectedPeriod = DatePeriod(selectedPeriodStart, selectedPeriodEnd);

    /*listOfSundays = getListOfWeekends(
        _selectedPeriod.start, _selectedPeriod.end.add(Duration(days: 1)));*/

    getHolidays();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // defaults for styles
    selectedPeriodLastColor = Theme.of(context).accentColor;
    selectedPeriodMiddleColor = Theme.of(context).accentColor;
    selectedPeriodStartColor = Theme.of(context).accentColor;
  }

  @override
  Widget build(BuildContext context) {
    // add selected colors to default settings
    DatePickerRangeStyles styles = DatePickerRangeStyles(
        selectedPeriodLastDecoration: BoxDecoration(
            color: AppColor.themeButtonColor,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24.0),
                bottomRight: Radius.circular(24.0))),
        selectedPeriodStartDecoration: BoxDecoration(
          color: AppColor.themeButtonColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              bottomLeft: Radius.circular(24.0)),
        ),
        selectedPeriodMiddleDecoration:
            BoxDecoration(color: Colors.red[300], shape: BoxShape.rectangle),
        nextIcon: const Icon(Icons.arrow_right),
        prevIcon: const Icon(Icons.arrow_left),
        dayHeaderStyleBuilder: _dayHeaderStyleBuilder);

    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.black,
                ),
                onPressed: () {
                  if (listOfDeliveryDatesBetweenDateRange.length != 0) {
                    Navigator.of(context).pop({
                      'period': _selectedPeriod,
                      'holidays': listOfHolidaysBetweenDateRange
                    });
                  } else {
                    CommonUtils.showToast(
                        msg:
                            "Please select different dates, No dates available for delivery for selected dates",
                        bgColor: Colors.black,
                        textColor: Colors.white);
                  }
                })
          ],
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: StreamBuilder<List<HolidayDateArray>>(
            stream: holidayStreamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    RangePicker(
                      selectedPeriod: _selectedPeriod,
                      onChanged: _onSelectedDateChanged,
                      firstDate: _firstDate,
                      lastDate: _lastDate,
                      datePickerStyles: styles,
                      datePickerLayoutSettings: DatePickerLayoutSettings(
                          contentPadding: EdgeInsets.zero,
                          monthPickerPortraitWidth:
                              MediaQuery.of(context).size.width),
                      eventDecorationBuilder: _eventDecorationBuilder,
                      selectableDayPredicate: _isSelectableCustom,
                      onSelectionError: _onSelectionError,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey[300],
                      child: ScreenUtils.customText(
                          data: "Selected dates", fontSize: 16),
                      padding: EdgeInsets.all(10),
                    ),
                    _selectedBlock(),
                  ],
                );
              } else {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  // Block with show information about selected date
  // and boundaries of the selected period.
  Widget _selectedBlock() => Expanded(
        child: ListView(
          shrinkWrap: true,
          children: getItems(),
        ),
      );

  void _onSelectedDateChanged(DatePeriod newPeriod) {
    if (selectionType != RangeSelectionType.Custom) {
      int numberOfSundays = getDifferenceWithoutWeekends(
          newPeriod.start.subtract(Duration(days: 1)),
          newPeriod.start.add(Duration(days: byDefaultSelectedDays)));
      setState(() {
        _selectedPeriod = DatePeriod(
            newPeriod.start,
            newPeriod.start.add(Duration(
                days: (byDefaultSelectedDays -
                        (selectionType == RangeSelectionType.Weekly ? 1 : 0)) +
                    numberOfSundays)));
      });
    } else {
      setState(() {
        _selectedPeriod = DatePeriod(newPeriod.start, newPeriod.end);
      });
    }

    listOfSundays = getListOfWeekends(
        _selectedPeriod.start, _selectedPeriod.end.add(Duration(days: 1)));
    print(listOfSundays);
  }

  int getDifferenceWithoutWeekends(DateTime startDate, DateTime endDate,
      {int days: 0}) {
    int nbDays = days;
    listOfHolidaysBetweenDateRange = List();
    DateTime currentDay = startDate;
    while (currentDay.isBefore(endDate)) {
      currentDay = currentDay.add(Duration(days: 1));
      if (!delivered(currentDay)) {
        nbDays += 1;
      }
    }
    if (nbDays == days) {
      return nbDays;
    } else {
      if (checkDateRangeIsRight(_selectedPeriod.start, endDate)) {
        return getDifferenceWithoutWeekends(
            endDate, endDate.add(Duration(days: nbDays)),
            days: nbDays);
      } else {
        return nbDays;
      }
    }
  }

  bool checkDateRangeIsRight(DateTime startDate, DateTime endDate) {
    DateTime currentDay = startDate;
    List<DateTime> list = List();
    while (currentDay.isBefore(endDate.add(Duration(days: 1)))) {
      if (listOfHolidays
              .where((element) =>
                  sameDate(currentDay, DateTime.parse(element.date)))
              .toList()
              .length ==
          0) {
        list.add(currentDay);
      }
      currentDay = currentDay.add(Duration(days: 1));
    }
    return (list.length == byDefaultSelectedDays);
  }

  List<DateTime> getListOfWeekends(DateTime startDate, DateTime endDate) {
    int nbDays = 0;
    List<DateTime> list = List();
    print(endDate);
    DateTime currentDay = startDate;
    while (currentDay.isBefore(endDate)) {
      if (currentDay.weekday == DateTime.sunday) {
        nbDays += 1;
        list.add(currentDay);
      }
      currentDay = currentDay.add(Duration(days: 1));
      print(currentDay);
    }
    print(list);
    return list;
  }

  EventDecoration _eventDecorationBuilder(DateTime date) {
    List<DateTime> eventsDates =
        widget.events?.map<DateTime>((Event e) => e.date)?.toList();

    bool isEventDate = eventsDates?.any((DateTime d) =>
            date.year == d.year &&
            date.month == d.month &&
            d.day == date.day) ??
        false;

    BoxDecoration roundedBorder = BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.all(Radius.circular(3.0)));

    return isEventDate ? EventDecoration(boxDecoration: roundedBorder) : null;
  }

  // ignore: prefer_expression_function_bodies
  bool _isSelectableCustom(DateTime day) {
    /*DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));
    DateTime tomorrow = now.add(Duration(days: 1));
    bool isYesterday = sameDate(day, yesterday);
    bool isTomorrow = sameDate(day, tomorrow);

    return !isYesterday && !isTomorrow;

    // return true;*/
    /*if (day.weekday == DateTime.sunday) {
      widget.events.add(Event(day, ""));
    }*/
    return true;
    //return day.day != DateTime.now().add(Duration(days: 7)).day ;
  }

  void _onSelectionError(UnselectablePeriodException exception) {
    print(exception.customDisabledDates);

    DatePeriod errorPeriod = exception.period;

    // If user supposed to set another start of the period.
    bool selectStart = _selectedPeriod.start != errorPeriod.start;

    DateTime newSelection = selectStart ? errorPeriod.start : errorPeriod.end;

    DatePeriod newPeriod = DatePeriod(newSelection, newSelection);

    setState(() {
      _selectedPeriod = newPeriod;
    });
  }

  // 0 is Sunday, 6 is Saturday
  DayHeaderStyle _dayHeaderStyleBuilder(int weekday) {
    bool isWeekend = weekday == 0;

    return DayHeaderStyle(
        textStyle: TextStyle(color: isWeekend ? Colors.red : Colors.teal));
  }

  getItems() {
    DateTime currentDay = _selectedPeriod.start;
    List<Widget> itemList = List();
    while (currentDay.isBefore(_selectedPeriod.end.add(
        Duration(days: selectionType == RangeSelectionType.Custom ? 0 : 1)))) {
      if (!delivered(currentDay)) {
        listOfHolidaysBetweenDateRange.add(currentDay);
      } else {
        listOfDeliveryDatesBetweenDateRange.add(currentDay);
      }

      itemList.add(Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(5),
            tileColor: delivered(currentDay) ? Colors.white : Colors.red,
            title: ScreenUtils.customText(
                data: CommonUtils.getSimpleDate(currentDay),
                color: delivered(currentDay) ? Colors.black : Colors.white),
            trailing: IconButton(
              icon: delivered(currentDay)
                  ? Icon(
                      Icons.check,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
              onPressed: () {},
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            margin: EdgeInsets.all(5),
            color: Colors.grey[300],
          )
        ],
      ));
      currentDay = currentDay.add(Duration(days: 1));
    }
    return itemList;
  }

  delivered(DateTime currentDay) {
    return listOfHolidays
            .where(
                (element) => sameDate(currentDay, DateTime.parse(element.date)))
            .toList()
            .length ==
        0;
  }

  void getHolidays() {
    RestApiCalls apiCalls = RestApiCalls();

    Auth auth = Auth();
    apiCalls.getHolidayList(auth.token).then((value) {
      if (value.status == 200) {
        listOfHolidays = value.data.dateArray;
        listOfHolidays.forEach((element) {
          widget.events
              .add(Event(DateTime.parse(element.date), element.holiday_name));
        });
        holidayStreamController.sink.add(value.data.dateArray);
      } else {
        holidayStreamController.sink.addError(value.message);
      }
    }).catchError((error) {
      holidayStreamController.sink.addError(error.toString());
    });
  }
}

bool sameDate(DateTime first, DateTime second) {
  return first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
}
