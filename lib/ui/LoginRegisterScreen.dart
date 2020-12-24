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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(
                  top: 60,
                  bottom: 30
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.fill,
                    // color: Colors.transparent,
                  ),
                )),
            Expanded(
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Healthy",
                          style: TextStyle(fontSize: 18),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                              top: 21,
                            )),
                        Text(
                          "Hygienic",
                          style: TextStyle(fontSize: 18),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                              top: 21,
                            )),
                        Text(
                          "Homemade Food",
                          style: TextStyle(fontSize: 18),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                              top: 21,
                            )),
                        Text(
                          "Delivered",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    Image.asset(
                      ("assets/cooking_bottom.png"),
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ]),
            ),
            Row(
              children: [
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
