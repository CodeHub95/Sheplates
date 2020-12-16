import 'dart:async';
import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/Routes.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/modals/request/PauseSubscriptionRequest.dart';
import 'package:flutter_sheplates/modals/request/ReactiveSubscriptionRequest.dart';
import 'package:flutter_sheplates/modals/response/BaseResponse.dart';
import 'package:flutter_sheplates/modals/response/PauseScreenDataResponse.dart';
import 'package:flutter_sheplates/ui/DrawerScreen.dart';

class PauseSubscription extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<PauseSubscription> {
  bool pause;

  int oID;
  String status;
  String startDate;
  String endDate;
  String resume_subscription_date;
  String pause_subscription_date;
  StreamController<PauseScreenDataResponse> _streamController =
      StreamController.broadcast();
  DateTime selectedDate = DateTime.now();

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    getPauseList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _streamController?.close();
  }

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
        body: StreamBuilder<PauseScreenDataResponse>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container(
                    child: SingleChildScrollView(
                        child: Column(children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: 30, right: 30, top: 30, bottom: 50),
                      child: Container(
                        height: 210,
                        width: MediaQuery.of(context).size.width,
                        child: DottedBorder(
                          padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
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
                                  snapshot.data.data.address.fullAddress != null
                                      ? snapshot.data.data.address.fullAddress
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
                                      snapshot.data.data.order.mealsServed
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
                                      (snapshot.data.data.order.totalMealCount -
                                              snapshot
                                                  .data.data.order.mealsServed)
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
                      )),
                  Container(
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 10),
                      height: 50,
                      width: 400,
                      child: RaisedButton(
                          textColor: Colors.white,
                          color: HexColor("#FF5657"),
                          child: Text(
                            // status==pause ? 'Pause' : 'Reactive Pause',
                            pause ? 'Pause' : 'Reactive',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          // onPressed: _showcontent,
                          onPressed: pause
                              ? () async {
                                  setState(() {
                                    // pause = !pause;

                                    if (pause)
                                      pause = false;
                                    else
                                      pause = true;
                                  });

                                  selectedDate = await _selectDate(context,
                                      lastDate: DateTime.parse(endDate));

                                  _showcontent();
                                }
                              : () async {
                                  selectedDate = await _selectDate(context);
                                  reactiveSubcription();
                                })),
                  Visibility(
                      visible:
                          snapshot.data.data.order.resumeSubscriptionDate !=
                                  "0000-00-00" ||
                              snapshot.data.data.order.pauseSubscriptionDate !=
                                  "0000-00-00",
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                              text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "Note:",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: " Your Subscription Will be",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 15.0)),
                            TextSpan(
                                text: pause ? 'Paused' : 'Reactivated',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 15.0)),
                            TextSpan(
                                text: " from\n ",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 15.0)),
                            TextSpan(
                                text: pause
                                    ? CommonUtils.getDate(
                                        CommonUtils.getDateTime(
                                                pause_subscription_date)
                                            .toIso8601String())
                                    : CommonUtils.getDate(
                                        CommonUtils.getDateTime(
                                                resume_subscription_date
                                                    .toString())
                                            .toIso8601String()),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0)),
                          ])),
                        ],
                      ))
                ])));
              }
            }));
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
                        onPressed: () => Navigator.pop(context)),
                  ],
                ),
                Text(
                  'Do You want Pause Your\n Subscription',
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
                              // setState(() {
                              //   pause= !pause;
                              // });
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
    PauseSubscriptionRequest request = PauseSubscriptionRequest(
      token: token,
      pause_subscription_date:
          CommonUtils.getPauseDate(selectedDate.toIso8601String()),
      orderId: oID.toInt(),
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
      Navigator.pop(context);
    } else {
      CommonUtils.errorMessage(msg: response.message);
      CommonUtils.dismissProgressDialog(context);
    }
  }

  Future<void> reactiveSubcription() async {
    CommonUtils.fullScreenProgress(context);
    String url = "user/reactive-subscription";
    String token = await SharedPrefHelper().getWithDefault("token", "");

    ReactiveSubscriptionRequest request = ReactiveSubscriptionRequest(
        orderId: oID,
        resume_subscription_date:
            CommonUtils.getPauseDate(selectedDate.toIso8601String()));
    var res = await NetworkUtil()
        .post(url: url, body: jsonEncode(request), token: token);
    BaseResponse response = BaseResponse.fromJson(res);
    if (response.status == 200) {
      CommonUtils.dismissProgressDialog(context);
      CommonUtils.showToast(
          msg: "Successfully Reactive",
          bgColor: AppColor.darkThemeBlueColor,
          textColor: Colors.white);
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.homeScreen, (route) => false);
    } else {
      CommonUtils.errorMessage(msg: response.message);
      CommonUtils.dismissProgressDialog(context);
    }
  }

  getPauseList() async {
    String token = await SharedPrefHelper().getWithDefault("token", "");
    print(token);

    var res = await NetworkUtil().get("user/pause-page", token: token);
    PauseScreenDataResponse pauseScreenDataResponse =
        PauseScreenDataResponse.fromJson(res);
    if (pauseScreenDataResponse.status == 200) {
      _streamController.sink.add(pauseScreenDataResponse);
      startDate = pauseScreenDataResponse.data.order.startDate;
      endDate = pauseScreenDataResponse.data.order.endDate;
      pause_subscription_date =
          pauseScreenDataResponse.data.order.pauseSubscriptionDate;
      resume_subscription_date =
          pauseScreenDataResponse.data.order.resumeSubscriptionDate;
      oID = pauseScreenDataResponse.data.order.id;
      status = pauseScreenDataResponse.data.order.status;
      pause = (status == "Active" ? true : false);
      if (pauseScreenDataResponse.data.address == null ||
          pauseScreenDataResponse.data.order == null) {
        CommonUtils.showToast(
            msg: "Do not have any ActiveSubscription Plan",
            bgColor: AppColor.darkThemeBlueColor,
            textColor: Colors.white);
      }
    } else {
      CommonUtils.errorMessage(msg: pauseScreenDataResponse.message);
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
