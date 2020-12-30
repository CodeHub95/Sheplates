import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/modals/request/registrationrequest.dart';
import 'package:flutter_sheplates/modals/response/BaseResponse.dart';
import 'package:flutter_sheplates/ui/LoginRegisterScreen.dart';
import 'package:flutter_sheplates/ui/LoginScreen.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String phoneNumber;

  const ChangePasswordScreen({Key key, this.phoneNumber}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController passwordController = new TextEditingController();

  TextEditingController phoneController = new TextEditingController();

  String password;

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
        // backgroundColor: Colors.white,
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
                      Padding(
                        padding: EdgeInsets.only(
                          top: 100,
                        ),
                      ),
                      Container(
                        height: 100,
                        child: ListTile(
                          title: Padding(
                            padding: EdgeInsets.fromLTRB(5, 40, 0, 10),
                            child: Text(
                              (''),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 25,
                                // color: HexColor("#122345"),
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
                                width: MediaQuery.of(context).size.width * 0.90,
                                height: MediaQuery.of(context).size.height / 2,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      keyboardType: TextInputType.phone,
                                      // validator: validateMobile,
                                      controller: phoneController,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hintText: '+917071000000',
                                        errorBorder: OutlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.red)),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),

                                      validator: (val) {
                                        if (val.length < 13)
                                          return ('Please enter a valid Mobile Number Eg.+917070707070');
                                        else {
                                          return null;
                                        }
                                      },
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 20,
                                      ),
                                    ),

                                    TextFormField(
                                      controller: passwordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: 'New Password',
                                        errorBorder: OutlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.red)),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return ('Required Password');
                                        } else if (val.length < 5 ) {
                                          return ('Password must have 5 or more characters');
                                        }

                                        return null;
                                      },
                                    ),


                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 40,
                                      ),
                                    ),
                                    Container(
                                        padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                        height: 70,
                                        width: 500,
                                        child: RaisedButton(
                                          textColor: Colors.white,
                                          // color: Colors.red,
                                          color: HexColor("#FF5657"),
                                          child: Text(
                                            'CHANGE PASSWORD',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          onPressed: () {
                                            submit();
                                          },
                                        )),
                                  ],
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

    if (form.validate()) {
      form.save();


      CommonUtils.fullScreenProgress(context);
      String url = "user/reset-password";
      String token = await SharedPrefHelper().getWithDefault("token", "");
      RegisterRequest request = RegisterRequest(
        phone: widget.phoneNumber,
        password: passwordController.text,
      );
      var res = await NetworkUtil().putApi(url: url, body: request, token: token);
      if (res != null) {
        BaseResponse baseResponse = BaseResponse.fromJson(res);
        CommonUtils.dismissProgressDialog(context);
        if (baseResponse.status == 200) {
          CommonUtils.showToast(
              msg: "Password reset successfully",
              bgColor: Colors.white,
              textColor: Colors.black);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginRegisterScreen()),
                  (Route<dynamic> route) => false);
        } else {
          CommonUtils.showToast(
              msg: baseResponse.message,
              bgColor: Colors.white,
              textColor: Colors.black);
        }
      } else {
        CommonUtils.dismissProgressDialog(context);
        CommonUtils.errorMessage(msg: "Something went wrong, Please try again");
      }

  }}

  void getdetails() {
    phoneController.text = widget.phoneNumber;
  }
}
