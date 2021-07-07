import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/modals/response/HomeListResponse.dart';
import 'package:flutter_sheplates/ui/ConfirmSubscription.dart';
import 'package:flutter_sheplates/ui/DrawerScreen.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/ui/weekTwoScreen.dart';

class VegitarianLunch extends StatefulWidget {
  final Rows rows;
  final bool suscriber;

  const VegitarianLunch({Key key, this.rows, this.suscriber}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<VegitarianLunch> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final color = Theme.of(context).accentColor;

    String mealName;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 20),
            child: Text(
              widget.rows.mealName,
              style: TextStyle(color: Colors.black, fontSize: 17),
              textAlign: TextAlign.center,
            ),
          ),
        ),
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
        child: Container(
          // height:  MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(fit: BoxFit.fill, image: AssetImage("assets/bg_menu.png")
                  // image: AssetImage(
                  //     "assets/menu_listing.png")
                  )),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    // height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        image: DecorationImage(fit: BoxFit.fill, image: AssetImage("assets/menu_listing.png"))),
                    // height: MediaQuery.of(context).size.height,
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 40)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "QUALITY",
                                  style: TextStyle(fontSize: 25, color: Colors.white),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "A Taste of Home Made Food",
                                      style: TextStyle(fontSize: 17, color: Colors.white),
                                    ))
                              ],
                            )
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 10, right: 30, left: 30),
                            child: Container(
                                height: 10,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill, image: AssetImage("assets/arrow_menu.png"))))),
                        Container(
                          // height: MediaQuery.of(context).size.height / 1.2,
                          height: MediaQuery.of(context).size.height,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(top: 5, left: 30, right: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  widget.rows.menu.monday2 != null ? WeekSeparator(weekName: "Week 1") : Container(),
                                  Day(dayName: "Monday:"),
                                  Meal(mealName: widget.rows.menu.monday),
                                  Day(dayName: "Tuesday:"),
                                  Meal(mealName: widget.rows.menu.tuesday),
                                  Day(dayName: "Wednesday:"),
                                  Meal(mealName: widget.rows.menu.wednesday),
                                  Day(dayName: "Thursday:"),
                                  Meal(mealName: widget.rows.menu.thrusday),
                                  Day(dayName: "Friday:"),
                                  Meal(mealName: widget.rows.menu.friday),
                                  Day(dayName: "Saturday:"),
                                  Meal(mealName: widget.rows.menu.saturday),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      widget.rows.menu.sunday != null && widget.rows.menu.sunday != "" ? "Sunday:" : "",
                                      style: TextStyle(fontSize: 20, color: Colors.red),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width / 1.1,
                                    child: Text(
                                        widget.rows.menu.sunday != null && widget.rows.menu.sunday != ""
                                            ? widget.rows.menu.sunday
                                            : "",
                                        maxLines: 3,
                                        style: TextStyle(fontSize: 14, color: Colors.white)),
                                  ),
                                  widget.rows.menu.monday2 != null ? WeekTwoButton(widget: widget) : Container(),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                ],
              ),
              ScreenUtils.customButton(
                context,
                title: "Subscribe",
                onCLick: () {
                  if (widget.suscriber) {
                    CommonUtils.showToast(
                      msg: "You have already one subscription plan running!",
                      bgColor: Colors.black,
                      textColor: Colors.white,
                    );
                  } else {
                    mealName = widget.rows.mealName;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmSubscription(widget.rows),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeekTwoButton extends StatelessWidget {
  const WeekTwoButton({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final VegitarianLunch widget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .14),
        height: 35,
        width: MediaQuery.of(context).size.width / 2.45,
        child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          color: AppColor.themeButtonColor,
          textColor: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Week 2 meals", style: TextStyle(fontSize: 15)),
              Icon(Icons.arrow_forward, size: 20),
            ],
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => WeekTwoScreen(snapshotData: widget)));
          },
        ),
      ),
    );
  }
}

class WeekSeparator extends StatelessWidget {
  final weekName;
  WeekSeparator({this.weekName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30, bottom: 40),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(height: 1, width: MediaQuery.of(context).size.width * .15, color: Colors.grey),
          Text("  $weekName  ", style: TextStyle(fontSize: 20, color: Colors.grey)),
          Container(height: 1, width: MediaQuery.of(context).size.width * .15, color: Colors.grey),
        ],
      )),
    );
  }
}

class Day extends StatelessWidget {
  final String dayName;
  Day({this.dayName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Text(dayName, style: TextStyle(fontSize: 20, color: Colors.red)),
    );
  }
}

class Meal extends StatelessWidget {
  const Meal({
    Key key,
    @required this.mealName,
  }) : super(key: key);

  final String mealName;

  @override
  Widget build(BuildContext context) {
    return Text(mealName, maxLines: 3, style: TextStyle(fontSize: 14, color: Colors.white));
  }
}
