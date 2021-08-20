import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PastWidgetTabDataCopy extends StatefulWidget {
  List<dynamic> pastSubscriptionList;
  PastWidgetTabDataCopy(this.pastSubscriptionList);
  @override
  _PastWidgetTabDataCopyState createState() => _PastWidgetTabDataCopyState(pastSubscriptionList);
}

class _PastWidgetTabDataCopyState extends State<PastWidgetTabDataCopy> {
  List<dynamic> pastSubscriptionList;
  _PastWidgetTabDataCopyState(this.pastSubscriptionList);
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pastSubscriptionList.length == 0
          ? Center(child: Text("You don't have this subscription"))
          : Padding(
              padding: EdgeInsets.only(top: 10),
              child: ListView.builder(
                itemCount: pastSubscriptionList.length,
                itemBuilder: (BuildContext context, int index) {
                  for(int i =0; i<=pastSubscriptionList[index].orders.length; i++ ) {
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
                                          padding: EdgeInsets.only(left: 20),
                                          child: Text(
                                            pastSubscriptionList[index]
                                                .orders[i].catalog.mealName
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              body: Container(
                                // height: 50,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                margin: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 10, right: 10),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 30, right: 30, top: 30),
                                        child: Container(
                                          // height: 250,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          child: DottedBorder(
                                            padding: EdgeInsets.fromLTRB(
                                                5, 10, 5, 10),
                                            dashPattern: [5, 2],
                                            child: Container(
                                              width: double.maxFinite,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10)),
                                                  Text(
                                                    pastSubscriptionList[index]
                                                        .orders[i].kitchen.kitchenName
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 20),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10),
                                                      child: Text(
                                                          "Zone" + ", " +
                                                              'City')),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    child: Text(
                                                      'fssaiNumber' +
                                                          pastSubscriptionList[index]
                                                              .orders[0].kitchen
                                                              .fssaiNumber,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    child: Text(
                                                      'Order ID: ' +
                                                          pastSubscriptionList[index]
                                                              .orders[i]
                                                              .transaction
                                                              .razorpayOrderId
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10)),
                                                  Text(
                                                    pastSubscriptionList[index]
                                                        .orders[i].catalog
                                                        .mealCategory.category
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 25),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10)),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      Text(
                                                        "Expire on: ",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      Text(
                                                        DateFormat("dd/MM/yyyy")
                                                            .format(
                                                            DateTime.parse(
                                                                pastSubscriptionList[index]
                                                                    .orders[0]
                                                                    .endDate
                                                                    .toString())),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 30)),
                                      Container(
                                        height: 80,
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                'Duration: ',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                pastSubscriptionList[index]
                                                    .orders[0].duration
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        color: Colors.grey[200],
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                'Start Date: ',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                DateFormat("MM/dd/yyyy").format(
                                                    DateTime.parse(
                                                        pastSubscriptionList[index]
                                                            .orders[0].startDate
                                                            .toString())),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 80,
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                'Amount Paid: ',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                pastSubscriptionList[index]
                                                    .orders[0].totalAmount
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        color: Colors.grey[200],
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                'Meals served: ',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                pastSubscriptionList[index]
                                                    .orders[0].mealsServed
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 80,
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                'Meals Remaining: ',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                (pastSubscriptionList[index]
                                                    .orders[0].totalMealCount -
                                                    pastSubscriptionList[index]
                                                        .orders[0].mealsServed)
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              isExpanded: pastSubscriptionList[index]
                                  .isExpanded,
                            )
                          ],
                          expansionCallback: (int item, bool status) =>
                              setState(
                                    () =>
                                pastSubscriptionList[index].isExpanded =
                                !pastSubscriptionList[index].isExpanded,
                              )),
                    );
                  }  },
              ),
            ),
    );
  }
}
