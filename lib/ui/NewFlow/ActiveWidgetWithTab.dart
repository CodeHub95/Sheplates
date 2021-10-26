import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/modals/response/MySubscriptionsResponse.dart';
import 'package:flutter_sheplates/ui/ActiveWidgetTabDataCopy.dart';

class ActiveWidgetWithTab extends StatefulWidget {
  List<dynamic> activeSubscriptionList;
  ActiveWidgetWithTab(this.activeSubscriptionList);
  @override
  ActiveWidgetWithTabState createState() => ActiveWidgetWithTabState(activeSubscriptionList);
}

class ActiveWidgetWithTabState extends State<ActiveWidgetWithTab> {
  List<dynamic> activeSubscriptionList;
  ActiveWidgetWithTabState(this.activeSubscriptionList);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: DefaultTabController(
        length: 5,
        child:
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

                    ActiveWidgetTabDataCopy(
                activeSubscriptionList!=null && activeSubscriptionList.isNotEmpty?
                        activeSubscriptionList
                        .where((element) => element.orders[0].catalog.mealCategory.category == "Breakfast")
                        .toList(): null

                    ),
                    ActiveWidgetTabDataCopy(
                        activeSubscriptionList!=null &&  activeSubscriptionList.isNotEmpty?
                        activeSubscriptionList
                        .where((element) => element.orders[0].catalog.mealCategory.category == "Lunch")
                        .toList(): null),
                    ActiveWidgetTabDataCopy(
                        activeSubscriptionList!=null && activeSubscriptionList.isNotEmpty?
                        activeSubscriptionList
                        .where((element) => element.orders[0].catalog.mealCategory.category == "Snacks")
                        .toList():null),
                    ActiveWidgetTabDataCopy(
                        activeSubscriptionList!=null &&  activeSubscriptionList.isNotEmpty?
                        activeSubscriptionList
                        .where((element) => element.orders[0].catalog.mealCategory.category == "Dinner")
                        .toList(): null),
                    ActiveWidgetTabDataCopy(
                        activeSubscriptionList!=null && activeSubscriptionList.isNotEmpty?
                        activeSubscriptionList: null),
                  ],
                ),
              ),
      ),
    );
  }

  Text buildTab(String tabTitle) => Text(tabTitle, style: TextStyle(fontSize: 17, color: Colors.black));
}
