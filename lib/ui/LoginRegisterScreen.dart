import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/ui/LoginScreen.dart';
import 'package:flutter_sheplates/ui/RegisterScreen.dart';

class LoginRegisterScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginRegisterScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Align(
          alignment: Alignment.center,
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/main_bg.png"),
                        fit: BoxFit.cover)),
              ),
              Positioned(
                  bottom: 0,
                  child: Row(children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      color: AppColor.themeButtonColor,
                      child: Row(children: <Widget>[
                        Expanded(
                          child: FlatButton(
                            child: Text(
                              "LOGIN",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: double.maxFinite,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: FlatButton(
                            child: Text(
                              "REGISTER",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen(
                                        type: "register",
                                      )),
                            ),
                          ),
                        )
                      ]),
                    )
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
