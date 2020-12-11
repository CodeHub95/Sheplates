import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_sheplates/Utils/Routes.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/auth/Auth.dart';
import 'package:flutter_sheplates/auth/database_helper.dart';
import 'package:flutter_sheplates/auth/firebase_utils.dart';
import 'package:flutter_sheplates/ui/OtpVerificationScreen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class RegisterScreen extends StatefulWidget {
  final String type;

  const RegisterScreen({Key key, this.type}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RegisterScreen> with FirebaseMethods {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = new TextEditingController();

  bool checkboxValue = false;
  static FirebaseAuth firebaseAuth;
  static BuildContext _context;

  static String phoneNumber;
  static String verificationId;

  String code = "+91";

  FirebasePresenter presenter;

  @override
  void initState() {
    if (widget.type == "register") {
      checkboxValue = false;
    } else {
      checkboxValue = true;
    }
    super.initState();
    phoneController = TextEditingController();

    firebaseAuth = FirebaseAuth.instance;

    presenter = FirebasePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
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
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(top: 60),
                              child: Container(
                                height: 180,
                                width: 180,
                                alignment: Alignment.bottomLeft,
                                // width: MediaQuery.of(context).size.width,
                                child: Image.asset(
                                  "assets/img1.png",
                                  fit: BoxFit.fill,
                                  // color: Colors.transparent,
                                ),
                              )),
                          Container(
                            height: 150,
                            width: 150,
                            alignment: Alignment.topRight,
                            // width: MediaQuery.of(context).size.width,
                            child: Image.asset(
                              "assets/img2.png",
                              fit: BoxFit.fill,
                              // color: Colors.transparent,
                            ),
                          ),
                        ],
                      )),
                  Container(
                    height: 100,
                    child: ListTile(
                      title: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          (widget.type == "register"
                              ? 'REGISTER'
                              : 'Forgot Password?'),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 25,
                            // color: HexColor("#122345"),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(20.0),
                      subtitle: Visibility(
                        visible: widget.type == "register" ? true : false,
                        child: RichText(
                            text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Enter your ",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 15.0)),
                          TextSpan(
                              text: "Mobile Number ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0)),
                          TextSpan(
                              text: "&\n",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 15.0)),
                          TextSpan(
                              text: "Get ",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 15.0)),
                          TextSpan(
                              text: "HOME MADE FOOD",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0)),
                        ])
                            // 'I agree.',
                            // style: TextStyle(fontSize: 14.0),
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 40.0, right: 15, left: 15),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              return validateMobile(value)
                                  ? null
                                  : "Please enter valid mobile number";
                            },
                            controller: phoneController,
                            decoration: InputDecoration(
                              prefixIcon: CountryCodePicker(
                                onChanged: _onCountryChange,
                                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                initialSelection: 'IN',
                                // favorite: ['+39','FR'],
                                // optional. Shows only country name and flag
                                showCountryOnly: false,
                                // optional. Shows only country name and flag when popup is closed.
                                showOnlyCountryWhenClosed: false,
                                // optional. aligns the flag and the Text left
                                alignLeft: false,
                              ),
                              // border: OutlineInputBorder(),
                              labelText: ('Enter Mobile number'),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                            /*validator: (val) {
                              if (val.length > 13)
                                return ('Please enter a valid Mobile Number Eg.+917070707070');
                              else {
                                return null;
                              }
                            },*/
                            onChanged: (phone) {
                              phoneNumber = phoneController.text;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(0),
                            child: Visibility(
                              visible: widget.type == "register" ? true : false,
                              child: CheckboxListTile(
                                value: checkboxValue,
                                onChanged: (val) {
                                  setState(() => checkboxValue = val);
                                },
                                title: new RichText(
                                    text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: "I Agree ",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14.0)),
                                  TextSpan(
                                      text: "TERMS & CONDITIONS",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16.0)),
                                ])
                                    // 'I agree.',
                                    // style: TextStyle(fontSize: 14.0),
                                    ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                activeColor: Colors.green,
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 25,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              color: AppColor.themeButtonColor,
                              textColor: Colors.white,
                              // color: HexColor("#10acff"),
                              child: Text(
                                ('CONTINUE'),
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w700),
                              ),

                              onPressed: () => submit(),
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 150),
                        ),
                      ]))
                ])),
      )),
    );
  }

  submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      if (!checkboxValue) {
        CommonUtils.showToast(
            msg: "Please select terms and conditions",
            bgColor: AppColor.darkThemeBlueColor,
            textColor: Colors.white);
      } else {
        FocusScope.of(context).requestFocus(FocusNode());
        CommonUtils.fullScreenProgress(context);
        presenter.doPhoneAuth(code + phoneNumber);
      }
    } else {
      CommonUtils.showToast(
          msg: "Please enter valid mobile number",
          bgColor: AppColor.darkThemeBlueColor,
          textColor: Colors.white);
    }
  }

  @override
  void onCodeAutoRetrievalTimeout(String verificationId) {
    print("@Code Auto " + verificationId);
  }

  @override
  void onCodeSent(String verificationId, [int forceResendingToken]) {
    print("@Code Sent " + verificationId);
    print("phone number" + phoneNumber);
    CommonUtils.dismissProgressDialog(_context);
    verificationId = verificationId;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpVerificationScreen(code + phoneNumber,
            verificationId, forceResendingToken, widget.type),
      ),
    );
  }

  @override
  void onVerificationCompleted(AuthCredential phoneAuthCredential) {
    firebaseAuth.signInWithCredential(phoneAuthCredential).then((value) async {
      if (value.user != null) {
        print("done");
        Auth auth = Auth();
        auth.firebaseUser = value.user;

        DocumentSnapshot snapshot = await Firestore.instance
            .collection(DatabaseConstants.user_db)
            .document(auth.firebaseUser.uid)
            .get();

        Navigator.of(context).pushNamedAndRemoveUntil(
            snapshot.exists ? Routes.homeScreen : Routes.registerdetailScreen,
            (route) => false,
            arguments: {"isFromLogin": true});
      }
    });
  }

  @override
  void onVerificationFailed(AuthException authException) {
    CommonUtils.dismissProgressDialog(_context);
    print("@Code Exception " + authException.message);
    CommonUtils.showToast(
        msg: authException.message,
        textColor: Colors.white,
        bgColor: Colors.red);
  }

  bool validateMobile(String phone) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,10}$)';
    RegExp regExp = new RegExp(pattern);
    if (phone.isEmpty) {
      return false;
    }
    else if (!regExp.hasMatch(phone)) {
      return false;
    }
    return true;
  }

  void _onCountryChange(CountryCode countryCode) {
    //TODO : manipulate the selected country code here
    print("New Country selected: " + countryCode.toString());
    code = countryCode.toString();
  }
}
