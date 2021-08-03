import 'dart:async';
import 'package:flutter_sheplates/ui/PastWidgetTabData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/modals/response/MySubscriptions.dart';

class PastWidgetWithTabs extends StatefulWidget {
  List<PastSubscription> subscriptionData;
  PastWidgetWithTabs(this.subscriptionData);
  @override
  _PastWidgetWithTabsState createState() => _PastWidgetWithTabsState(subscriptionData);
}

class _PastWidgetWithTabsState extends State<PastWidgetWithTabs> {
  List<PastSubscription> subscriptionData;
  _PastWidgetWithTabsState(this.subscriptionData);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: DefaultTabController(
        length: 5,
        child: subscriptionData == null
            ? Center(child: CircularProgressIndicator())
            : subscriptionData.isEmpty
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
                        PastWidgetTabData(subscriptionData),
                        PastWidgetTabData(subscriptionData),
                        PastWidgetTabData(subscriptionData),
                        PastWidgetTabData(subscriptionData),
                        PastWidgetTabData(subscriptionData),
                      ],
                    ),
                  ),
      ),
    );
  }

  Text buildTab(String tabTitle) => Text(tabTitle, style: TextStyle(fontSize: 17, color: Colors.black));
}
