import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/Routes.dart';
import 'package:flutter_sheplates/Utils/app_constants.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/auth/Auth.dart';
import 'package:flutter_sheplates/modals/request/registrationrequest.dart';
import 'package:flutter_sheplates/modals/response/loginresponse.dart';

class RegisterDetailScreen extends StatefulWidget {
  RegisterDetailScreen(this.phoneNumber);

  String phoneNumber;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RegisterDetailScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  TextEditingController numberController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController confirmpasswordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  bool checkboxValue = false;
  String email;
  String password;
  String gender;
  String phoneNo;
  String dob;
  String name;

  @override
  void initState() {
    super.initState();
    getdetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/login_bg.png"))),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 100,
                    child: ListTile(
                      title: Padding(
                        padding: EdgeInsets.fromLTRB(5, 40, 0, 10),
                        child: Text(
                          ('REGISTER'),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                  ),
                  Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "First Name"),
                            validator: (val) {
                              if (val.isEmpty) {
                                return ("Please Enter Name");
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) => {
                              nameController.text = val,
                              print("on saved name " +
                                  val +
                                  " >> " +
                                  nameController.text),
                              name = val
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: TextFormField(
                            controller: lastnameController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Last Name"),
                            validator: (val) {
                              if (val.isEmpty) {
                                return ("Please Enter Name");
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) => {
                              lastnameController.text = val,
                              print("on saved name " +
                                  val +
                                  " >> " +
                                  lastnameController.text),
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Email id"),
                            controller: emailController,
                            validator: (val) => !val.contains('@')
                                ? "Enter a valid Email"
                                : null,
                            onSaved: (val) => {
                              emailController.text = val,
                              print("on saved name " +
                                  val +
                                  " >> " +
                                  emailController.text),
                              email = emailController.text
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                controller: numberController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Password"),
                            validator: (val) {
                              if (val.isEmpty)
                                return ('Cannot be Empty');
                              else if (val.length < 5)
                                return ('Password must have 5 or more characters');
                              return null;
                            },
                            onSaved: (val) => {
                              passwordController.text = val,
                              print("on saved name " +
                                  val +
                                  " >> " +
                                  passwordController.text),
                              password = passwordController.text
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: TextFormField(
                              obscureText: true,
                              controller: confirmpasswordController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Confirm Password"),
                              validator: (val) {
                                if (val.isEmpty) return ('Cannot be Empty');
                                if (val != passwordController.text)
                                  return ('Password does Not Match');
                                return null;
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            height: 70,
                            width: 500,
                            child: RaisedButton(
                              textColor: Colors.white,
                              color: HexColor("#FF5657"),
                              child: Text(
                                'NEXT',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onPressed: () {
                                submit();
                              },
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                          bottom: 110,
                        )),
                      ])),
                ])),
      )),
    );
  }

  submit() async {
    final form = _formKey.currentState;
    form.save();
    if (form.validate()) {
      CommonUtils.fullScreenProgress(context);
      String url = "user/register";
      String deviceId = await CommonUtils.getDeviceId();
      String deviceToken = await CommonUtils().getFcmToken();
      RegisterRequest request = RegisterRequest(
          phone: numberController.text,
          first_Name: nameController.text,
          last_Name: lastnameController.text,
          email: emailController.text,
          password: passwordController.text,
          deviceId: deviceId,
          deviceToken: deviceToken,
          deviceType: Platform.isAndroid ? "Android" : "Ios");
      var res = await NetworkUtil().post(url: url, body: jsonEncode(request));
      LoginResponse response = LoginResponse.fromJson(res);
      if (response.status == 200) {
        CommonUtils.dismissProgressDialog(context);
        SharedPrefHelper().save("token", response.token);
        SharedPrefHelper().save("isLogin", true);
        await SharedPrefHelper().save(
            SharedPrefConstants.userData, jsonEncode(response.data.profile));
        Auth auth = Auth();
        auth.profile = response.data.profile;
        auth.token = response.token;
        auth.authState = AuthState.LoggedIn;
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.deliveryStaticScreen, (route) => false);
      } else {
        CommonUtils.errorMessage(msg: response.message);
        CommonUtils.dismissProgressDialog(context);
      }
    }
  }

  void getdetails() {
    numberController.text = widget.phoneNumber;
  }
}
