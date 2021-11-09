import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/Routes.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/modals/request/ChefChangeRequest.dart';
import 'package:flutter_sheplates/modals/response/BaseResponse.dart';
import 'package:flutter_sheplates/modals/response/MenuResponse.dart';
import 'package:intl/intl.dart';

class UpcommingMenuTabData extends StatefulWidget {
  List<Obj> menuData;

  UpcommingMenuTabData(this.menuData);

  @override
  _UpcommingMenuTabDataState createState() =>
      _UpcommingMenuTabDataState(this.menuData);
}

class _UpcommingMenuTabDataState extends State<UpcommingMenuTabData> {
  List<Obj> menuData;

  _UpcommingMenuTabDataState(this.menuData);

  bool isExpanded = false;

  @override
  void initState() {
    // TODO: implement initState
    if(menuData == null){
      setState(() {
        menuData = null;
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      menuData == null
    ||
    menuData.length == 0
    || menuData.isEmpty
          ? Center(
              child: Text(
              "You don't have this subscription",
              style: TextStyle(color: Colors.black),
            ))
          : Padding(
              padding: EdgeInsets.only(top: 10),
              child: ListView.builder(
                itemCount: menuData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ExpansionPanelList(
                        children: [
                          ExpansionPanel(
                            canTapOnHeader: true,
                            headerBuilder:
                                (BuildContext context, bool isExpanded) =>
                                    Center(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      menuData[index].mealName,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            body: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            AssetImage("assets/bg_menu.png"))),
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Stack(children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              right: 10, left: 10, top: 10),
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  1.3,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: AssetImage(
                                                          "assets/menu_listing.png"))))),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 65)),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.of(context).size.width/1.2,
                                                      alignment: Alignment.center,
                                                      child: SingleChildScrollView(
                                                        scrollDirection: Axis.horizontal,
                                                        child: Text(
                                                          menuData[index].kitchen !=
                                                                  null
                                                              ? menuData[index]
                                                                  .kitchen
                                                                  .toString()
                                                              : '',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color: Colors.red),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 0,
                                                    right: 30,
                                                    left: 30),
                                                child: Container(
                                                    height: 10,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: AssetImage(
                                                                "assets/arrow_menu.png"))))),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(

                                                      width: MediaQuery.of(context).size.width/1.2,
                                                      alignment: Alignment.center,
                                                      child: SingleChildScrollView(
                                                        scrollDirection: Axis.horizontal,
                                                        child: Text(
                                                          menuData[index].mealName,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color: Colors.red),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                   left: 30),
                                                child: Container(
                                                  height: MediaQuery.of(context).size.height/1.8,
                                                  child: SingleChildScrollView(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [

                                                            menuWidget(
                                                                title: "Monday:",
                                                                menu:
                                                                    menuData[index]
                                                                        .menu
                                                                        .monday),

                                                            menuWidget(
                                                                title: "Tuesday:",
                                                                menu:
                                                                    menuData[index]
                                                                        .menu
                                                                        .tuesday),
                                                            menuWidget(
                                                                title: "Wednesday:",
                                                                menu:
                                                                    menuData[index]
                                                                        .menu
                                                                        .wednesday),
                                                            menuWidget(
                                                                title: "Thursday:",
                                                                menu:
                                                                    menuData[index]
                                                                        .menu
                                                                        .thrusday),
                                                            menuWidget(
                                                                title: "Friday:",
                                                                menu:
                                                                    menuData[index]
                                                                        .menu
                                                                        .friday),
                                                            menuWidget(
                                                                title: "Saturday:",
                                                                menu:
                                                                    menuData[index]
                                                                        .menu
                                                                        .saturday),
                                                            menuWidget(
                                                                title: "Sunday:",
                                                                menu:
                                                                    menuData[index]
                                                                        .menu
                                                                        .sunday),
                                                            if (menuData[index]
                                                                    .menu
                                                                    .sunday2 !=
                                                                null) ...{
                                                            Padding(
                                                            padding: EdgeInsets.only(
                                                            top: 20),
                                                               child: Container(
                                                                 alignment: Alignment.center,
                                                                   child: Text(" *** for Next week ***", style: TextStyle(color: Colors.grey),))
                                                            ) ,


                                                              menuWidget(
                                                                  title: "Monday:",
                                                                  menu: menuData[
                                                                          index]
                                                                      .menu
                                                                      .monday),
                                                              menuWidget(
                                                                  title:
                                                                      "Tuesday:",
                                                                  menu: menuData[
                                                                          index]
                                                                      .menu
                                                                      .tuesday),
                                                              menuWidget(
                                                                  title:
                                                                      "Wednesday:",
                                                                  menu: menuData[
                                                                          index]
                                                                      .menu
                                                                      .wednesday),
                                                              menuWidget(
                                                                  title:
                                                                      "Thursday:",
                                                                  menu: menuData[
                                                                          index]
                                                                      .menu
                                                                      .thrusday),
                                                              menuWidget(
                                                                  title: "Friday:",
                                                                  menu: menuData[
                                                                          index]
                                                                      .menu
                                                                      .friday),
                                                              menuWidget(
                                                                  title:
                                                                      "Saturday:",
                                                                  menu: menuData[
                                                                          index]
                                                                      .menu
                                                                      .saturday),
                                                              menuWidget(
                                                                  title: "Sunday:",
                                                                  menu: menuData[
                                                                          index]
                                                                      .menu
                                                                      .sunday),
                                                            Padding(
                                                            padding: EdgeInsets.only(top: 15)),
                                                            }
                                                          ].sublist(DateTime.now()
                                                                      .weekday >
                                                                  11
                                                              ? 0
                                                              : DateTime.now()
                                                                  .weekday),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                          ]),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(top: 20),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1.4,
                                              )),
                                          // Padding(
                                          //   // alignment: Alignment.center,
                                          //     padding: EdgeInsets.only(left: 100),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                height: 80,
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: AssetImage(
                                                                  "assets/chef_btn.png"))),
                                                      height: 50,
                                                      width: 160,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(20, 5,
                                                                    0, 20),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Container(
                                                                      height: 40,
                                                                      width: 120,
                                                                      child: Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            DateFormat('EEEE').format(DateTime.now()),
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 20,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )),
                                                                )
                                                              ],
                                                            )),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                // )
                                              ),
                                            ],
                                          ),
                                          //     child:
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 0, 20, 0),
                                              child: FlatButton(
                                                  color: HexColor("#FF5657"),
                                                  textColor: Colors.white,
                                                  child: Text(
                                                    'Change Chef Request',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                   submit(
                                                     menuData[index].subscriptionPlanId
                                                   );
                                                  }))
                                        ],
                                      ),
                                    ]),
                                  ],
                                )),
                            isExpanded: menuData[index].isExpanded == null
                                ? false
                                : menuData[index].isExpanded,
                          )
                        ],
                        expansionCallback: (int item, bool status) => setState(
                            () => menuData[index].isExpanded =
                                menuData[index].isExpanded == null
                                    ? true
                                    : !menuData[index].isExpanded
                            // !menuData[index].isExpanded ,
                            )),
                  );
                },
              ),
            ),
    );
  }

  Widget menuWidget({@required String title, @required String menu}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 20, color: Colors.red)),
              ],
            )),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Text(
                menu,
                style: TextStyle(fontSize: 15, color: Colors.white),
                maxLines: 3,
              )),
        )
      ],
    );
  }
  Future<void> submit(int subscriptionPlanId) async {
    CommonUtils.fullScreenProgress(context);
    String url = "user/change-chef-request";
    String token = await SharedPrefHelper().getWithDefault("token", "");
    ChefChangeRequest request = ChefChangeRequest(
      subscription_plan_id: subscriptionPlanId,
    );
    var res = await NetworkUtil().post(url: url, body: jsonEncode(request), token: token);
    BaseResponse response = BaseResponse.fromJson(res);
    if (response.status == 200) {
      _showcontent();
    } else {
      CommonUtils.errorMessage(msg: response.message);
      CommonUtils.dismissProgressDialog(context);
    }
  }
  void _showcontent() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          contentPadding: EdgeInsets.all(0),
          content: new SingleChildScrollView(
              child: Container(
                height: 130,
                child: new Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 20.0,
                              color: Colors.black,
                            ),
                            onPressed: () => {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                Routes.homeScreen,
                                    (route) => false,
                              )
                            }),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          'Your Request will be Processed in 24 hours',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              )),
        );
      },
    );
  }


}
