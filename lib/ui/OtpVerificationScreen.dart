import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sheplates/Utils/Routes.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/auth/Auth.dart';
import 'package:flutter_sheplates/auth/database_helper.dart';
import 'package:flutter_sheplates/auth/firebase_utils.dart';
import 'package:flutter_sheplates/ui/ForgotPasswordScreen.dart';
import 'package:flutter_sheplates/ui/RegisterDetails.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:sms_autofill/sms_autofill.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String type;
  final String phoneNumber;
  String verificationId;
  final int forceResendingToken;

  OtpVerificationScreen(this.phoneNumber, this.verificationId,
      this.forceResendingToken, this.type);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<OtpVerificationScreen>
    with FirebaseMethods {
  final _formKey = GlobalKey<FormState>();
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();
  String phoneNumber;
  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  FirebasePresenter presenter;

  @override
  void initState() {
    super.initState();
    onTapRecognizer = TapGestureRecognizer()..onTap = () {};
    @override
    void dispose() {
      errorController.close();

      super.dispose();
    }

    errorController = StreamController<ErrorAnimationType>();

    presenter = FirebasePresenter(this);

    // SmsAutoFill smsAutoFill = SmsAutoFill();
    //
    // smsAutoFill.getAppSignature.then((value) {
    //   print("App Signature " + value);
    //   smsAutoFill.listenForCode.then((value) {
    //     print("Successfully Register");
    //     smsAutoFill.code.listen((event) {
    //       print("@Auto Code Read " + event);
    //       textEditingController.text = event;
    //     });
    //   });
    // });
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 60),
                          child: Container(
                            height: 180,
                            width: 150,
                            alignment: Alignment.bottomLeft,
                            child: Image.asset(
                              "assets/img1.png",
                              fit: BoxFit.fill,
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 170),
                          child: Container(
                            height: 100,
                            width: 80,
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/otp_verification.png",
                              fit: BoxFit.fill,
                              // color: Colors.transparent,
                            ),
                          )),
                      Container(
                        height: 150,
                        width: 130,
                        alignment: Alignment.topRight,
                        // width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          "assets/img2.png",
                          fit: BoxFit.fill,
                          // color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 100,
                    child: ListTile(
                      title: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          ('OTP Verification'),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(20.0),
                      subtitle: RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Please Enter your OTP Send your Mobile\n",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.0)),
                        TextSpan(
                            text: "Number",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.0)),
                      ])),
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
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 20),
                            child: PinCodeTextField(
                              length: 6,
                              obsecureText: false,
                              textInputType: TextInputType.number,
                              animationType: AnimationType.fade,
                              validator: (v) {
                                if (v.length < 6) {
                                  return "*Please fill up all the cells properly";
                                } else {
                                  return null;
                                }
                              },
// backgroundColor: Colors.orange,
                              pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(3),
                                  fieldHeight: 50,
                                  fieldWidth: 40,
                                  selectedColor: Colors.deepOrange,
                                  inactiveColor: Colors.grey,
                                  activeColor: Colors.deepOrange,
                                  activeFillColor: Colors.deepOrange),

                              animationDuration: Duration(milliseconds: 300),

                              errorAnimationController: errorController,
                              controller: textEditingController,
                              onCompleted: (v) {
                                print("Completed");
                              },
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  currentText = value;
                                });
                              },
                              beforeTextPaste: (text) {
                                print("Allowing to paste $text");
                                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                return true;
                              },
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 25,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Didn't get the code?",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      textEditingController.clear();
                                      CommonUtils.fullScreenProgress(context);
                                      presenter.doPhoneAuth(widget.phoneNumber,
                                          forceResendingToken:
                                              widget.forceResendingToken, );
                                      CommonUtils.showToast(
                                          msg: "Successfully RESEND",
                                          bgColor: Colors.red,
                                          textColor: Colors.white);
                                    },
                                    child: Text(
                                      "RESEND",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 35,
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
                                ('VERIFY'),
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
    if (currentText.length != 6) {
      errorController
          .add(ErrorAnimationType.shake); // Triggering error shake animation
      setState(() {
        hasError = true;
      });
    } else {
      CommonUtils.fullScreenProgress(context);
      _signInWithPhoneNumber();
      setState(() {
        hasError = false;
      });
    }
  }

  void _signInWithPhoneNumber() async {
    CommonUtils.dismissProgressDialog(context);
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: widget.verificationId,
      smsCode: textEditingController.text,
    );
    print("ppppppppp" + widget.verificationId);
    FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
      //CommonUtils.dismissProgressDialog(context);
      if (value.user != null) {
        Auth auth = Auth();
        auth.firebaseUser = value.user;
        if (widget.type == "register") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterDetailScreen(widget.phoneNumber),
            ),
          );
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => ForgotPasswordScreen(
                  phoneNumber: widget.phoneNumber,
                ),
              ),
              (Route<dynamic> route) => false);
        }
      }
    }).catchError((error) {
      //CommonUtils.dismissProgressDialog(context);
      if (error is PlatformException) {
        CommonUtils.showToast(
            msg: error.message, textColor: Colors.white, bgColor: Colors.red);
      }
    });
    // await .verifyPhoneNumber(
    //     timeout: Duration(seconds: 0),
    //     codeAutoRetrievalTimeout: null
    // );

  }

  @override
  void onCodeAutoRetrievalTimeout(String verificationId) {

    print("@Code Auto " + verificationId);
  }

  @override
  void onCodeSent(String verificationId, [int forceResendingToken]) {
    print("@Code Sent " + verificationId);

    CommonUtils.dismissProgressDialog(context);
    widget.verificationId = verificationId;
  }

  @override
  void onVerificationCompleted(AuthCredential phoneAuthCredential) {
    FirebaseAuth.instance
        .signInWithCredential(phoneAuthCredential)
        .then((value) async {
      if (value.user != null) {
        print("done");
        Auth auth = Auth();

        auth.firebaseUser = value.user;
        DocumentSnapshot snapshot = await Firestore.instance
            .collection(DatabaseConstants.user_db)
            .document(auth.firebaseUser.uid)
            .get();
        if (widget.type == "register") {
          Navigator.of(context).pushNamedAndRemoveUntil(
            snapshot.exists ? Routes.homeScreen : Routes.registerdetailScreen,
            (route) => false,
            // arguments: {"isFromLogin": true}
          );
        } else {
          if (snapshot.exists) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.homeScreen,
              (route) => false,
              // arguments: {"isFromLogin": true}
            );
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => ForgotPasswordScreen(
                          phoneNumber: widget.phoneNumber,
                        )),
                (Route<dynamic> route) => false);
          }
        }
      }
    });
  }

  @override
  void onVerificationFailed(AuthException authException) {
    CommonUtils.dismissProgressDialog(context);
    print("@Code Exception " + authException.message);
    CommonUtils.showToast(
        msg: authException.message,
        textColor: Colors.white,
        bgColor: Colors.red);
  }

  // @override
  // void codeUpdated() {
  //   print("Code Updated");
  //   textEditingController.text = code;
  // }

}
