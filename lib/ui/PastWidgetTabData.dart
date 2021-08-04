import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class PastWidgetTabData extends StatefulWidget {
  List<dynamic> pastSubscriptionList;
  PastWidgetTabData(this.pastSubscriptionList);
  @override
  _PastWidgetTabDataState createState() => _PastWidgetTabDataState(pastSubscriptionList);
}

class _PastWidgetTabDataState extends State<PastWidgetTabData> {
  List<dynamic> pastSubscriptionList;
  _PastWidgetTabDataState(this.pastSubscriptionList);
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: pastSubscriptionList.isEmpty
            ? Center(child: Text("No data found"))
            : Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                    height: MediaQuery.of(context).size.height * .7,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: pastSubscriptionList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Card(
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width / 1.5,
                                        child: Text(
                                          pastSubscriptionList[index].orders[0].catalog.mealCategory.toString(),
                                          style: TextStyle(color: Colors.black, fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: (isExpanded
                                          ? Padding(
                                              padding: EdgeInsets.only(bottom: 10),
                                              child: Icon(Icons.minimize, color: Colors.grey))
                                          : Icon(Icons.add, color: Colors.grey)),
                                      onPressed: () => setState(
                                        () => isExpanded = !isExpanded,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: isExpanded,
                              child: Container(
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
                                                      padding: EdgeInsets.only(top: 10),
                                                      child: Text("Zone" + ", " + 'City')),
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
                                                    pastSubscriptionList[index]
                                                        .orders[0]
                                                        .catalog
                                                        .mealCategory
                                                        .toString(),
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
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
