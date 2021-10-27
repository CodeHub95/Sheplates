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
  List<Subscription> activeSubscriptionList;
  ActiveWidgetWithTabState(this.activeSubscriptionList);
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
    for (int j = 0; j < activeSubscriptionList.length; j++)
      for (int i = 0; i < activeSubscriptionList[j].orders.length; i++)
      if (activeSubscriptionList[j].orders[i].catalog.mealCategory.category == "Breakfast") {
        brea.add(activeSubscriptionList[j].orders[i]);
      }
    for (int j = 0; j < activeSubscriptionList.length; j++)
      for (int i = 0; i < activeSubscriptionList[j].orders.length; i++)
    if (activeSubscriptionList[j].orders[i].catalog.mealCategory.category == "Lunch") {
      lun.add(activeSubscriptionList[j].orders[i]);
    }
    for (int j = 0; j < activeSubscriptionList.length; j++)
      for (int i = 0; i < activeSubscriptionList[j].orders.length; i++)
    if (activeSubscriptionList[j].orders[i].catalog.mealCategory.category == "Snacks") {
      snac.add(activeSubscriptionList[j].orders[i]);
    }
    for (int j = 0; j < activeSubscriptionList.length; j++)
      for (int i = 0; i < activeSubscriptionList[j].orders.length; i++)
    if (activeSubscriptionList[j].orders[i].catalog.mealCategory.category == "Dinner") {
      dinn.add(activeSubscriptionList[j].orders[i]);
    }
    for (int j = 0; j < activeSubscriptionList.length; j++)
      for (int i = 0; i < activeSubscriptionList[j].orders.length; i++)
          al.add(activeSubscriptionList[j].orders[i]);

  }
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

                activeSubscriptionList!=null && activeSubscriptionList.isNotEmpty? brea:null
                        // activeSubscriptionList
                        // .where((element) => element.orders.where((i)=> i.catalog.mealCategory.category == "Breakfast"))
                        // .toList(): null

                    ),
                    ActiveWidgetTabDataCopy(
                        activeSubscriptionList!=null &&  activeSubscriptionList.isNotEmpty?lun
                        // activeSubscriptionList
                        // .where((element) => element.orders[0].catalog.mealCategory.category == "Lunch")
                        // .toList()
                            : null),
                    ActiveWidgetTabDataCopy(
                        activeSubscriptionList!=null && activeSubscriptionList.isNotEmpty?snac
                        // activeSubscriptionList
                        // .where((element) => element.orders[0].catalog.mealCategory.category == "Snacks")
                        // .toList()
                            :null),
                    ActiveWidgetTabDataCopy(
                        activeSubscriptionList!=null &&  activeSubscriptionList.isNotEmpty?dinn
                        // activeSubscriptionList
                        // .where((element) => element.orders[0].catalog.mealCategory.category == "Dinner")
                        // .toList()
                            : null),
                    ActiveWidgetTabDataCopy(
                        activeSubscriptionList!=null && activeSubscriptionList.isNotEmpty? al: null),
                  ],
                ),
              ),
      ),
    );
  }

  Text buildTab(String tabTitle) => Text(tabTitle, style: TextStyle(fontSize: 17, color: Colors.black));


}
