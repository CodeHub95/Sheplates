import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/modals/response/HomeListResponse.dart';
import 'package:flutter_sheplates/ui/DrawerScreen.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/ui/NewFlow/NewConfirmSubscription.dart';
import 'package:flutter_sheplates/ui/NewFlow/NextWeekScreen.dart';

class MealDetailScreen extends StatefulWidget {
  final Rows mealDetails;
  final bool isSuscribed;
  final String categoryname;
  final int maincategoryId;
  const MealDetailScreen({Key key, this.mealDetails, this.isSuscribed, this.categoryname, this.maincategoryId}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MealDetailScreen> {
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
              widget.mealDetails.mealName,
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
          child: SingleChildScrollView(
            physics:  NeverScrollableScrollPhysics(),
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


                              child: Padding(
                                padding: EdgeInsets.only(top: 5, left: 30, right: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget.mealDetails.menu.monday2 != null
                                        ? WeekSeparator(weekName: "Current Week")
                                        : Container(),

                                      SingleChildScrollView(
                                          // physics: const NeverScrollableScrollPhysics(),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Day(dayName: "Monday:"),
                                       Meal(mealName: widget.mealDetails.menu.monday),
                                       Day(dayName: "Tuesday:"),
                                       Meal(mealName: widget.mealDetails.menu.tuesday),
                                       Day(dayName: "Wednesday:"),
                                       Meal(mealName: widget.mealDetails.menu.wednesday),
                                       Day(dayName: "Thursday:"),
                                       Meal(mealName: widget.mealDetails.menu.thrusday),
                                       Day(dayName: "Friday:"),
                                       Meal(mealName: widget.mealDetails.menu.friday),
                                       Day(dayName: "Saturday:"),
                                       Meal(mealName: widget.mealDetails.menu.saturday),
                                       Padding(
                                         padding: EdgeInsets.only(top: 10),
                                         child: Text(
                                           widget.mealDetails.menu.sunday != null && widget.mealDetails.menu.sunday != ""
                                               ? "Sunday:"
                                               : "",
                                           style: TextStyle(fontSize: 20, color: Colors.red),
                                         ),
                                       ),
                                       Container(
                                         width: MediaQuery.of(context).size.width / 1.1,
                                         child: Text(
                                             widget.mealDetails.menu.sunday != null && widget.mealDetails.menu.sunday != ""
                                                 ? widget.mealDetails.menu.sunday
                                                 : "",
                                             maxLines: 3,
                                             style: TextStyle(fontSize: 14, color: Colors.white)),
                                       ),
                                     ],
                                   ),
                                    ),


                                  ],
                                ),
                              ),

                          )
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                  ],
                ),

                widget.mealDetails.menu.monday2 != null ? WeekTwoButton(widget: widget) : Container(),
                ScreenUtils.customButton(
                  context,
                  title: "Subscribe",
                  onCLick: () {
                    mealName = widget.mealDetails.mealName;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewConfirmSubscription(widget.mealDetails, widget.categoryname, widget.maincategoryId),
                      ),
                    );
                  },
                ),
              ],
            ),
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

  final MealDetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child:  Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .10),
            SizedBox(
              width: MediaQuery.of(context).size.width * .44,
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                color: AppColor.themeButtonColor,
                textColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Next Week", style: TextStyle(fontSize: 15)),
                    Icon(Icons.arrow_forward, size: 20),
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NextWeekScreen(snapshotData: widget)));
                },
              ),
            ),
          ],
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
          Container(height: 1, width: MediaQuery.of(context).size.width * .10, color: Colors.grey),
          Text("  $weekName  ", style: TextStyle(fontSize: 20, color: Colors.grey)),
          Container(height: 1, width: MediaQuery.of(context).size.width * .10, color: Colors.grey),
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
