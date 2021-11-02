import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/modals/response/MySubscriptionsResponse.dart';
import 'package:flutter_sheplates/ui/NewFlow/NewPauseScreen.dart';

class SubscriptionForPauseAndReactive extends StatefulWidget {
  const SubscriptionForPauseAndReactive({Key key}) : super(key: key);

  @override
  _SubscriptionForPauseAndReactiveState createState() =>
      _SubscriptionForPauseAndReactiveState();
}

class _SubscriptionForPauseAndReactiveState
    extends State<SubscriptionForPauseAndReactive> {
  StreamController<MySubscriptionResponse> _listcontroller =
      StreamController.broadcast();
  bool isExpanded = false;
  List<Order> orders = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMySubscriptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 30),
            child: Text(
              "Your subscriptions",
              style: TextStyle(color: Colors.black, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * .1),
                  Expanded(child: Container(color: Colors.grey, height: .5)),
                  Text(
                    " Choose a subscription",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                  Expanded(child: Container(color: Colors.grey, height: .5)),
                  SizedBox(width: MediaQuery.of(context).size.width * .1),
                ],
              ),
            ),
            StreamBuilder<MySubscriptionResponse>(
                stream: _listcontroller.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    );
                  if (snapshot.data.data.activeSubscription.isNotEmpty) {
                    return Container(
                      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                      height: MediaQuery.of(context).size.height * .7,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: ListView.builder(
                          itemCount:
                              snapshot.data.data.activeSubscription.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: ExpansionPanelList(
                                  children: [
                                    ExpansionPanel(
                                      canTapOnHeader: true,
                                      headerBuilder: (BuildContext context,
                                              bool isExpanded) =>
                                          Center(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: Text(
                                                "Subscription ID: " +
                                                    snapshot
                                                        .data
                                                        .data
                                                        .activeSubscription[
                                                            index]
                                                        .sheplatesOrderId,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      body: Container(
                                        // color: Colors.grey,

                                        width:
                                            MediaQuery.of(context).size.width,
                                        // height: 150,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10),
                                          child: Container(
                                            height: 150,
                                            child: ListView.builder(
                                              itemCount: snapshot
                                                  .data
                                                  .data
                                                  .activeSubscription[index]
                                                  .orders
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int i) {
                                                return Center(
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => NewPauseScreen(
                                                                  snapshot.data.data.activeSubscription[index].orders[i],
                                                                  snapshot.data.data.activeSubscription[index].sheplatesOrderId
                                                              )),
                                                        );
                                                      },
                                                        child: Card(
                                                            color: Colors
                                                                .grey[100],
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        15),
                                                                child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          SingleChildScrollView(
                                                                            scrollDirection:
                                                                                Axis.vertical,
                                                                            child: Container(
                                                                                width: MediaQuery.of(context).size.width / 2,
                                                                                child: Text(
                                                                                  snapshot.data.data.activeSubscription[index].orders[i].catalog.mealName,
                                                                                  style: TextStyle(color: Colors.black),
                                                                                )),
                                                                          ),
                                                                          RichText(
                                                                              text: TextSpan(children: <TextSpan>[
                                                                            TextSpan(
                                                                                text: "Status: ",
                                                                                style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold)),
                                                                            TextSpan(
                                                                                text: snapshot.data.data.activeSubscription[index].orders[i].status,
                                                                                style: TextStyle(
                                                                                  color: Colors.red,
                                                                                  fontSize: 15.0,
                                                                                )),
                                                                          ])),
                                                                        ],
                                                                      ),
                                                                    ])))));
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      isExpanded: snapshot
                                                  .data
                                                  .data
                                                  .activeSubscription[index]
                                                  .isExpanded ==
                                              null
                                          ? false
                                          : snapshot
                                              .data
                                              .data
                                              .activeSubscription[index]
                                              .isExpanded,
                                    )
                                  ],
                                  expansionCallback: (int item, bool status) =>
                                      setState(() => snapshot
                                              .data
                                              .data
                                              .activeSubscription[index]
                                              .isExpanded = snapshot
                                                      .data
                                                      .data
                                                      .activeSubscription[index]
                                                      .isExpanded ==
                                                  null
                                              ? true
                                              : !snapshot
                                                  .data
                                                  .data
                                                  .activeSubscription[index]
                                                  .isExpanded
                                          // !menuData[index].isExpanded ,
                                          )),
                            );
                          },
                        ),
                      ),
                    );
                  } else
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: Center(
                            child: Text(
                                "You don't have any active subscription")));
                })
          ],
        ),
      ),
    );
  }

  Future<void> fetchMySubscriptions() async {
    String token = await SharedPrefHelper().getWithDefault("token", "");
    var res = await NetworkUtil().get("user/my-subscription", token: token);
    MySubscriptionResponse mySubscriptionResponse =
        MySubscriptionResponse.fromJson(res);
    if (mySubscriptionResponse.status == 200) {
      // CommonUtils.dismissProgressDialog(context);
      if (mySubscriptionResponse.data == null) {
        _listcontroller.sink.addError(mySubscriptionResponse.message);
        CommonUtils.showToast(
            msg: "Do not have any ActiveSubscription Plan",
            bgColor: AppColor.darkThemeBlueColor,
            textColor: Colors.white);
      } else {
        // CommonUtils.dismissProgressDialog(context);
        setState(() {
          _listcontroller.sink.add(mySubscriptionResponse);
        });
      }
    } else {
      // CommonUtils.dismissProgressDialog(context);
      CommonUtils.showToast(msg: mySubscriptionResponse.message);
      _listcontroller.sink.addError(mySubscriptionResponse.message);
    }
    print("**************** subscription data ***************");
  }
}
