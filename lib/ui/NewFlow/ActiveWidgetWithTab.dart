import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/modals/response/MySubscriptionsResponse.dart';
import 'package:flutter_sheplates/ui/ActiveWidgetTabDataCopy.dart';

class ActiveWidgetWithTab extends StatefulWidget {
  List<Subscription> activeSubscriptionList;
  ActiveWidgetWithTab(this.activeSubscriptionList);
  @override
  ActiveWidgetWithTabState createState() => ActiveWidgetWithTabState(activeSubscriptionList);
}

class ActiveWidgetWithTabState extends State<ActiveWidgetWithTab> {
  List<Subscription> activeSubscriptionList;
  ActiveWidgetWithTabState(this.activeSubscriptionList);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: DefaultTabController(
        length: 5,
        child: activeSubscriptionList.isEmpty
            ? Center(child: Text("You don't have any active subscription"))
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
                    ActiveWidgetTabDataCopy(activeSubscriptionList
                        .where((element) => element.orders[0].catalog.mealCategory.category == "BreakFast")
                        .toList()),
                    ActiveWidgetTabDataCopy(activeSubscriptionList
                        .where((element) => element.orders[0].catalog.mealCategory.category == "Lunch")
                        .toList()),
                    ActiveWidgetTabDataCopy(activeSubscriptionList
                        .where((element) => element.orders[0].catalog.mealCategory.category == "Snacks")
                        .toList()),
                    ActiveWidgetTabDataCopy(activeSubscriptionList
                        .where((element) => element.orders[0].catalog.mealCategory.category == "Dinner")
                        .toList()),
                    ActiveWidgetTabDataCopy(activeSubscriptionList),
                  ],
                ),
              ),
      ),
    );
  }

  Text buildTab(String tabTitle) => Text(tabTitle, style: TextStyle(fontSize: 17, color: Colors.black));
}
