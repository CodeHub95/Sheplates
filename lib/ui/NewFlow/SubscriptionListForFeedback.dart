import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/modals/response/DeliveredMealResponse.dart';
import '../Feedback.dart';

class SubscriptionListForFeedback extends StatefulWidget {
  const SubscriptionListForFeedback({Key key}) : super(key: key);

  @override
  _SubscriptionListForFeedbackState createState() => _SubscriptionListForFeedbackState();
}

class _SubscriptionListForFeedbackState extends State<SubscriptionListForFeedback> {
  StreamController<DeliveredMealListResponse> _streamController = StreamController.broadcast();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeliveredMeal();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _streamController?.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:
            Text("Delivered meals", style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.center),
        centerTitle: true,
        elevation: 5,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, top: 10, right: 10),
        height: MediaQuery.of(context).size.height * .7,
        child: StreamBuilder<DeliveredMealListResponse>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              CircularProgressIndicator();
            }
            if (snapshot.data ==null) {
              print('project snapshot data is: ${snapshot.data}');
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset("assets/not_delivering.png"),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: ScreenUtils.customText(
                          data: "You Don't have any Delivered Meal", textAlign: TextAlign.center),
                    ),

                    // this button is just for navigatig to feedback screen for testing
                    // RaisedButton(
                    //     onPressed: () => Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => FeedBack(
                    //                 // idd: snapshot.data.data[index].id,
                    //                 // startDate: snapshot.data.data[index].startDate.toString(),
                    //                 // endDate: snapshot.data.data[index].endDate.toString(),
                    //                 // feedbackAsMap: snapshot.data.data[index].feedback,
                    //                 )))),
                  ],
                ),
              );
            } else
            return Container(
              height:MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child:
              // Column(
              //   children: [
                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 50),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       SizedBox(width: MediaQuery.of(context).size.width * .1),
                  //       Expanded(child: Container(color: Colors.grey, height: .5)),
                  //       Text(
                  //         " Choose a meal for feedback",
                  //         style: TextStyle(
                  //           fontSize: 17,
                  //           color: Colors.grey,
                  //           fontWeight: FontWeight.w700,
                  //           letterSpacing: 1,
                  //         ),
                  //       ),
                  //       Expanded(child: Container(color: Colors.grey, height: .5)),
                  //       SizedBox(width: MediaQuery.of(context).size.width * .1),
                  //     ],
                  //   ),
                  // ),
                  ListView.builder(
                    itemCount: snapshot.data.data.length,
                    itemBuilder: (context, index) {
                      return

                        Container(
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
                                      " Choose a meal for feedback",
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
                              GestureDetector(
                              child: Card(
                                child: Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                                        // child: Container(
                                        //   width: MediaQuery.of(context).size.width / 1.5,
                                          child: Text(
                                            snapshot.data.data[index].catalog.mealName.toString(),
                                            style: TextStyle(color: Colors.black, fontSize: 15),
                                          ),
                                        // ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Text("Meal Id:" + snapshot.data.data.lastPlanFeedback[index].id.toString())

                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FeedBack(
                                              idd: snapshot.data.data[index].id,
                                              startDate: snapshot.data.data[index].startDate.toString(),
                                              endDate: snapshot.data.data[index].endDate.toString(),
                                              feedbackAsMap: snapshot.data.data[index].feedback,
                                            )));
                              },
                      ),
                            ],
                          ),
                        );
                    },
                  ),
              //   ],
              // ),
            );
          },
        ),
        // child: ListView.builder(
        //   itemCount: 15,
        //   itemBuilder: (context, index) {
        //     return Card(
        //       child: ListTile(
        //         onTap: () {
        //           Navigator.push(
        //               context, MaterialPageRoute(builder: (context) => FeedBack(subscriptionID: index + 1)));
        //         },
        //         leading: Icon(Icons.food_bank),
        //         title: Text("Meal ${index + 1}"),
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }

  getDeliveredMeal() async {
    String token = await SharedPrefHelper().getWithDefault("token", "");
    var res = await NetworkUtil().get("user/deliveredMeals", token: token);
    DeliveredMealListResponse deliveredMealListResponse = DeliveredMealListResponse.fromJson(res);
    if (deliveredMealListResponse.status == 200) {
      _streamController.sink.add(deliveredMealListResponse);
    } else {
      _streamController.sink.add(deliveredMealListResponse);
    }
  }
}
