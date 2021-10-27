import 'dart:async';
import 'package:flutter_sheplates/ui/NewFlow/TabData.dart';
import 'dart:convert';
import 'CartScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/Routes.dart';
import 'package:flutter_sheplates/Utils/app_constants.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/modals/request/AddUserRequest.dart';
import 'package:flutter_sheplates/modals/request/AppDownloadRequest.dart';
import 'package:flutter_sheplates/modals/response/BaseResponse.dart';
import 'package:flutter_sheplates/modals/response/HomeListResponse.dart';
import 'package:flutter_sheplates/modals/response/loginresponse.dart';
import 'package:flutter_sheplates/ui/DrawerScreen.dart';
import 'package:flutter_sheplates/modals/response/tabNamesFiltersResponse.dart';
import 'package:flutter_sheplates/modals/response/CardResponse.dart';

class HomeScreenWithTabs extends StatefulWidget {
  String categoryName;
  int mainCategoryID;
  HomeScreenWithTabs({this.categoryName, this.mainCategoryID});
  @override
  _HomeScreenWithTabsState createState() => _HomeScreenWithTabsState(categoryName, mainCategoryID);
}

class _HomeScreenWithTabsState extends State<HomeScreenWithTabs> {
  String categoryName;
  int mainCategoryID;
  TabNamesFilters tabNamesFilters;
  bool isSubscribed = false;
String categoryN;
String maincateId;
  _HomeScreenWithTabsState(this.categoryName, this.mainCategoryID);

  @override
  initState() {
    super.initState();
    if (mounted) {

      getTabs();
      updateCartIconNumber();
    }_appDownload();

    // if (mounted) updateCartIconNumber();

    // getList();
  }

  int numberOfCartItems;

  updateCartIconNumber() async {
    print("*************** updating cart icon *****************");
    String token = await SharedPrefHelper().getWithDefault("token", "");
    var res = await NetworkUtil().get("user/cartItems", token: token);
    CardResponse cardResponse = CardResponse.fromJson(res);
    if (cardResponse.status == 200) {
      categoryN= await SharedPrefHelper().getWithDefault("categoryName", "");
      maincateId= await SharedPrefHelper().getWithDefault("mainCategoryID", "");
      print("categoryyyIddddddd" + categoryN);
      print("mainnncategoryyyyyyy" + maincateId);

      if (cardResponse.data == null) {
        setState((){
        widget.categoryName = widget.categoryName == null && categoryN!=null ? categoryN.toString():widget.categoryName ;
        widget.mainCategoryID = widget.mainCategoryID.toString() == null && maincateId!=null ? int.parse(maincateId): widget.mainCategoryID ;
          numberOfCartItems = null;});
      } else {
        setState(() => numberOfCartItems = cardResponse.data.cartItems.length);
      }
    } else {
      print("************** Error while fetching numbers of cart items ***************** ");
    }

    // cardResponse.status == 200
    //     ? setState(() => numberOfCartItems = cardResponse.data.cartItems.length)
    //     : print("************** Error while fetching numbers of cart items ***************** ");
  }

  getTabs() async {

    String token = await SharedPrefHelper().getWithDefault("token", "");
    var res = await NetworkUtil().get("user/meal-category", token: token);
    tabNamesFilters = TabNamesFilters.fromJson(res);

    categoryN= await SharedPrefHelper().getWithDefault("categoryName", "");
     maincateId= await SharedPrefHelper().getWithDefault("mainCategoryID", "");

    setState((){
      widget.categoryName = categoryN.toString() ;
      widget.mainCategoryID =  int.parse(maincateId) ;
      print("categoryyyIddddddd" + widget.categoryName );
      print("mainnncategoryyyyyyy" + widget.mainCategoryID.toString());
    });
    // if (tabNamesFilters.status == 200) {}
  }

  // Future<void> _addRequest() async {
  //   CommonUtils.fullScreenProgress(context);
  //   String url = "user/add-user-request";
  //   String token = await SharedPrefHelper().getWithDefault("token", "");
  //   String userData = await SharedPrefHelper().getWithDefault(SharedPrefConstants.userData, jsonEncode({}));
  //   Profile profile = Profile.fromJson(jsonDecode(userData));
  //   String location = profile.userAddresses[0].fullAddress;
  //   AddUserRequest request =
  //       AddUserRequest(type: "Meal plan customization", address: location.toString(), category: "Meal");
  //   var res = await NetworkUtil().post(url: url, body: jsonEncode(request), token: token);
  //   BaseResponse response = BaseResponse.fromJson(res);
  //   if (response.status == 200) {
  //     CommonUtils.dismissProgressDialog(context);
  //     CommonUtils.showToast(msg: response.message, bgColor: AppColor.darkThemeBlueColor, textColor: Colors.white);
  //   } else {
  //     CommonUtils.errorMessage(msg: response.message);
  //     CommonUtils.dismissProgressDialog(context);
  //   }
  // }

