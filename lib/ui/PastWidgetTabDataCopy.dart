import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

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
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: pastSubscriptionList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ExpansionPanelList(
                  children: [
                    ExpansionPanel(
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded) => Center(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                pastSubscriptionList[index].orders[0].catalog.mealCategory.toString(),
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                      body: Container(
                        // height: 50,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 30, right: 30, top: 30),
                                child: Container(
                                  // height: 250,
                                  width: MediaQuery.of(context).size.width,
                                  child: DottedBorder(
                                    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                    dashPattern: [5, 2],
                                    child: Container(
                                      width: double.maxFinite,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(padding: EdgeInsets.only(top: 10)),
                                          Text(
                                            pastSubscriptionList[index].orders[0].kitchen.toString(),
                                            style: TextStyle(color: Colors.red, fontSize: 20),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(top: 10), child: Text("Zone" + ", " + 'City')),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text(
                                              'fssaiNumber',
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text(
                                              pastSubscriptionList[index]
                                                  .orders[0]
                                                  .transaction
                                                  .razorpayOrderId
                                                  .toString(),
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(padding: EdgeInsets.only(top: 10)),
                                          Text(
                                            pastSubscriptionList[index].orders[0].catalog.mealCategory.toString(),
                                            style: TextStyle(fontSize: 25),
                                          ),
                                          Padding(padding: EdgeInsets.only(top: 10)),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Expire on ",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              Text(
                                                pastSubscriptionList[index].orders[0].endDate.toString(),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 30)),
                              Container(
                                height: 80,
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        'Duration: ',
                                        style: TextStyle(color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    Text(
                                      pastSubscriptionList[index].orders[0].duration.toString(),
                                      style: TextStyle(color: Colors.black, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 50,
                                color: Colors.grey[200],
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        'Start Date: ',
                                        style: TextStyle(color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    Text(
                                      pastSubscriptionList[index].orders[0].startDate.toString(),
                                      style: TextStyle(color: Colors.black, fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 80,
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        'Amount Paid: ',
                                        style: TextStyle(color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    Text(
                                      pastSubscriptionList[index].orders[0].totalAmount.toString(),
                                      style: TextStyle(color: Colors.black, fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 50,
                                color: Colors.grey[200],
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        'Meals served: ',
                                        style: TextStyle(color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    Text(
                                      pastSubscriptionList[index].orders[0].mealsServed.toString(),
                                      style: TextStyle(color: Colors.black, fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 80,
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        'Meals Remaining: ',
                                        style: TextStyle(color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    Text(
                                      (pastSubscriptionList[index].orders[0].totalMealCount -
                                              pastSubscriptionList[index].orders[0].mealsServed)
                                          .toString(),
                                      style: TextStyle(color: Colors.black, fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      isExpanded: pastSubscriptionList[index].isExpanded,
                    )
                  ],
                  expansionCallback: (int item, bool status) => setState(
                        () => pastSubscriptionList[index].isExpanded = !pastSubscriptionList[index].isExpanded,
                      )),
            );
          },
        ),
      ),
    );
  }
}
