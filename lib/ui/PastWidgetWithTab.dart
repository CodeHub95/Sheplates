import 'dart:async';
import 'package:flutter_sheplates/ui/PastWidgetTabData.dart';
import 'package:flutter_sheplates/ui/TabData.dart';
import 'dart:convert';
import 'CartScreen.dart';
import 'CategoryScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/Routes.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/Utils/app_constants.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/modals/request/AddUserRequest.dart';
import 'package:flutter_sheplates/modals/request/AppDownloadRequest.dart';
import 'package:flutter_sheplates/modals/request/PauseSubscriptionRequest.dart';
import 'package:flutter_sheplates/modals/response/BaseResponse.dart';
import 'package:flutter_sheplates/modals/response/HomeListResponse.dart';
import 'package:flutter_sheplates/modals/response/loginresponse.dart';
import 'package:flutter_sheplates/ui/DrawerScreen.dart';
import 'package:flutter_sheplates/ui/EditProfile.dart';
import 'package:flutter_sheplates/ui/Vegitarian_lunch.dart';
import 'package:flutter_sheplates/modals/response/tabNamesFiltersResponse.dart';
import 'package:flutter_sheplates/Utils/global.dart';

class PastWidgetWithTabs extends StatefulWidget {
  @override
  _PastWidgetWithTabsState createState() => _PastWidgetWithTabsState();
}

class _PastWidgetWithTabsState extends State<PastWidgetWithTabs> {
  TabNamesFilters tabNamesFilters;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
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
              PastWidgetTabData(),
              PastWidgetTabData(),
              PastWidgetTabData(),
              PastWidgetTabData(),
              PastWidgetTabData(),
            ],
          ),
        ),
      ),
    );
  }

  Text buildTab(String tabTitle) => Text(tabTitle, style: TextStyle(fontSize: 17, color: Colors.black));
}
