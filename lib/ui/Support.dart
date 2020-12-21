import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/Routes.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/modals/request/SupportRequest.dart';
import 'package:flutter_sheplates/modals/response/BaseResponse.dart';
import 'package:flutter_sheplates/ui/DrawerScreen.dart';

class SupportScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<SupportScreen> {
  TextEditingController typeController = new TextEditingController();
  TextEditingController helpController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var type = [
    'Food Quality',
    'Packaging',
    'Payment',
    'Delivery',
    'Food Quantity',
    'App',
    'Other'
  ];

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
              child: Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Text(
                    "Support",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                    textAlign: TextAlign.center,
                  ))),
          leading: Builder(
            builder: (context) => IconButton(
              icon: new Image.asset('assets/left_menu.png'),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          bottom: PreferredSize(
              child: Container(
                color: Colors.grey,
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0)),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50, left: 20),
                    child: Row(
                      children: [
                        Text(
                          "Type",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextFormField(
                      controller: typeController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: ('Food Quality'),
                        suffixIcon: PopupMenuButton<String>(
                          icon: new Image.asset('assets/dropdown.png'),
                          onSelected: (String value) {
                            typeController.text = value;
                          },
                          itemBuilder: (BuildContext context) {
                            return type
                                .map<PopupMenuItem<String>>((String value) {
                              return new PopupMenuItem(
                                  child: new Text(value), value: value);
                            }).toList();
                          },
                        ),
                      ),
                      onSaved: (val) => {
                        typeController.text = val,
                        print("on saved name " +
                            val +
                            " >> " +
                            typeController.text),
                        // gender =   genderController.text
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return ("Please Select Type");
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40, left: 20),
                    child: Row(
                      children: [
                        Text(
                          "How can we help?",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextFormField(
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      controller: helpController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: "Help"),
                      validator: (val) {
                        if (val.isEmpty) return ('Required');
                        return null;
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 40)),
                  Container(
                      padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
                      height: 50,
                      width: 350,
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: HexColor("#FF5657"),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          submit();
                        },
                      )),
                ],
              ))
        ])));
  }

  submit() async {
    final form = _formKey.currentState;

    if (form.validate()) {
      CommonUtils.fullScreenProgress(context);
      String url = "user/add-support";
      String token = await SharedPrefHelper().getWithDefault("token", "");
      SupportRequest request = SupportRequest(
        type: typeController.text,
        details: helpController.text,
      );
      var res = await NetworkUtil()
          .post(url: url, body: jsonEncode(request), token: token);
      BaseResponse response = BaseResponse.fromJson(res);
      if (response.status == 200) {
        _showcontent();
      } else {
        CommonUtils.errorMessage(msg: response.message);
        CommonUtils.dismissProgressDialog(context);
      }
    }
  }

  void _showcontent() {
    showDialog(
      context: context, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          contentPadding: EdgeInsets.all(0),
          content: new SingleChildScrollView(
              child: Container(
            height: 140,
            child: new Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  //change here don't //worked
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          icon: new Image.asset('assets/cross_icon.png'),
                          onPressed: () => {
                                CommonUtils.showToast(
                                    msg: "Successfully Saved",
                                    bgColor: AppColor.darkThemeBlueColor,
                                    textColor: Colors.white),
                                Navigator.pushNamedAndRemoveUntil(context,
                                    Routes.homeScreen, (route) => false)
                              }),
                    )
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Text(
                      'We will resolve your query as soon as possible!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          )),
        );
      },
    );
  }
}