  Future<void> _appDownload() async {
    String url = "user/download-app";
    String deviceId = await CommonUtils.getDeviceId();
    String token = await SharedPrefHelper().getWithDefault("token", "");
    AppDownloadRequest request = AppDownloadRequest(deviceId: deviceId);
    var res = await NetworkUtil().post(url: url, body: jsonEncode(request), token: token);
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
    super.dispose();
    _streamController?.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Image.asset("assets/logo_home.png", fit: BoxFit.fill),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_cart_outlined, color: Colors.grey),
                      onPressed: () async {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()))
                        // .then((value) => updateCartIconNumber()),
                        var result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartScreen(),
                            )).then((value) => updateCartIconNumber());
                        if (result == "Update") {
                          categoryN= await SharedPrefHelper().getWithDefault("categoryName", "");
                          maincateId= await SharedPrefHelper().getWithDefault("mainCategoryID", "");
                        setState(() {
                          updateCartIconNumber();
                          print("categoryyyIddddddd" + categoryN);
                          print("mainnncategoryyyyyyy" + maincateId);
                            widget.categoryName =
                            widget.categoryName == null && categoryN!=null ? categoryN.toString():widget.categoryName ;
                            widget.mainCategoryID =
                            widget.mainCategoryID.toString() == null && maincateId!=null ? int.parse(maincateId): widget.mainCategoryID ;
                        });
                        }
                      } ),
                    numberOfCartItems == null
                        ? Container()
                        : Container(
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                            child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                                child: Text(numberOfCartItems.toString())),
                          ),
                  ],
                ),
              ),
            ],
            leading: Builder(
              builder: (context) => IconButton(
                icon: Image.asset("assets/left_menu.png", fit: BoxFit.fill),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            elevation: 5,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * .1),
                      Flexible(
                        child: Container(width: 50, color: Colors.grey, height: .5),
                      ),
                      Text(
                        "  $categoryName  ",
                        style:
                            TextStyle(fontSize: 19, color: Colors.grey, fontWeight: FontWeight.w700, letterSpacing: 2),
                      ),
                      Flexible(child: Container(width: 50, color: Colors.grey, height: .5)),
                      SizedBox(width: MediaQuery.of(context).size.width * .1),
                    ],
                  ),
                  SizedBox(height: 20),
                  tabNamesFilters == null
                      ? Column(children: [SizedBox(height: 40), LinearProgressIndicator()])
                      : TabBar(
                          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                          isScrollable: true,
                          labelPadding: EdgeInsets.all(10),
                          indicator: UnderlineTabIndicator(
                            insets: EdgeInsets.all(6),
                            borderSide: BorderSide(color: AppColor.themeButtonColor, width: 2),
                          ),
                          tabs: [
                            buildTab(tabNamesFilters.data.mealCategory.rows[0].category),
                            buildTab(tabNamesFilters.data.mealCategory.rows[1].category),
                            buildTab(tabNamesFilters.data.mealCategory.rows[2].category),
                            buildTab(tabNamesFilters.data.mealCategory.rows[3].category),
                            buildTab("All Day"),
                          ],
                        ),
                ],
              ),
            ),
          ),
          body: tabNamesFilters == null
              ? Center(child: CircularProgressIndicator())
              : TabBarView(
                  physics: NeverScrollableScrollPhysics(), //stops data reloading
                  children: [
                    TabData(_streamController, isSubscribed, images, mainCategoryID,
                        tabNamesFilters.data.mealCategory.rows[0].id, updateCartIconNumber, widget.categoryName),
                    TabData(_streamController, isSubscribed, images, mainCategoryID,
                        tabNamesFilters.data.mealCategory.rows[1].id, updateCartIconNumber, widget.categoryName),
                    TabData(_streamController, isSubscribed, images, mainCategoryID,
                        tabNamesFilters.data.mealCategory.rows[2].id, updateCartIconNumber, widget.categoryName),
                    TabData(_streamController, isSubscribed, images, mainCategoryID,
                        tabNamesFilters.data.mealCategory.rows[3].id, updateCartIconNumber, widget.categoryName),
                    TabData(_streamController, isSubscribed, images, mainCategoryID, 58765, updateCartIconNumber, widget.categoryName),
                  ],
                ),
        ),
      ),
    );
  }

  Text buildTab(String tabTitle) => Text(tabTitle, style: TextStyle(fontSize: 17, color: Colors.black));

  // getList() async {
  //   String token = await SharedPrefHelper().getWithDefault("token", "");
  //   var res = await NetworkUtil().get("user/subscription-plans?cuisine_id=$mainCategoryID", token: token);
  //   HomeListResponse homeListResponse = HomeListResponse.fromJson(res);
  //   if (homeListResponse.status == 200) {
  //     if (homeListResponse.data.subscriptionPlanData != null) {
  //       _streamController.sink.add(homeListResponse.data.subscriptionPlanData.rows);
  //     }
  //     isSubscribed = homeListResponse.data.suscriber;
  //     if (homeListResponse.data.deliveryAddressExist == 0) {
  //       CommonUtils.showToast(
  //           msg: "You have't added your delivery Location Please add", bgColor: Colors.black, textColor: Colors.white);
  //       Navigator.pushNamedAndRemoveUntil(context, Routes.deliveryStaticScreen, (route) => false);
  //     }
  //   }
  // }
}
