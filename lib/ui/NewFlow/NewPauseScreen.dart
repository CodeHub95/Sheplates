import 'dart:async';
import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/Routes.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/modals/request/NewPauseRequest.dart';
import 'package:flutter_sheplates/modals/request/NewReactiveRequest.dart';
import 'package:flutter_sheplates/modals/request/PauseSubscriptionRequest.dart';
import 'package:flutter_sheplates/modals/request/ReactiveSubscriptionRequest.dart';
import 'package:flutter_sheplates/modals/response/BaseResponse.dart';
import 'package:flutter_sheplates/modals/response/MySubscriptionsResponse.dart';
import 'package:flutter_sheplates/modals/response/PauseScreenDataResponse.dart';
import 'package:flutter_sheplates/ui/DrawerScreen.dart';
import 'package:flutter_sheplates/ui/HomeScreen.dart';
import 'package:flutter_sheplates/ui/NewFlow/SubscriptionForPauseAndReactive.dart';
import 'package:intl/intl.dart';
class NewPauseScreen extends StatefulWidget {
  Subscription activeSubscription;

  NewPauseScreen(this.activeSubscription);

  @override
  _HomeScreenState createState() => _HomeScreenState(this.activeSubscription);
}

class _HomeScreenState extends State<NewPauseScreen> {
  bool pause;
  int oID;
  String status;
  String startDate;
  String endDate;
  String resume_subscription_date;
  String pause_subscription_date;
  List<int> idd =[];
  // StreamController<PauseScreenDataResponse> _streamController =
  //     StreamController.broadcast();
  DateTime selectedDate = DateTime.now();

