import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/modals/response/MySubscriptionsResponse.dart';
import 'package:flutter_sheplates/ui/PastWidgetTabDataCopy.dart';

class PastWidgetWithTabs extends StatefulWidget {
  List<Subscription> pastSubscriptionList;
  PastWidgetWithTabs(this.pastSubscriptionList);
  @override
  _PastWidgetWithTabsState createState() => _PastWidgetWithTabsState(pastSubscriptionList);
}

class _PastWidgetWithTabsState extends State<PastWidgetWithTabs> {
  List<Subscription> pastSubscriptionList;
  _PastWidgetWithTabsState(this.pastSubscriptionList);
  List<Order> brea = [];
  List<Order> lun = [];
  List<Order> snac = [];
  List<Order> dinn = [];
  List<Order> al = [];
  @override
  void initState() {
    // TODO: implement initState
    getList();
    super.initState();
  }
  void getList() {
    for (int j = 0; j < pastSubscriptionList.length; j++)
      for (int i = 0; i < pastSubscriptionList[j].orders.length; i++)
        if (pastSubscriptionList[j].orders[i].catalog.mealCategory.category == "Breakfast") {
          brea.add(pastSubscriptionList[j].orders[i]);
        }
    for (int j = 0; j < pastSubscriptionList.length; j++)
      for (int i = 0; i < pastSubscriptionList[j].orders.length; i++)
        if (pastSubscriptionList[j].orders[i].catalog.mealCategory.category == "Lunch") {
          lun.add(pastSubscriptionList[j].orders[i]);
        }
    for (int j = 0; j < pastSubscriptionList.length; j++)
      for (int i = 0; i < pastSubscriptionList[j].orders.length; i++)
        if (pastSubscriptionList[j].orders[i].catalog.mealCategory.category == "Snacks") {
          snac.add(pastSubscriptionList[j].orders[i]);
        }
    for (int j = 0; j < pastSubscriptionList.length; j++)
      for (int i = 0; i < pastSubscriptionList[j].orders.length; i++)
        if (pastSubscriptionList[j].orders[i].catalog.mealCategory.category == "Dinner") {
          dinn.add(pastSubscriptionList[j].orders[i]);
        }
    for (int j = 0; j < pastSubscriptionList.length; j++)
      for (int i = 0; i < pastSubscriptionList[j].orders.length; i++)
        al.add(pastSubscriptionList[j].orders[i]);

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: DefaultTabController(
        length: 5,
        child:
        // pastSubscriptionList == null
        //     ? Center(child: CircularProgressIndicator())
        //     : pastSubscriptionList.isEmpty
        //         ? Center(child: Text("You don't have any past subscription"))
        //         :
        Scaffold(
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
              PastWidgetTabDataCopy(
                  pastSubscriptionList.isNotEmpty?brea
                  // pastSubscriptionList
                  //     .where((element) => element.orders[0].catalog.mealCategory.category == "Breakfast")
                  //     .toList()
                      : null

              ),
              PastWidgetTabDataCopy(
                  pastSubscriptionList.isNotEmpty?lun
                  // pastSubscriptionList
                  //     .where((element) => element.orders[0].catalog.mealCategory.category == "Lunch")
                  //     .toList()
                      : null
              ),
              PastWidgetTabDataCopy(
                  pastSubscriptionList.isNotEmpty?snac
                  // pastSubscriptionList
                  //     .where((element) => element.orders[0].catalog.mealCategory.category == "Snacks")
                  //     .toList()
                      : null
              ),
              PastWidgetTabDataCopy(
                  pastSubscriptionList.isNotEmpty?dinn
                  // pastSubscriptionList
                  //     .where((element) => element.orders[0].catalog.mealCategory.category == "Dinner")
                  //     .toList()
                      : null),
              PastWidgetTabDataCopy(
                  pastSubscriptionList.isNotEmpty?
                  al: null
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text buildTab(String tabTitle) => Text(tabTitle, style: TextStyle(fontSize: 17, color: Colors.black));
}
