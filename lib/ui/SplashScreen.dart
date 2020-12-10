import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/app_constants.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/auth/Auth.dart';
import 'package:flutter_sheplates/modals/request/PauseSubscriptionRequest.dart';
import 'package:flutter_sheplates/modals/response/BaseResponse.dart';
import 'package:flutter_sheplates/modals/response/loginresponse.dart';
import 'package:flutter_sheplates/ui/DemoUi/HomeScreen.dart';

import 'package:flutter_sheplates/ui/LoginRegisterScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();

    if (mounted) {
      call();
    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Image.asset("assets/logo.png"),
    );
  }

  call() async {
    bool b = await SharedPrefHelper().getWithDefault("isLogin", false);
    Auth auth = Auth();
    if (b) {
      String userData = await SharedPrefHelper()
          .getWithDefault(SharedPrefConstants.userData, jsonEncode({}));
      String token = await SharedPrefHelper().getWithDefault("token", "");

      Profile profile = Profile.fromJson(jsonDecode(userData));

      auth.profile = profile;
      auth.token = token;
      auth.authState = AuthState.LoggedIn;
    } else {
      auth.authState = AuthState.LoggedOut;
    }

    Future.delayed((Duration(seconds: 5))).then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (buildContext) =>
                  b ? HomeScreen() : LoginRegisterScreen()));
    });
  }


}
