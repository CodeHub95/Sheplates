import 'dart:async';
import 'dart:convert';
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
import 'CartScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool suscriber = false;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      _appDownload();
    }
    getList();
  }

  final List<String> images = <String>[
    'assets/img1.png',
    'assets/img2.png',
    'assets/img3.png',
    'assets/img4.png',
    'assets/img5.png',
    'assets/img6.png',
    'assets/img7.png',
    'assets/img8.png',
    'assets/img1.png',
    'assets/img2.png',
    'assets/img3.png',
    'assets/img4.png',
    'assets/img5.png',
    'assets/img6.png',
    'assets/img7.png',
    'assets/img8.png',
    'assets/img1.png',
    'assets/img2.png',
    'assets/img3.png',
    'assets/img4.png',
    'assets/img5.png',
    'assets/img6.png',
    'assets/img7.png',
    'assets/img8.png',
    'assets/img1.png',
    'assets/img2.png',
    'assets/img3.png',
    'assets/img4.png',
    'assets/img5.png',
    'assets/img6.png',
    'assets/img7.png',
    'assets/img8.png',
    'assets/img1.png',
    'assets/img2.png',
    'assets/img3.png',
    'assets/img4.png',
    'assets/img5.png',
    'assets/img6.png',
    'assets/img7.png',
    'assets/img8.png',
    'assets/img1.png',
    'assets/img2.png',
    'assets/img3.png',
    'assets/img4.png',
    'assets/img5.png',
    'assets/img6.png',
    'assets/img7.png',
    'assets/img8.png',
    'assets/img1.png',
    'assets/img2.png',
    'assets/img3.png',
    'assets/img4.png',
    'assets/img5.png',
    'assets/img6.png',
    'assets/img7.png',
    'assets/img8.png',
    'assets/img1.png',
    'assets/img2.png',
    'assets/img3.png',
    'assets/img4.png',
    'assets/img5.png',
    'assets/img6.png',
    'assets/img7.png',
    'assets/img8.png',
  ];

  StreamController<List<Rows>> _streamController = StreamController.broadcast();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _streamController?.close();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      top: true,
      child: Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Center(
              child: Container(
                alignment: Alignment.center,
                // width: MediaQuery.of(context).size.width / 2,
                child: Image.asset(
                  "assets/logo_home.png",
                  fit: BoxFit.fill,
                  // color: Colors.transparent,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Image.asset(
                  "assets/profile.png",
                  fit: BoxFit.fill,
                ),
                onPressed: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen())),
                },
              ),
              Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart_outlined, color: Colors.grey),
                    onPressed: () => {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen())),
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen())),
                    },
                  ),
                  Expanded(
                    child: Positioned(
                      right: 1,
                      top: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                          child: Text("8"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            leading: Builder(
              builder: (context) => IconButton(
                icon: Image.asset(
                  "assets/left_menu.png",
                  fit: BoxFit.fill,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            bottom: PreferredSize(
              child: Container(
                color: Colors.grey,
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0),
            ),
          ),
          body: SingleChildScrollView(
              child: Column(children: [
            Container(
                // width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                child: StreamBuilder<List<Rows>>(
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
                                                      child: (Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            snapshot.data[index].mealName,
                                                            style: TextStyle(color: Colors.black, fontSize: 20),
                                                            // overflow: TextOverflow.ellipsis,
                                                          )
                                                        ],
                                                      )),
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
                                                            builder: (context) => VegitarianLunch(
                                                              rows: snapshot.data[index],
                                                              suscriber: suscriber,
                                                            ),
                                                          ),
                                                        ),
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  child: Image.asset('${images[index]}'),
                                                )
                                              ],
                                            )
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
                                                          ))),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 20,
                                                        // top: 10,
                                                        // bottom: 10,
                                                      ),
                                                      child: new SizedBox(
                                                          height: 30,
                                                          width: 160,
                                                          child: RaisedButton(
                                                            shape: RoundedRectangleBorder(
                                                              side: BorderSide(color: Colors.red, width: 1),
                                                              borderRadius: BorderRadius.circular(5.0),
                                                            ),
                                                            color: Colors.red,
                                                            child: Text(
                                                              "Request Call Back",
                                                              style: TextStyle(color: Colors.white),
                                                            ),
                                                            onPressed: () => {
                                                              if (suscriber == true)
                                                                {
                                                                  CommonUtils.showToast(
                                                                      msg:
                                                                          "You have already one subscription plan running!",
                                                                      bgColor: Colors.black,
                                                                      textColor: Colors.white)
                                                                }
                                                              else
                                                                {_addRequest()}
                                                            },
                                                          )))
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
                                    )

                                    // ),
                                    )),
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
                                    data:
                                        "We aren't in your location yet! However, we will strive to serve you soon :)",
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          ),
                        );
                      }
                    }))
          ]))),
    );
  }

  getList() async {
    String token = await SharedPrefHelper().getWithDefault("token", "");
    var res = await NetworkUtil().get("user/subscription-plans", token: token);
    HomeListResponse homeListResponse = HomeListResponse.fromJson(res);
    if (homeListResponse.status == 200) {
      if (homeListResponse.data.subscriptionPlanData != null) {
        _streamController.sink.add(homeListResponse.data.subscriptionPlanData.rows);
      }
      suscriber = homeListResponse.data.suscriber;

      if (homeListResponse.data.deliveryAddressExist == 0) {
        CommonUtils.showToast(
            msg: "You have't added your delivery Location Please add", bgColor: Colors.black, textColor: Colors.white);
        Navigator.pushNamedAndRemoveUntil(context, Routes.deliveryStaticScreen, (route) => false);
      }
    }
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

  Future<void> _appDownload() async {
    String url = "user/download-app";
    String deviceId = await CommonUtils.getDeviceId();
    String token = await SharedPrefHelper().getWithDefault("token", "");
    AppDownloadRequest request = AppDownloadRequest(deviceId: deviceId);
    var res = await NetworkUtil().post(url: url, body: jsonEncode(request), token: token);
    BaseResponse response = BaseResponse.fromJson(res);
  }
}
