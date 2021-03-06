import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/modals/response/MenuResponse.dart';
import 'package:flutter_sheplates/ui/NewFlow/Menu/UpcommingMenuTabData.dart';

class NewUpcommingMenu extends StatefulWidget {

  @override
  NewUpcommingMenuState createState() => NewUpcommingMenuState();
}

class NewUpcommingMenuState extends State<NewUpcommingMenu> {
  StreamController<MenuResponse> _listcontroller = StreamController.broadcast();
  List<Obj> menu;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMenuItem();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _listcontroller?.close();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: StreamBuilder<MenuResponse>(
        stream: _listcontroller.stream,
        builder: (context, snapshot) {
          if(!snapshot.hasData)
            return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
      if (snapshot.hasData) {
     return DefaultTabController(
        length: 5,
        child:
        // _listcontroller ==null
        //     ? Center(child: Text("You don't have any active subscription"))
        //     :
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
              UpcommingMenuTabData(
                  menu !=null?
              menu.where((element) => element.mealCategory == "Breakfast").toList():menu

              ),
              UpcommingMenuTabData(
                  menu !=null?
                  menu
                  .where((element) => element.mealCategory == "Lunch")
                  .toList(): menu
              ),
              UpcommingMenuTabData(
                  menu !=null?
                  menu
                  .where((element) => element.mealCategory == "Snacks")
                  .toList()
                      : menu
              ),
              UpcommingMenuTabData(
                  menu !=null?
                  menu
                  .where((element) => element.mealCategory == "Dinner")
                  .toList():
                      menu
              ),
              UpcommingMenuTabData(
                  menu !=null?
                  menu: menu),
            ],
          ),
        ),
      );}
        else return
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child:     Center(
              child: Text("You don't have any active subscription"))
        );})
    );
  }

  Text buildTab(String tabTitle) => Text(tabTitle, style: TextStyle(fontSize: 17, color: Colors.black));

  fetchMenuItem() async {
    // CommonUtils.fullScreenProgress(context);
    String token = await SharedPrefHelper().getWithDefault("token", "");
    var res = await NetworkUtil().get("user/my-menu", token:token);
    MenuResponse menuResponse = MenuResponse.fromJson(res);
    if (menuResponse.status == 200) {
      // CommonUtils.dismissProgressDialog(context);
      if (menuResponse.data == null) {
        setState(() {
          _listcontroller.sink.add(menuResponse);
          menu = menuResponse.data;
        });
        CommonUtils.showToast(
            msg: "Do not have any ActiveSubscription Plan",
            bgColor: AppColor.darkThemeBlueColor,
            textColor: Colors.white);
      } else {
        // CommonUtils.dismissProgressDialog(context);

        setState(() {
          _listcontroller.sink.add(menuResponse);
          menu = menuResponse.data;
        });

print(menu.toString());
        print("** subscription data ***");
    }
    } else {
      // CommonUtils.dismissProgressDialog(context);
      CommonUtils.showToast(msg: menuResponse.message);
      _listcontroller.sink.addError(menuResponse.message);
    }
    print("**************** subscription data ***************");
  }
}
