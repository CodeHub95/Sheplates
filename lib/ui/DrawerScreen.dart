import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/app_constants.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/auth/RestApiCalls.dart';
import 'package:flutter_sheplates/auth/api_config.dart';
import 'package:flutter_sheplates/modals/request/StockCheckRequest.dart';
import 'package:flutter_sheplates/modals/request/logoutrequest.dart';
import 'package:flutter_sheplates/modals/response/BaseResponse.dart';
import 'package:flutter_sheplates/modals/response/CheckOutResponse.dart';
import 'package:flutter_sheplates/modals/response/GetFeedbackResponse.dart';
import 'package:flutter_sheplates/modals/response/GetProfileResponse.dart';
import 'package:flutter_sheplates/modals/response/SubscriptionResponse.dart';
import 'package:flutter_sheplates/modals/response/loginresponse.dart';
import 'package:flutter_sheplates/ui/DeliveryAddress.dart';
import 'package:flutter_sheplates/ui/EditProfile.dart';
import 'package:flutter_sheplates/ui/FaqScreen.dart';
import 'package:flutter_sheplates/ui/Feedback.dart';
import 'package:flutter_sheplates/ui/HomeScreen.dart';
import 'package:flutter_sheplates/ui/LoginRegisterScreen.dart';
import 'package:flutter_sheplates/ui/Menu.dart';
import 'package:flutter_sheplates/ui/MySubscription.dart';
import 'package:flutter_sheplates/ui/PauseMySubsciption.dart';
import 'package:flutter_sheplates/ui/Support.dart';

class CustomDrawer extends StatefulWidget {
  final CheckOutResponse stockCheckOutResponse;

  const CustomDrawer({Key key, this.stockCheckOutResponse}) : super(key: key);

  @override
  _CommonDrawerState createState() =>
      _CommonDrawerState(this.stockCheckOutResponse);
}

class _CommonDrawerState extends State<CustomDrawer> {
  String name = "";
  String url;

  final CheckOutResponse stockCheckOutResponse;
  StreamController<GetProfileResponse> _controller = StreamController();

  _CommonDrawerState(this.stockCheckOutResponse);

  bool select;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controller?.close();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          ListTile(
            leading: Image.asset(
              "assets/my_subsctipion.png",
              height: 25,
              width: 25,
              color: Colors.black,
            ),
            title: Text("My Subscriptions",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MySubscription()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.black,
              size: 30.0,
            ),
            title: Text("Home",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          Divider(),
          ListTile(
            leading: Image.asset(
              "assets/pause_subsciription.png",
              height: 25,
              width: 25,
              color: Colors.black,
            ),
            title: Text("Pause My Subscription",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PauseSubscription()));
            },
          ),
          Divider(),
          ListTile(
            leading: Image.asset(
              "assets/menu_icon.png",
              height: 25,
              width: 25,
              color: Colors.black,
            ),
            title: Text("Menu",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                )),
            onTap: () => {
              // null
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuScreen()),
              )
            },
          ),
          Divider(),
          ListTile(
            leading: Image.asset(
              "assets/delivery_addressw.png",
              height: 25,
              width: 25,
              color: Colors.black,
            ),
            title: Text("Delivery Address",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                )),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DeliveryAddress()))
            },
          ),
          Divider(),
          ListTile(
            leading: Image.asset(
              "assets/feedback.png",
              height: 25,
              width: 25,
              // color: Colors.black,
            ),
            title: Text("Feedback",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                )),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FeedBack()));
            },
          ),
          Divider(),
          ListTile(
            leading: Image.asset(
              "assets/support.png",
              height: 25,
              width: 25,
              color: Colors.black,
            ),
            title: Text("Support",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SupportScreen()));
            },
          ),
          Divider(),
          ListTile(
            leading: Image.asset(
              "assets/faq.png",
              height: 25,
              width: 25,
              color: Colors.black,
            ),
            title: Text("FAQs",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FaqScreen()));
            },
          ),
          Divider(),
          ListTile(
            leading: Image.asset(
              "assets/logout_icon.png",
              height: 25,
              width: 25,
              color: Colors.black,
            ),
            title: Text("Logout",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                )),
            onTap: () async {
              _showcontent();
            },
          ),
        ],
      ),
    );
  }

  getInfo() async {
    String email = await SharedPrefHelper().getWithDefault("email", null);
    String token = await SharedPrefHelper().getWithDefault("token", null);

    var res = await NetworkUtil().get("user/profile", token: token);
    GetProfileResponse getProfileResponse = GetProfileResponse.fromJson(res);

    if (getProfileResponse.status == 200) {
      _controller.sink.add(getProfileResponse);
    }
  }

  Widget createDrawerHeader() {
    return Container(
        height: 200,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(color: AppColor.themeButtonColor),
        child: StreamBuilder<GetProfileResponse>(
            stream: _controller.stream,
            builder: (context, snapshot) {
              return Column(
                children: [
                  Container(
                      height: 80,
                      width: 80,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        // color: Colors.indigo,
                        border: Border.all(width: 2, color: Colors.white),
                      ),
                      child: CircleAvatar(
                          child: snapshot.data == null
                              ? Container(
                                  height: 80,
                                  width: 80,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.indigo,
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                  ),
                                )
                              : Container(
                                  height: 80,
                                  width: 80,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      image: snapshot.data.data.userExist
                                                  .profileImage !=
                                              null
                                          ? NetworkImage(snapshot
                                              .data.data.userExist.profileImage
                                              .toString())
                                          : AssetImage(
                                              "assets/2.0x/profile_icon.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  )))),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                  ),
                  Text(
                    snapshot.data != null
                        ? snapshot.data.data.userExist.firstName.toString() +
                            " " +
                            snapshot.data.data.userExist.lastName.toString()
                        : " ",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                  ),
                  new SizedBox(
                      height: 30,
                      width: 120,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        color: Colors.transparent,
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfileScreen()))
                        },
                      ))
                ],
              );
            }));
  }

  void _showcontent() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          contentPadding: EdgeInsets.all(0.0),
          content: new SingleChildScrollView(
              child: Container(
            height: 170,
            child: new Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  //change here don't //worked
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 20.0,
                          color: Colors.black,
                        ),
                        onPressed: () => Navigator.pop(context)),
                  ],
                ),
                Text(
                  'Do You want to Logout',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: Container(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                        height: 40,
                        width: 150,
                        child: RaisedButton(
                            color: HexColor("#FF5657"),
                            textColor: Colors.white,
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            onPressed: () {
                              submit();
                            }))),
              ],
            ),
          )),
        );
      },
    );
  }

  Future<void> submit() async {
    String deviceId = await CommonUtils.getDeviceId();
    String userData = await SharedPrefHelper()
        .getWithDefault(SharedPrefConstants.userData, jsonEncode({}));
    Profile profile = Profile.fromJson(jsonDecode(userData));
    String token = await SharedPrefHelper().getWithDefault("token", null);
    LogoutRequest body =
        LogoutRequest(deviceId: deviceId, userId: profile.id.toString());
    CommonUtils.fullScreenProgress(context);
    BaseResponse response = await RestApiCalls().logout(body, token);
    if (response.status == 200) {
      CommonUtils.dismissProgressDialog(context);
      SharedPrefHelper().clear();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (buildContext) => LoginRegisterScreen()));
    } else {
      CommonUtils.dismissProgressDialog(context);
    }
  }
}
