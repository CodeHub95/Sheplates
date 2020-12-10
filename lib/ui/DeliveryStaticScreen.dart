import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_sheplates/Utils/Routes.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/ui/ChooseLocation.dart';

class DeliveryStaticScreen extends StatefulWidget {
 final int is_delivery;

  const DeliveryStaticScreen({Key key, this.is_delivery}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState(this.is_delivery);
}

class _MyHomePageState extends State<DeliveryStaticScreen> {
  final _formKey = GlobalKey<FormState>();
  final int is_delivery;
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool checkboxValue = false;

  _MyHomePageState(this.is_delivery);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
          // backgroundColor: Colors.white,
          body: SingleChildScrollView(
        child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/login_bg.png"))),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    "assets/delivery_boy.png",
                                    fit: BoxFit.fill,
                                  ),
                                )),
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 70,
                      ),
                    ),
                    Form(
                        key: _formKey,
                        child: Column(children: <Widget>[
                          Text(
                            "Let's now set up your delivery!",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 40,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              height: 40,
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  color: AppColor.themeButtonColor,
                                  textColor: Colors.white,
                                  child: Text(
                                    ('Set Delivery Location'),
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  // onPressed: () => Navigator.of(context)
                                  //     .pushReplacementNamed(
                                  //         Routes.chooseLocation)
                                onPressed: ()=>{
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ChooseLocation(
                                is_delivery: 1,

                                )),
                                )
                                },
                              )
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 230),
                          ),
                        ]))
                  ])))),
    );
  }
}
