import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/modals/response/BaseResponse.dart';
import 'package:flutter_sheplates/modals/request/AddUserRequest.dart';
import 'package:flutter_sheplates/modals/response/loginresponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/modals/response/HomeListResponse.dart';
import 'dart:async';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_constants.dart';
import 'dart:convert';
import 'package:flutter_sheplates/Utils/Routes.dart';

import 'NewFlow/MealDetailScreen.dart';

class TabData extends StatefulWidget {
  StreamController<List<Rows>> _streamController;
  bool subscriber;
  List<String> images;
  int categoryID;
  int tabID;
  TabData(this._streamController, this.subscriber, this.images, this.categoryID, this.tabID, {Key key})
      : super(key: key);

  @override
  _TabDataState createState() => _TabDataState(_streamController, subscriber, images, categoryID, tabID);
}

class _TabDataState extends State<TabData> {
  StreamController<List<Rows>> _streamController;
  bool subscriber;
  List<String> images;
  int categoryID;
  int tabID;

  _TabDataState(this._streamController, this.subscriber, this.images, this.categoryID, this.tabID);

  @override
  void initState() {
    getList(tabID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder<List<Rows>>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              if (snapshot.data.length != 0) {
                return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 5, right: 5, top: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[300],
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey[300],
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        )),
                                    height: 2,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                                Row(
                                  // textDirection: TextDirection.rtl,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      // textDirection: TextDirection.rtl,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10, top: 10),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              width: 220,
                                              padding: EdgeInsets.all(2.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot.data[index].mealName,
                                                    style: TextStyle(color: Colors.black, fontSize: 20),
                                                    // overflow: TextOverflow.ellipsis,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                                          child: new SizedBox(
                                            height: 20,
                                            width: 90,
                                            child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(color: Colors.red, width: 1),
                                                borderRadius: BorderRadius.circular(5.0),
                                              ),
                                              color: Colors.white,
                                              child: Text(
                                                "Explore",
                                                style: TextStyle(color: Colors.red),
                                              ),
                                              onPressed: () => {
                                                // null
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    // builder: (context) => VegitarianLunchCopy(
                                                    builder: (context) => MealDetailScreen(
                                                      mealDetails: snapshot.data[index],
                                                      isSuscribed: subscriber,
                                                    ),
                                                  ),
                                                ),
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: Image.asset('${images[index]}'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[300],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[300],
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(5))),
                                height: 2,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            Container(
                              height: 90,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            // left: 10,
                                            top: 10,
                                            right: 30,
                                            bottom: 10),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Customisation",
                                            style: TextStyle(color: Colors.black, fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: new SizedBox(
                                          height: 30,
                                          width: 160,
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(color: Colors.red, width: 1),
                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            color: Colors.red,
                                            child: Text("Request Call Back", style: TextStyle(color: Colors.white)),
                                            onPressed: () => {
                                              if (subscriber == true)
                                                CommonUtils.showToast(
                                                  msg: "You have already one subscription plan running!",
                                                  bgColor: Colors.black,
                                                  textColor: Colors.white,
                                                )
                                              else
                                                _addRequest()
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Image.asset('${images[7]}'),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset("assets/not_delivering.png"),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: ScreenUtils.customText(
                          data: "We aren't in your location yet! However, we will strive to serve you soon :)",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: Colors.white,
              child: Text("Go Back To Categories", style: TextStyle(color: Colors.redAccent)),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addRequest() async {
    CommonUtils.fullScreenProgress(context);
    String url = "user/add-user-request";
    String token = await SharedPrefHelper().getWithDefault("token", "");
    String userData = await SharedPrefHelper().getWithDefault(SharedPrefConstants.userData, jsonEncode({}));
    Profile profile = Profile.fromJson(jsonDecode(userData));
    String location = profile.userAddresses[0].fullAddress;

    AddUserRequest request =
        AddUserRequest(type: "Meal plan customization", address: location.toString(), category: "Meal");
    var res = await NetworkUtil().post(url: url, body: jsonEncode(request), token: token);
    BaseResponse response = BaseResponse.fromJson(res);
    if (response.status == 200) {
      CommonUtils.dismissProgressDialog(context);
      CommonUtils.showToast(msg: response.message, bgColor: AppColor.darkThemeBlueColor, textColor: Colors.white);
    } else {
      CommonUtils.errorMessage(msg: response.message);
      CommonUtils.dismissProgressDialog(context);
    }
  }

  getList(int id) async {
    String token = await SharedPrefHelper().getWithDefault("token", "");

    String apiURL = id == 58765
        ? "user/subscription-plans?cuisine_id=$categoryID"
        : "user/subscription-plans?category_id=$id&cuisine_id=$categoryID";

    // String apiURL = "user/subscription-plans?cuisine_id=$categoryID";
    // if (tabID != 58765) {
    //   apiURL = "user/subscription-plans?category_id=$tabID&cuisine_id=$categoryID";
    // }

    var res = await NetworkUtil().get(apiURL, token: token);

    HomeListResponse homeListResponse = HomeListResponse.fromJson(res);
    if (homeListResponse.status == 200) {
      if (homeListResponse.data.subscriptionPlanData != null) {
        _streamController.sink.add(homeListResponse.data.subscriptionPlanData.rows);
      }
      subscriber = homeListResponse.data.suscriber;

      if (homeListResponse.data.deliveryAddressExist == 0) {
        CommonUtils.showToast(
            msg: "You have't added your delivery Location Please add", bgColor: Colors.black, textColor: Colors.white);
        Navigator.pushNamedAndRemoveUntil(context, Routes.deliveryStaticScreen, (route) => false);
      }
    }
  }
}
