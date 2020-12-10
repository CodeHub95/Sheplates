import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/app_constants.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/auth/RestApiCalls.dart';
import 'package:flutter_sheplates/modals/request/loginrequest.dart';
import 'package:flutter_sheplates/modals/request/logoutrequest.dart';
import 'package:flutter_sheplates/modals/response/BaseResponse.dart';
import 'package:flutter_sheplates/modals/response/loginresponse.dart';
import 'package:flutter_sheplates/ui/DemoUi/HomeScreen.dart';
import 'package:flutter_sheplates/ui/LoginRegisterScreen.dart';
// import 'package:flutter_commondrawer/Routes.dart';

class CommonDrawer extends StatefulWidget {
  @override
  _CommonDrawerState createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  String name = "";
  String url = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerBodyItem(
              icon: Icons.contacts,
              text: 'My Subscriptions',
              onTap: () => null),
          Divider(),
          createDrawerBodyItem(
            icon: Icons.event,
            text: 'Pause My Subscriptions',
          ),
          Divider(),
          createDrawerBodyItem(
            icon: Icons.note,
            text: 'Menu',
          ),
          Divider(),
          createDrawerBodyItem(
              icon: Icons.collections_bookmark, text: 'Delivery Address'),
          Divider(),
          createDrawerBodyItem(icon: Icons.face,
              text: 'Feedback'),
          Divider(),
          createDrawerBodyItem( icon: Icons.support, text: 'Support'),
          Divider(),
          createDrawerBodyItem(icon: Icons.stars, text: 'FAQs'),
          Divider(),
          createDrawerBodyItem(
              onTap: () async {
                String deviceId = await CommonUtils.getDeviceId();
                String userData = await SharedPrefHelper().getWithDefault(
                    SharedPrefConstants.userData, jsonEncode({}));
                Profile profile = Profile.fromJson(jsonDecode(userData));
                String token =
                    await SharedPrefHelper().getWithDefault("token", null);
                LogoutRequest body = LogoutRequest(
                    deviceId: deviceId, userId: profile.id.toString());
                CommonUtils.fullScreenProgress(context);
                BaseResponse response =
                    await RestApiCalls().logout(body, token);
                if (response.status == 200) {
                  CommonUtils.dismissProgressDialog(context);
                  SharedPrefHelper().clear();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (buildContext) => LoginRegisterScreen()));
                } else {
                  CommonUtils.dismissProgressDialog(context);
                }
              },
              icon: Icons.bug_report,
              text: 'Logout'),
        ],
      ),
    );
  }

  Widget createDrawerHeader() {
    return Container(
        height: 200,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(color: AppColor.themeButtonColor),
        child: Column(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: new BoxDecoration(
                // borderRadius: BorderRadius.circular(1.0),
                shape: BoxShape.circle,
                color: Colors.indigo,
                border: Border.all(width: 2, color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10,
              ),
            ),
            Text(
              name,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10,
              ),
            ),
            new SizedBox(
                height: 30,
                width: 110,
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
                  onPressed: () => {null},
                ))
          ],
        ));
  }

  Widget createDrawerBodyItem(
      { String text, GestureTapCallback onTap, IconData icon}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  getInfo() async {
    String userData = await SharedPrefHelper()
        .getWithDefault(SharedPrefConstants.userData, jsonEncode({}));
    Profile profile = Profile.fromJson(jsonDecode(userData));
    name = profile.firstName + " " + profile.lastName;
    url = profile.profileImage;
    setState(() {});
  }
}
