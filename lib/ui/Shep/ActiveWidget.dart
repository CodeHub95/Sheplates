import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/app_constants.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/modals/response/SubscriptionResponse.dart';
import 'package:intl/intl.dart';
class ActiveWidget extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ActiveWidget> {

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    getSubscriptionList();
  }

  StreamController<List<ActiveSubscription>> _streamController =
  StreamController.broadcast();

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
        body: Container(
            child: StreamBuilder<List<ActiveSubscription>>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    );
                  }
                  else {
                    return Container(
                        child: SingleChildScrollView(
                          child: Column(

                            children: [
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                      child: Column(children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 30, right: 30, top: 30),
                                            child: Container(
                                              // height: 250,
                                              width:
                                              MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width,
                                              child: DottedBorder(
                                                padding: EdgeInsets.fromLTRB(
                                                    5, 10, 5, 10),
                                                dashPattern: [5, 2],

                                                child: Container(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,

                                                    children: [
                                                      Padding(
                                                          padding: EdgeInsets
                                                              .only(top: 10)),

                                                      Text(
                                                        snapshot.data[index]
                                                            .kitchen != null ?
                                                        snapshot.data[index]
                                                            .kitchen.kitchenName
                                                            .toString() : '',
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 20),
                                                      ),

                                                      Padding(
                                                          padding: EdgeInsets
                                                              .only(top: 10,),

                                                          child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .center,
                                                              children: [Text(
                                                                  snapshot
                                                                      .data[index]
                                                                      .kitchen !=
                                                                      null
                                                                      ?
                                                                  // snapshot
                                                                  //     .data[index]
                                                                  //     .kitchen
                                                                  //     .address
                                                                  //     .toString()
                                                                  snapshot.data[index].kitchen.zone.zoneName.toString() +", "+ snapshot.data[index].kitchen.zone.city.toString()
                                                                      : ''),
                                                              ])),
                                                      Padding(
                                                          padding: EdgeInsets
                                                              .only(top: 10,),

                                                          child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .center,
                                                              children: [Text(
                                                                  snapshot
                                                                      .data[index]
                                                                      .kitchen !=
                                                                      null
                                                                      ?
                                                                  // snapshot
                                                                  //     .data[index]
                                                                  //     .kitchen
                                                                  //     .address
                                                                  //     .toString()
                                                                  snapshot.data[index].kitchen.fssaiNumber.toString()
                                                                      : '',
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.bold),),

                                                              ])),
                                                      Padding(
                                                          padding: EdgeInsets
                                                              .only(top: 10,),

                                                          child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .center,
                                                              children: [Text(
                                                                snapshot
                                                                    .data[index]
                                                                    .kitchen !=
                                                                    null
                                                                    ?
                                                                // snapshot
                                                                //     .data[index]
                                                                //     .kitchen
                                                                //     .address
                                                                //     .toString()
                                                                snapshot.data[index].transaction.razorpayOrderId.toString()
                                                                    : '',
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold),),

                                                              ])),
                                                      Padding(
                                                          padding: EdgeInsets
                                                              .only(top: 10)),
                                                      Text(
                                                        snapshot.data[index]
                                                            .catalog.mealName
                                                            .toString(),

                                                        style: TextStyle(
                                                            fontSize: 25),
                                                      ),
                                                      Padding(
                                                          padding: EdgeInsets
                                                              .only(top: 10)),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .center,
                                                        children: [

                                                          Text(
                                                            "Expires on ",
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                          ),

                                                          Text(
                                                              CommonUtils
                                                                  .getSimpleDate(
                                                                  DateTime
                                                                      .parse(
                                                                      snapshot
                                                                          .data[index]
                                                                          .endDate)))
                                                        ],)
                                                    ],
                                                  ),
                                                  width: double.maxFinite,
                                                  decoration: BoxDecoration(),
                                                ),
                                              ),
                                            )),
                                        Padding(
                                            padding: EdgeInsets.only(top: 30)),
                                        Container(
                                            height: 80,
                                            color: Colors.transparent,
                                            child: Row(children: [
                                              Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      left: 20),
                                                  child: Text(
                                                    'Duration: ',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 16),
                                                  )),
                                              Text(
                                                  toBeginningOfSentenceCase( snapshot.data[index].duration),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16, ),
                                              ),
                                            ])),

                                        Container(
                                            height: 50,
                                            color: Colors.grey[200],
                                            child: Row(
                                              children: [
                                                Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        left: 20),
                                                    child: Text(
                                                      'Start Date: ',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16),
                                                    )),
                                                Text(
                                                  snapshot.data[index]
                                                      .startDate,

                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                )
                                              ],
                                            )),
                                        Container(
                                            height: 80,
                                            color: Colors.transparent,
                                            child: Row(
                                              children: [
                                                Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        left: 20),
                                                    child: Text(
                                                      'Amount Paid: ',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16),
                                                    )),
                                                Text(
                                                  snapshot.data[index]
                                                      .totalAmount
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                )
                                              ],
                                            )),
                                        Container(
                                            height: 50,
                                            color: Colors.grey[200],
                                            child: Row(
                                              children: [
                                                Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        left: 20),
                                                    child: Text(
                                                      'Meals served: ',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16),
                                                    )),
                                                Text(
                                                  snapshot.data[index]
                                                      .mealsServed
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                )
                                              ],
                                            )),
                                        Container(
                                            height: 80,
                                            color: Colors.transparent,

                                            child: Row(
                                              children: [
                                                Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        left: 20),
                                                    child: Text(
                                                      'Meals Remaining: ',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16),
                                                    )),
                                                Text(
                                                  (snapshot.data[index]
                                                      .totalMealCount -
                                                      snapshot.data[index]
                                                          .mealsServed)
                                                      .toString(),

                                                  style:
                                                  TextStyle(color: Colors.black,
                                                      fontSize: 16),
                                                )
                                              ],
                                            ))
                                      ])
                                  );
                                })
                          ],),
                        ));
                  }
                })));
  }

  Future<ActiveSubscription> getSubscriptionList() async {
    String token = await SharedPrefHelper().getWithDefault("token", "");
    print(token);
    var res = await NetworkUtil().get("user/my-subscription", token: token);
    SubscriptionResponse response = SubscriptionResponse.fromJson(res);
    if (response.status == 200) {
      _streamController.sink.add(response.data.activeSubscription);
      if (response.data.activeSubscription.isEmpty == true) {
        CommonUtils.showToast(
            msg: "Do not have any ActiveSubscription Plan",
            bgColor: AppColor.darkThemeBlueColor,
            textColor: Colors.white);
      }
    }
  }

}
