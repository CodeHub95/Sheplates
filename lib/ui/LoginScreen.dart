import 'dart:convert';
import 'dart:io';
import 'CategoryScreen.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/app_constants.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/auth/Auth.dart';
import 'package:flutter_sheplates/modals/request/loginrequest.dart';
import 'package:flutter_sheplates/modals/response/loginresponse.dart';
import 'package:flutter_sheplates/ui/HomeScreen.dart';
import 'package:flutter_sheplates/ui/RegisterScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool checkboxValue = false;
  String code = "+91";

  @override
  void initState() {
    super.initState();
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
                image: AssetImage("assets/login_bg.png"),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 40,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.fill,
                          // color: Colors.transparent,
                        ),
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
                        ('LOGIN'),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(20.0),
                    subtitle: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: "and ", style: TextStyle(color: Colors.grey, fontSize: 14.0)),
                          TextSpan(text: "Order ", style: TextStyle(color: Colors.grey, fontSize: 14.0)),
                          TextSpan(
                            text: "Homemade FOOD",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                        ],
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
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
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
                            border: OutlineInputBorder(),
                            labelText: ('Enter Mobile number'),
                          ),
                          controller: phoneController,
                          validator: (val) {
                            if (val.isEmpty) {
                              return ('Please Enter Mobile number');
                            } else if (val.length > 10) {
                              return ('Please Enter Valid Mobile number');
                            } else
                              return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 20,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: ('Password'),
                          ),
                          validator: (val) {
                            if (val.isEmpty) {
                              return ('Required Password');
                            } else if (val.length < 5) {
                              return ('Password must have 5 or more characters');
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, left: 200),
                        child: GestureDetector(
                          child: Text(
                            ("Forgot Password?"),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(
                                  type: "forget",
                                ),
                              ),
                              (Route<dynamic> route) => false,
                            );
                            // do what you need to do when "Click here" gets clicked
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword()));
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: CheckboxListTile(
                          value: checkboxValue,
                          onChanged: (val) {
                            setState(() => checkboxValue = val);
                          },
                          title: new RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: "I Agree ", style: TextStyle(color: Colors.grey, fontSize: 14.0)),
                                TextSpan(
                                  text: "TERMS OF USE",
                                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () async {
                                      final url =
                                          'https://sheplates-staging-959022279.ap-south-1.elb.amazonaws.com/terms-of-use';
                                      if (await canLaunch(url)) {
                                        await launch(
                                          url,
                                          forceSafariVC: false,
                                        );
                                      }
                                    },
                                ),
                                // onTap = () { launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                              ],
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Colors.green,
                        ),
                      ),
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
                            ('LOGIN'),
                            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                          ),

                          onPressed: () => submit(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 70),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  submit() async {
    final form = _formKey.currentState;
    form.save();
    if (form.validate()) {
      if (checkboxValue) {
        CommonUtils.fullScreenProgress(context);
        String url = "user/login";
        String deviceId = await CommonUtils.getDeviceId();
        String deviceToken = await CommonUtils().getFcmToken();
        LoginRequest request = LoginRequest(
          phone: code + phoneController.text,
          password: passwordController.text,
          deviceId: deviceId,
          deviceToken: deviceToken,
          deviceType: Platform.isAndroid ? "Android" : "Ios",
        );
        var res = await NetworkUtil().post(url: url, body: request);
        LoginResponse response = LoginResponse.fromJson(res);
        if (response.status == 200) {
          CommonUtils.dismissProgressDialog(context);
          await SharedPrefHelper().save("token", response.token);
          await SharedPrefHelper().save("isLogin", true);
          await SharedPrefHelper().save(SharedPrefConstants.userData, jsonEncode(response.data.profile));
          await SharedPrefHelper().save("phone", response.data.profile.phone.toString());
          await SharedPrefHelper().save("email", response.data.profile.email.toString());
          Auth auth = Auth();
          auth.profile = response.data.profile;
          auth.token = response.token;
          auth.authState = AuthState.LoggedIn;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false,
          );

          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(builder: (context) => CategoryScreen()),
          //   (route) => false,
          // );
        } else {
          CommonUtils.dismissProgressDialog(context);
          CommonUtils.errorMessage(msg: response.message);
        }
      } else {
        CommonUtils.showToast(
            msg: "Please select terms and conditions", bgColor: AppColor.darkThemeBlueColor, textColor: Colors.white);
      }
    }
  }

  void _onCountryChange(CountryCode countryCode) {
    //TODO : manipulate the selected country code here
    print("New Country selected: " + countryCode.toString());
    code = countryCode.toString();
  }
}
