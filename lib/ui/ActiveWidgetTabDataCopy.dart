import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/modals/response/MySubscriptionsResponse.dart';
import 'package:intl/intl.dart';

class ActiveWidgetTabDataCopy extends StatefulWidget {
  List<dynamic> activeSubscriptionList;
  ActiveWidgetTabDataCopy(this.activeSubscriptionList);
  @override
  _ActiveWidgetTabDataCopyState createState() => _ActiveWidgetTabDataCopyState(activeSubscriptionList);
}

class _ActiveWidgetTabDataCopyState extends State<ActiveWidgetTabDataCopy> {
  List<Order> activeSubscriptionList;
  _ActiveWidgetTabDataCopyState(this.activeSubscriptionList);
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      activeSubscriptionList == null || activeSubscriptionList.length==0
          ? Center(child: Text("You don't have this subscription"))
          :
        Padding(
              padding: EdgeInsets.only(top: 10),
              child: ListView.builder(
                itemCount: activeSubscriptionList.length,
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
                                      activeSubscriptionList[index].catalog.mealName.toString(),
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            body: Container(
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
                                                  // activeSubscriptionList[index]
                                                  //     .orders[0]
                                                  //     .kitchen
                                                  //     .kitchenName
                                                  //     .toString(),
                                                  activeSubscriptionList[index].kitchen.kitchenName,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(color: Colors.red, fontSize: 20),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(top: 10),
                                                    child: Text(
                                                        "${activeSubscriptionList[index].kitchen.zone.zoneName.toString()}" +
                                                            ", " +
                                                            '${activeSubscriptionList[index].kitchen.zone.city.toString()}')),
                                                Padding(
                                                    padding: EdgeInsets.only(top: 10),
                                                    child: Text(
                                                      'fssaiNumber: ' +
                                                          activeSubscriptionList[index].kitchen.fssaiNumber,
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.only(top: 10),
                                                    child: Text(
                                                      'Order ID: ' +
                                                          activeSubscriptionList[index]
                                                              .transaction
                                                              .razorpayOrderId
                                                              .toString(),
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                    )),
                                                Padding(padding: EdgeInsets.only(top: 10)),
                                                Text(
                                                  activeSubscriptionList[index]
                                                      .catalog
                                                      .mealCategory
                                                      .category
                                                      .toString(),
                                                  style: TextStyle(fontSize: 25),
                                                ),
                                                Padding(padding: EdgeInsets.only(top: 10)),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Expire on: ",
                                                      style: TextStyle(fontSize: 15),
                                                    ),
                                                    Text(
                                                      DateFormat("dd/MM/yyyy").format(DateTime.parse(
                                                          activeSubscriptionList[index].endDate.toString())),
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
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Duration: ',
                                              style: TextStyle(color: Colors.grey, fontSize: 16),
                                            ),
                                            Text(
                                              activeSubscriptionList[index].duration.toString(),
                                              style: TextStyle(color: Colors.black, fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      color: Colors.grey[200],
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Start Date: ',
                                              style: TextStyle(color: Colors.grey, fontSize: 16),
                                            ),
                                            Text(
                                              DateFormat("MM/dd/yyyy").format(DateTime.parse(
                                                  activeSubscriptionList[index].startDate.toString())),
                                              style: TextStyle(color: Colors.black, fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 80,
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Amount Paid: ',
                                              style: TextStyle(color: Colors.grey, fontSize: 16),
                                            ),
                                            Text(
                                              activeSubscriptionList[index].totalAmount.toString(),
                                              style: TextStyle(color: Colors.black, fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      color: Colors.grey[200],
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Meals served: ',
                                              style: TextStyle(color: Colors.grey, fontSize: 16),
                                            ),
                                            Text(
                                              activeSubscriptionList[index].mealsServed.toString(),
                                              style: TextStyle(color: Colors.black, fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 80,
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Meals Remaining: ',
                                              style: TextStyle(color: Colors.grey, fontSize: 16),
                                            ),
                                            Text(
                                              (activeSubscriptionList[index].totalMealCount -
                                                      activeSubscriptionList[index].mealsServed)
                                                  .toString(),
                                              style: TextStyle(color: Colors.black, fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            isExpanded: activeSubscriptionList[index].isExpanded,
                          )
                        ],
                        expansionCallback: (int item, bool status) => setState(
                              () =>
                                  activeSubscriptionList[index].isExpanded = !activeSubscriptionList[index].isExpanded,
                            )),
                  );
                },
              ),
            ),
    );
  }
}
