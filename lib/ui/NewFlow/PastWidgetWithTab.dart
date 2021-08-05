import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/modals/response/MySubscriptionsResponse.dart';
import 'package:flutter_sheplates/ui/PastWidgetTabDataCopy.dart';

class PastWidgetWithTabs extends StatefulWidget {
  List<PastSubscription> pastSubscriptionList;
  PastWidgetWithTabs(this.pastSubscriptionList);
  @override
  _PastWidgetWithTabsState createState() => _PastWidgetWithTabsState(pastSubscriptionList);
}

class _PastWidgetWithTabsState extends State<PastWidgetWithTabs> {
  List<PastSubscription> pastSubscriptionList;
  _PastWidgetWithTabsState(this.pastSubscriptionList);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: DefaultTabController(
        length: 5,
        child: pastSubscriptionList == null
            ? Center(child: CircularProgressIndicator())
            : pastSubscriptionList.isEmpty
                ? Center(child: Text("You don't have any past subscription"))
                : Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.white,
                      automaticallyImplyLeading: false,
                      elevation: 5,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(10),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            TabBar(
                              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                              isScrollable: true,
                              labelPadding: EdgeInsets.all(10),
                              indicator: UnderlineTabIndicator(
                                insets: EdgeInsets.all(6),
                                borderSide: BorderSide(color: AppColor.themeButtonColor, width: 2),
                              ),
                              tabs: [
                                buildTab("Breakfast"),
                                buildTab("Lunch"),
                                buildTab("Snacks"),
                                buildTab("Dinner"),
                                buildTab("All Day"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    body: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        PastWidgetTabDataCopy(pastSubscriptionList
                            .where((element) => element.orders[0].catalog.mealCategory.category == "Breakfast")
                            .toList()),
                        PastWidgetTabDataCopy(pastSubscriptionList
                            .where((element) => element.orders[0].catalog.mealCategory.category == "Lunch")
                            .toList()),
                        PastWidgetTabDataCopy(pastSubscriptionList
                            .where((element) => element.orders[0].catalog.mealCategory.category == "Snacks")
                            .toList()),
                        PastWidgetTabDataCopy(pastSubscriptionList
                            .where((element) => element.orders[0].catalog.mealCategory.category == "Dinner")
                            .toList()),
                        PastWidgetTabDataCopy(pastSubscriptionList),
                      ],
                    ),
                  ),
      ),
    );
  }

  Text buildTab(String tabTitle) => Text(tabTitle, style: TextStyle(fontSize: 17, color: Colors.black));
}
