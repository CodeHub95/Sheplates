import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/Routes.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/auth/api_config.dart';
import 'package:flutter_sheplates/modals/request/StockCheckRequest.dart';
import 'package:flutter_sheplates/modals/response/CheckOutResponse.dart';
import 'package:flutter_sheplates/modals/response/HomeListResponse.dart';
import 'package:flutter_sheplates/ui/Checkout.dart';
import 'package:flutter_sheplates/ui/custom/date_range_picker.dart';

class ConfirmSubscription extends StatefulWidget {
  final Rows rows;

  ConfirmSubscription(this.rows);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ConfirmSubscription> {
  TextEditingController timeController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  TextEditingController durationController = new TextEditingController();
  TextEditingController mealPlanController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController foodController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> time = List();
  var quantity = ['1', '2', '3'];
  var duration = ['Weekly', 'Monthly', 'Custom'];

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool _autoValidate = false;

  DateTime selectedDate = DateTime.now();
  RangeSelectionType selectionType;
  String prefferedTime;
  String quantityValue;

  DatePeriod datePeriod;
  List<DateTime> holidaysList = List();

  Future<Null> _selectDate(BuildContext context) async {
    Navigator.of(context).pushNamed(Routes.rangePickerPage, arguments: {'selectionType': selectionType}).then((value) {
      if (value != null) {
        Map<String, dynamic> map = value as Map;
        datePeriod = map['period'] as DatePeriod;
        dateController.text =
            CommonUtils.getSimpleDate(datePeriod.start) + " - " + CommonUtils.getSimpleDate(datePeriod.end);
        holidaysList = map['holidays'] as List;
      }
    });
  }

  @override
  initState() {
    super.initState();

    if (widget.rows.mealCategory.category == "BreakFast") {
      time = ['7:00-7:30', '7:30-8:00', '8:00-8:30', '8:30-9:00', '9:00-9:30', '9:30-10:00'];
    } else if (widget.rows.mealCategory.category == "Lunch") {
      time = ['11:30-12:00', '12:00-12:30', '12:30-13:00', '13:00-13:30', '13:30-14:00', '14:30-15:00'];
    } else if (widget.rows.mealCategory.category == "Dinner") {
      time = ['18:00-18:30', ' 18:30-19:00', '19:00-19:30', '19:30-20:00', '20:00-20:30', '20:30-21:00'];
    } else if (widget.rows.mealCategory.category == "Snacks") {
      time = ['15:00-15:30', '15:30-16:00', '16:00-16:30', '16:30-17:00', '17:00-17:30'];
    }

    getMealName();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).accentColor;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
              child: Padding(
                  padding: EdgeInsets.only(
                    right: 20,
                  ),
                  child: Text(
                    "Let's Confirm Your Subscription",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    textAlign: TextAlign.center,
                  ))),
          leading: Builder(
            builder: (context) => IconButton(
              icon: new Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => {Navigator.pop(context)},
            ),
          ),
          bottom: PreferredSize(
              child: Container(
                color: Colors.grey,
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0)),
        ),
        body: SingleChildScrollView(
            child: FormBuilder(
          key: _fbKey,
          autovalidateMode: _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  inputWidget(
                    attribute: "meal_plan",
                    validators: [FormBuilderValidators.required()],
                    textEditingController: mealPlanController,
                    textInputType: TextInputType.text,
                    readOnly: true,
                    isDisbaled: true,
                    hint: "Meal Plan",
                  ),
                  inputWidgetDropDown(
                    attribute: "delivery_time",
                    validators: [FormBuilderValidators.required()],
                    hint: "Preferred Delivery Time",
                    onChanged: (String value) {
                      prefferedTime = value;
                    },
                    items: time,
                  ),
                  inputWidgetDropDown(
                      attribute: "qua",
                      validators: [FormBuilderValidators.required()],
                      hint: "Quantity",
                      onChanged: (String value) {
                        quantityValue = value;
                      },
                      items: [
                        "1",
                        "2",
                        "3",
                        "4",
                        "5",
                        "6",
                        "7",
                        "8",
                        "9",
                        "10",
                      ]),
                  inputWidgetDropDown(
                      attribute: "duration",
                      validators: [FormBuilderValidators.required()],
                      hint: "Duration",
                      onChanged: (String value) {
                        dateController.text = "";
                        if (value == "Weekly") {
                          selectionType = RangeSelectionType.Weekly;
                        } else if (value == "Monthly") {
                          selectionType = RangeSelectionType.Monthly;
                        } else {
                          selectionType = RangeSelectionType.Custom;
                        }
                      },
                      items: duration),
                  InkWell(
                    onTap: () {
                      if (selectionType != null) {
                        _selectDate(context);
                      } else {
                        CommonUtils.showToast(
                            msg: "Please choose duration before choosing dates",
                            bgColor: Colors.black,
                            textColor: Colors.white);
                      }
                    },
                    child: inputWidget(
                        attribute: "choose_your_date",
                        validators: [FormBuilderValidators.required()],
                        textEditingController: dateController,
                        textInputType: TextInputType.text,
                        readOnly: true,
                        image: "assets/calendar_icon.png",
                        hint: "Choose Your Date"),
                  ),
                  Container(
                      padding: EdgeInsets.only(),
                      margin: EdgeInsets.only(top: 40, bottom: 40, right: 0, left: 0),
                      height: 40,
                      alignment: Alignment.center,
                      child: RaisedButton(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          color: AppColor.themeButtonColor,
                          textColor: Colors.white,
                          child: Text(
                            ('Confirm & Proceed to checkout'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          onPressed: () {
                            if (_validateInput()) {
                              submit();
                            }
                          })),
                ]),
          ),
        )));
  }

  Widget inputWidget(
      {@required String attribute,
      @required var validators,
      @required var textInputType,
      @required TextEditingController textEditingController,
      @required String hint,
      int maxLine: 1,
      String image,
      bool isObscureText: false,
      bool readOnly: false,
      bool isDisbaled: false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ScreenUtils.customText(data: hint, fontSize: 13, color: Colors.black),
          Container(
            height: 60,
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1), borderRadius: BorderRadius.all(Radius.circular(8))),
            child: FormBuilderTextField(
              attribute: attribute,
              validators: validators,
              controller: textEditingController,
              maxLines: maxLine,
              readOnly: readOnly,
              keyboardType: textInputType,
              decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                  errorStyle: TextStyle(
                    color: Theme.of(context).errorColor, // or any other color
                  ),
                  suffixIcon: image != null ? Image.asset(image) : null),
            ),
          ),
        ],
      ),
    );
  }

  inputWidgetDropDown(
      {@required String attribute,
      @required var validators,
      @required String hint,
      @required List<String> items,
      @required Function(String) onChanged,
      int maxLine: 1,
      bool isObscureText: false,
      bool readOnly: false,
      String image}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ScreenUtils.customText(data: hint, fontSize: 13, color: Colors.black),
          Container(
            height: 60,
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1), borderRadius: BorderRadius.all(Radius.circular(8))),
            child: FormBuilderDropdown<String>(
              attribute: attribute,
              validators: validators,
              onChanged: (value) => onChanged(value.toString()),
              items: items
                  .map((e) => DropdownMenuItem(
                        child: ScreenUtils.customText(data: e),
                        value: e,
                      ))
                  .toList(),
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  submit() async {
    String token = await SharedPrefHelper().getWithDefault("token", "");
    print(token);

    List<String> holidays = List();

    holidaysList.forEach((element) {
      holidays.add(CommonUtils.getSimpleDateForApi(element));
    });

    StockCheckRequest request = StockCheckRequest(
        mealPlanId: widget.rows.id.toString(),
        quantity: quantityValue.toString(),
        holidays: holidays.join(",").toString(),
        startDate: CommonUtils.getSimpleDateForApi(datePeriod.start).toString(),
        endDate: CommonUtils.getSimpleDateForApi(datePeriod.end).toString());

    if (selectionType == RangeSelectionType.Weekly) {
      request.duration = "weekly";
    } else if (selectionType == RangeSelectionType.Monthly) {
      request.duration = "monthly";
    } else {
      request.duration = "custom";
    }

    request.preferred_delivery_time = prefferedTime.toString();

    CommonUtils.fullScreenProgress(context);
    NetworkUtil().post(url: ApiConfig.userCheckStockAvailable, token: token, body: jsonEncode(request)).then((res) {
      CommonUtils.dismissProgressDialog(context);
      CheckOutResponse response = CheckOutResponse.fromJson(res);

      if (response.status == 200) {
        CommonUtils.showToast(msg: "Confirmed Subscription", bgColor: Colors.black, textColor: Colors.white);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Checkout(
                    stockCheckOutResponse: response,
                    stockCheckRequest: request,
                  )),
        );
      } else {
        CommonUtils.showToast(
            msg: "We are fully booked. Kindly choose another date.", bgColor: Colors.black, textColor: Colors.white);
      }
    }).catchError((error) {
      CommonUtils.dismissProgressDialog(context);
      CommonUtils.showToast(
          msg: "Something went wrong , Please try again", bgColor: Colors.red, textColor: Colors.white);
    });
  }

  void getMealName() async {
    mealPlanController.text = widget.rows.mealName;
  }

  bool _validateInput() {
    if (_fbKey.currentState.validate()) {
      // If all data are correct then save data to out variables
      _fbKey.currentState.save();
      return true;
    } else {
      // If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
      return false;
    }
  }
}
