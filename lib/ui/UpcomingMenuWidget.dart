import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/Routes.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/modals/request/ChefChangeRequest.dart';
import 'package:flutter_sheplates/modals/response/BaseResponse.dart';
import 'package:flutter_sheplates/modals/response/MenuResponse.dart';
import 'package:intl/intl.dart';

class UpcomingMenuWidget extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<UpcomingMenuWidget> {
  StreamController<MenuResponse> _controller = StreamController();
  int id;
  var day;

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    getList();
    day = DateFormat('EEEE').format(DateTime.now());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controller?.close();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SingleChildScrollView(
            child: StreamBuilder<MenuResponse>(
                stream: _controller.stream,
                builder: (context, snapshot) {
                  print("build");
                  if (!snapshot.hasData)
                    return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ));
                  if (snapshot.data.data.obj == null) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: Text(
                                "Not Available",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black),
                              )),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/bg_menu.png"))),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Stack(children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                    right: 10,
                                    left: 10,
                                  ),
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.1,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  "assets/menu_listing.png"))))),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(padding: EdgeInsets.only(top: 65)),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              snapshot.data.data.obj.kitchen !=
                                                      null
                                                  ? snapshot
                                                      .data.data.obj.kitchen
                                                      .toString()
                                                  : '',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  color: Colors.red),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Text(
                                                  snapshot.data.data.obj
                                                              .kitchen !=
                                                          null
                                                      ? snapshot.data.data.obj
                                                          .kitchenAddress
                                                          .toString()
                                                      : '',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white),
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 0, right: 30, left: 30),
                                        child: Container(
                                            height: 10,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: AssetImage(
                                                        "assets/arrow_menu.png"))))),
                                    Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              snapshot.data.data.obj.mealName,
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.red),
                                            )
                                          ],
                                        )),
                                    Padding(
                                        padding:
                                            EdgeInsets.only(top: 10, left: 30),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Monday:",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.red),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.2,
                                                  child: Text(
                                                    snapshot.data.data.obj.menu
                                                        .monday,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                    maxLines: 3,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 20),
                                                  child: Text("Tuesday:",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.red)),
                                                ),
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.2,
                                                    child: Text(
                                                      snapshot.data.data.obj
                                                          .menu.tuesday,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                      maxLines: 3,
                                                    )),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 20),
                                                  child: Text("Wednesday:",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.red)),
                                                ),
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.2,
                                                    child: Text(
                                                      snapshot.data.data.obj
                                                          .menu.wednesday,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                      maxLines: 3,
                                                    )),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 20),
                                                  child: Text("Thursday:",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.red)),
                                                ),
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.2,
                                                    child: Text(
                                                      snapshot.data.data.obj
                                                          .menu.thrusday,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                      maxLines: 3,
                                                    )),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 20),
                                                  child: Text("Friday:",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.red)),
                                                ),
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.2,
                                                    child: Text(
                                                      snapshot.data.data.obj
                                                          .menu.friday,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                      maxLines: 3,
                                                    )),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 20),
                                                  child: Text("Saturday:",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.red)),
                                                ),
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.2,
                                                    child: Text(
                                                      snapshot.data.data.obj
                                                          .menu.friday,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                      maxLines: 3,
                                                    )),
                                              ],
                                            )
                                          ],
                                        )),
                                  ]),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.2,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Container(
                                        height: 90,
                                        child: Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: AssetImage(
                                                          "assets/chef_btn.png"))),
                                              height: 90,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.3,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 120, top: 15),
                                                child: Text(
                                                  DateFormat('EEEE')
                                                      .format(DateTime.now()),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20,
                                                  ),
                                                )),
                                            Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    30, 40, 30, 0),
                                                child: FlatButton(
                                                    textColor: Colors.white,
                                                    child: Text(
                                                      'Change Chef Request',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      submit();
                                                    }))
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ]),
                          ],
                        ));
                  }
                })));
  }

  void _showcontent() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          contentPadding: EdgeInsets.all(0),
          content: new SingleChildScrollView(
              child: Container(
            height: 130,
            child: new Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 20.0,
                          color: Colors.black,
                        ),
                        onPressed: () => {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                Routes.homeScreen,
                                (route) => false,
                              )
                              // Navigator.pop(context)
                            }),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      'Your Request will be Processed in 24 hours',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          )),
        );
      },
    );
  }

  Future<Obj> getList() async {
    String token = await SharedPrefHelper().getWithDefault("token", "");
    var res = await NetworkUtil().get("user/my-menu", token: token);
    MenuResponse menuResponse = MenuResponse.fromJson(res);

    if (menuResponse.status == 200) {
      _controller.sink.add(menuResponse);
      id = menuResponse.data.obj.subscriptionPlanId;
      if (menuResponse.data.obj == null) {
        CommonUtils.showToast(
            msg: "Do not have any ActiveSubscription Plan",
            bgColor: AppColor.darkThemeBlueColor,
            textColor: Colors.white);
      }
    } else {
      CommonUtils.dismissProgressDialog(context);
      CommonUtils.showToast(msg: menuResponse.message);
    }
  }

  Future<void> submit() async {
    CommonUtils.fullScreenProgress(context);
    String url = "user/change-chef-request";
    int subid = id;
    String token = await SharedPrefHelper().getWithDefault("token", "");
    ChefChangeRequest request = ChefChangeRequest(
      subscription_plan_id: subid,
    );
    var res = await NetworkUtil()
        .post(url: url, body: jsonEncode(request), token: token);
    BaseResponse response = BaseResponse.fromJson(res);
    if (response.status == 200) {
      _showcontent();
    } else {
      CommonUtils.errorMessage(msg: response.message);
      CommonUtils.dismissProgressDialog(context);
    }
  }
}
