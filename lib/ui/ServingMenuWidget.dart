import 'dart:async';
import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/modals/response/MenuResponse.dart';
import 'package:intl/intl.dart';

class ServingMenuWidget extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ServingMenuWidget> {
  StreamController<MenuResponse> _controller = StreamController.broadcast();

  @override
  // ignore: missing_return
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    getList();
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
              width: MediaQuery.of(context).size.width,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(children: [
                      Padding(
                          padding: EdgeInsets.only(
                            top: 30,
                            right: 10,
                            left: 10,
                          ),
                          child: Container(
                              height: MediaQuery.of(context).size.height / 1.1,
                              decoration: BoxDecoration())),
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/menu_listing.png"))),
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 70)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      // snapshot.data.data.obj.kitchen,
                                      snapshot.data.data.obj.kitchen != null
                                          ? snapshot.data.data.obj.kitchen
                                              .toString()
                                          : '',
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.red),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          snapshot.data.data.obj.kitchen != null
                                              ? snapshot
                                                  .data.data.obj.kitchenAddress
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
                                    top: 10, right: 30, left: 30),
                                child: Container(
                                    height: 10,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                                "assets/arrow_menu.png"))))),
                            Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      toBeginningOfSentenceCase(snapshot
                                          .data.data.obj.mealName
                                          .toString()),
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.red),
                                    )
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(top: 30, left: 30),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: Text(
                                                  'Duration: ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                )),
                                            Text(
                                              toBeginningOfSentenceCase(snapshot
                                                  .data.data.obj.duration
                                                  .toString()),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 22)),
                                        Row(
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: Text(
                                                  'Start Date: ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                )),
                                            Text(
                                              snapshot.data.data.obj.startDate
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 22)),
                                        Row(
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: Text(
                                                  'Amount paid: ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                )),
                                            Text(
                                              snapshot.data.data.obj.amountPaid
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 22)),
                                        Row(
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: Text(
                                                  'Meals Served: ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                )),
                                            Text(
                                              snapshot.data.data.obj.mealsServed
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 22)),
                                        Row(
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: Text(
                                                  'Meals Remaining: ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                )),
                                            Text(
                                              snapshot
                                                  .data.data.obj.mealsRemaining
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                  left: 25,
                                  right: 25,
                                  top: 45,
                                ),
                                child: Container(
                                    height: 150,
                                    width: MediaQuery.of(context).size.width,
                                    child: DottedBorder(
                                        color: Colors.white,
                                        padding:
                                            EdgeInsets.fromLTRB(30, 10, 30, 0),
                                        dashPattern: [5, 2],
                                        child: Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10)),
                                              Align(
                                                child: Center(
                                                  child: Text(
                                                    "Serving Today",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 23),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 20)),
                                              Text(
                                                snapshot
                                                    .data.data.obj.servingToday
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              ),
                                            ]))))),
                            SizedBox(
                              height: 80,
                            )
                          ],
                        ),
                      ),
                    ]),
                  ]));
        }
      },
    )));
  }

  // ignore: missing_return
  Future<Obj> getList() async {
    String token = await SharedPrefHelper().getWithDefault("token", "");
    var res = await NetworkUtil().get("user/my-menu", token: token);
    MenuResponse menuResponse = MenuResponse.fromJson(res);
    if (menuResponse.status == 200) {
      _controller.sink.add(menuResponse);
      if (menuResponse.data == null) {
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
}