  _HomeScreenState(this.activeSubscription);
  Subscription activeSubscription;

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    // getPauseList();
    if(mounted) {
      activeStatus = activeSubscription.orders[0].status.toString();

      setState(() {
        pause = activeStatus == "Active" ? true : false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _streamController?.close();
  }
  String pauseSubscriptionDate;
  String resumeSubscriptionDate;
  String activeStatus;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
              child: Padding(
                  padding: EdgeInsets.only(
                    right: 20,
                  ),
                  child: Text(
                    "Pause My Subscription",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                    textAlign: TextAlign.center,
                  ))),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Image.asset(
                "assets/left_menu.png",
                fit: BoxFit.fill,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          bottom: PreferredSize(
              child: Container(
                color: Colors.grey,
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0)),
        ),
        body:
    Container(
                    child: SingleChildScrollView(
                        child: Column(children: [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: activeSubscription.orders.length,
                              itemBuilder: (BuildContext context, int index) {
                                pauseSubscriptionDate= activeSubscription.orders[0].pauseSubscriptionDate.toString();
                                resumeSubscriptionDate = activeSubscription.orders[0].resumeSubscriptionDate.toString();
                                print("-------------" + resumeSubscriptionDate.toString());
                                activeStatus = activeSubscription.orders[index].status.toString();
                                idd.add(activeSubscription.orders[index].id);
                                pause = activeStatus=="Active"? true: false;
                                endDate = activeSubscription.orders[0].endDate.toString();
                                startDate = activeSubscription.orders[0].startDate.toString();
                                return
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 30, right: 30, top: 30, bottom: 50),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: DottedBorder(
                                          padding: EdgeInsets.fromLTRB(20, 25, 20, 20),
                                          dashPattern: [5, 2],
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Delivery Address",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                Padding(padding: EdgeInsets.only(top: 20)),
                                                Text(
                                                  activeSubscription.orders[0].userAddress!= null
                                                      ? activeSubscription.orders[0].userAddress.area
                                                      .toString()
                                                      : '',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                Padding(padding: EdgeInsets.only(top: 20)),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                        const EdgeInsets.only(left: 20),
                                                        child: Text(
                                                          'Meals Delivered: ',
                                                          style: TextStyle(
                                                              fontSize: 18, color: Colors.grey),
                                                        )),
                                                    Text(
                                                      activeSubscription.orders[index].mealsServed
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 18, color: Colors.black),
                                                    )
                                                  ],
                                                ),
                                                Padding(padding: EdgeInsets.only(top: 15)),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                        const EdgeInsets.only(left: 20),
                                                        child: Text(
                                                          'Meals Remaining: ',
                                                          style: TextStyle(
                                                              fontSize: 18, color: Colors.grey),
                                                        )),
                                                    Text(
                                                      (activeSubscription.orders[index].totalMealCount  -
                                                          activeSubscription.orders[index].mealsServed )
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 18, color: Colors.black),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            width: double.maxFinite,
                                            decoration: BoxDecoration(),
                                          ),
                                        ),
                                      ));}
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(50, 0, 50, 10),
                              height: 50,
                              width: 400,
                              child: RaisedButton(
                                  textColor: Colors.white,
                                  color: HexColor("#FF5657"),
                                  child: Text(
                                 activeSubscription.orders[0].status.toString()=="Active"?
                                    // pause==true
                                    // activeStatus =="Active"
                                  // ?
                                 'Pause' : 'Reactivate',
                                    // pause ? 'Pause' : 'Reactivate',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),

                                  onPressed: activeSubscription.orders[0].status.toString()=="Active"?pause==true: pause==false
                                      ? () async {
                                    selectedDate = await _selectDate(context,
                                        lastDate: DateTime.parse(endDate));
                                    if (selectedDate != null) {
                                      setState(() {
                                        if (pause)
                                          pause = false;
                                        else
                                          pause = true;
                                      });
                                      _showcontent();
                                    }
                                  }
                                      : () async {
                                    selectedDate = await _selectDate(context);
                                    if (selectedDate != null) {
                                      reactiveSubcription();
                                    }
                                  }
                                  )),
                          Visibility(
                              visible:
                              // activeSubscription.orders !=
                              //     "0000-00-00" ||
                              //     pauseSubscriptionDate !=
                              //         "0000-00-00" ||
                              // pauseSubscriptionDate.toString()!=null || resumeSubscriptionDate.toString()!=null ||
                                      pauseSubscriptionDate.toString()!= "1970-01-01 00:00:00.000" || resumeSubscriptionDate.toString() !="1970-01-01 00:00:00.000"  ,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                margin: EdgeInsets.all(8.0),
                                padding: EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.info),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5.0),
                                        child: RichText(
                                            maxLines: 3,
                                            text: TextSpan(children: <TextSpan>[
                                              TextSpan(
                                                  text: "Note:",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold)),
                                              TextSpan(
                                                  text:pause
                                                      && pauseSubscriptionDate.compareTo(DateTime.now().toString())>0
                                                      ? " Your Subscription Will be ":
                                                  !pause
                                                      && resumeSubscriptionDate.toString().compareTo(DateTime.now().toString())>0?
                                                  " Your Subscription Will be ":
                                                  " Your Subscription is ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.0)),
                                              TextSpan(
                                                  text:
                                                  pause &&
                                                      pauseSubscriptionDate.compareTo(DateTime.now().toString())>0 ?
                                                  // &&
                                                  // snapshot.data.data.order.resumeSubscriptionDate != "0000-00-00"?
                                                  'Paused' : !pause &&
                                                      resumeSubscriptionDate.toString().compareTo(DateTime.now().toString()) >0?
                                                  'Reactivated':
                                                  !pause &&
                                                     pauseSubscriptionDate.compareTo(DateTime.now().toString()) !="0000-00-00" ?
                                                  // &&
                                                  // snapshot.data.data.order.resumeSubscriptionDate != "0000-00-00"?
                                                  'Paused':
                                                  "Reactivated",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.0)),
                                              TextSpan(
                                                  text:
                                                  // pause ?
                                                  // && snapshot.data.data.order.resumeSubscriptionDate.compareTo(DateTime.now().toString())>0
                                                  // && snapshot.data.data.order.resumeSubscriptionDate != "0000-00-00"?
                                                  // " from ":
                                                  pause && pauseSubscriptionDate.compareTo(DateTime.now().toString())==0 ? " " :
                                                  !pause && resumeSubscriptionDate.toString().compareTo(DateTime.now().toString())>0 ?
                                                  " from ":
                                                  pause && pauseSubscriptionDate.compareTo(DateTime.now().toString())>0 ?
                                                  " from ":''
                                                  ,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.0)),
                                              TextSpan(
                                                  text: pause && pauseSubscriptionDate.compareTo(DateTime.now().toString())>0?

                                                  pauseSubscriptionDate:
                                                  !pause && resumeSubscriptionDate.toString().compareTo(DateTime.now().toString())>0?
                                                  // DateFormat(
                                                  //     "MM/dd/yyyy")
                                                  //     .format(
                                                  //     DateTime
                                                  //         .parse(
                                                          resumeSubscriptionDate.toString()
                                                      // ))
                                                  :
                                                  " "
                                                  ,
                                                  // snapshot.data.data.order.resumeSubscriptionDate != "0000-00-00" ?
                                                  //     " "
                                                  // '' : snapshot.data.data.order.resumeSubscriptionDate,


                                                  // pause
                                                  //     && snapshot.data.data.order.resumeSubscriptionDate.compareTo(DateTime.now().toString())>0
                                                  //     ?
                                                  // snapshot.data.data.order.resumeSubscriptionDate != "0000-00-00"?
                                                  //
                                                  //      CommonUtils.getSimpleDate(
                                                  //         DateTime.parse(
                                                  //             resume_subscription_date)): CommonUtils.getSimpleDate(
                                                  //     DateTime.parse(
                                                  //         pause_subscription_date)): "",


                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15.0)),
                                            ])),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          )
                        ]))));
               // else if (snapshot.hasError);
            //    {
            //     return Container(
            //       width: MediaQuery.of(context).size.width,
            //       height: MediaQuery.of(context).size.height,
            //       child: Column(
            //         mainAxisSize: MainAxisSize.max,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Image.asset("assets/not_delivering.png"),
            //           Padding(
            //             padding: const EdgeInsets.only(top: 20.0),
            //             child: ScreenUtils.customText(data: snapshot.error),
            //           )
            //         ],
            //       ),
            //     );
            //   } else {
            //     return Container(
            //       width: MediaQuery.of(context).size.width,
            //       height: MediaQuery.of(context).size.height,
            //       alignment: Alignment.center,
            //       child: CircularProgressIndicator(),
            //     );
            //   }
            // }));
  }

  void _showcontent() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          contentPadding: EdgeInsets.all(0.0),
          content: new SingleChildScrollView(
              child: Container(
                height: 170,
                child: new Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      //change here don't //worked
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 20.0,
                              color: Colors.black,
                            ),
                            onPressed: () => {

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SubscriptionForPauseAndReactive(),
                                  ),
                                  (Route<dynamic> route) => false)
                            }),
                      ],
                    ),
                    Text(
                      'Do You want to Pause Your\n Subscription',
                      style: TextStyle(fontWeight: FontWeight.bold),

                      textAlign: TextAlign.center,
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: Container(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                            height: 40,
                            width: 400,
                            child: RaisedButton(
                                color: HexColor("#FF5657"),
                                textColor: Colors.white,
                                child: Text(
                                  'Confirm',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                onPressed: () {
                                  submit();
                                }))),
                  ],
                ),
              )),
        );
      },
    );
  }

  Future<void> submit() async {
    CommonUtils.fullScreenProgress(context);
    String url = "user/pause-subscription";
    String token = await SharedPrefHelper().getWithDefault("token", "");

    NewPauseRequest request = NewPauseRequest(
      pauseSubscriptionDate:
      CommonUtils.getPauseDate(selectedDate.toIso8601String()),
      orderId: idd,
    );
    var res = await NetworkUtil()
        .post(url: url, body: jsonEncode(request), token: token);
    BaseResponse response = BaseResponse.fromJson(res);
    if (response.status == 200) {
      CommonUtils.dismissProgressDialog(context);
      CommonUtils.showToast(
          msg: "Paused Successfully",
          bgColor: AppColor.darkThemeBlueColor,
          textColor: Colors.white);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
              (Route<dynamic> route) => false);
    } else {
      CommonUtils.errorMessage(msg: response.message);
      CommonUtils.dismissProgressDialog(context);
    }
  }

  Future<void> reactiveSubcription() async {
    CommonUtils.fullScreenProgress(context);
    String url = "user/reactive-subscription";
    String token = await SharedPrefHelper().getWithDefault("token", "");

    NewReactiveRequest request = NewReactiveRequest(
        orderId: idd,
        resumeSubscriptionDate:
        CommonUtils.getPauseDate(selectedDate.toIso8601String()));
    print("dateeeee" + selectedDate.toIso8601String());
    var res = await NetworkUtil()
        .post(url: url, body: jsonEncode(request), token: token);
    BaseResponse response = BaseResponse.fromJson(res);
    if (response.status == 200) {
      CommonUtils.dismissProgressDialog(context);
      CommonUtils.showToast(
          msg: "Successfully Reactivated Subscription.",
          bgColor: AppColor.darkThemeBlueColor,
          textColor: Colors.white);
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.homeScreen, (route) => false);
    } else {
      CommonUtils.errorMessage(msg: response.message);
      CommonUtils.dismissProgressDialog(context);
    }
  }



  Future<DateTime> _selectDate(BuildContext context,
      {DateTime startDate, DateTime initialDate, DateTime lastDate}) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: initialDate != null
            ? initialDate
            : DateTime.now().add(Duration(days: 1)),
        firstDate: startDate != null
            ? startDate
            : DateTime.now().add(Duration(days: 1)),
        lastDate: lastDate != null ? lastDate : DateTime.parse(endDate));
    if (picked != null && picked != selectedDate) return picked;
  }
}
