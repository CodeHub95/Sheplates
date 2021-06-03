import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/Routes.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/auth/RestApiCalls.dart';
import 'package:flutter_sheplates/modals/response/BaseResponse.dart';
import 'package:flutter_sheplates/ui/DeliveryAddress.dart';
import 'package:geocoder/geocoder.dart';

class LocationCheckScreen extends StatefulWidget {
  final Address address;
  final String type;

  const LocationCheckScreen({Key key, this.type, this.address}) : super(key: key);

  @override
  _LocationCheckScreenState createState() => _LocationCheckScreenState(this.address, this.type);
}

class _LocationCheckScreenState extends State<LocationCheckScreen> {
  final Address address;
  final String type;
  StreamController<BaseResponse> streamController = StreamController.broadcast();

  _LocationCheckScreenState(this.address, this.type);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLocation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    streamController?.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
          body: SingleChildScrollView(
              child: StreamBuilder<BaseResponse>(
                  stream: streamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(fit: BoxFit.fill, image: AssetImage("assets/login_bg.png"))),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(top: 100),
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
                                Column(children: <Widget>[
                                  Text(
                                    snapshot.data.statusCode != "Keep me posted"
                                        ? "Your locality isn't launched yet but you can request a call back"
                                        : "We aren't in your city yet, but we can keep you posted on the launch",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
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
                                            (snapshot.data.statusCode),
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          onPressed: () async {
                                            RestApiCalls apiCalls = RestApiCalls();

                                            String token = await SharedPrefHelper().getWithDefault('token', "");

                                            CommonUtils.fullScreenProgress(context);
                                            apiCalls
                                                .userAddUserRequest(
                                                    jsonEncode({
                                                      'type': snapshot.data.statusCode,
                                                      'category': 'Location',
                                                      'address': widget.address.addressLine
                                                    }),
                                                    token)
                                                .then((value) {
                                              CommonUtils.dismissProgressDialog(context);
                                              if (value.status == 200) {
                                                if (type == "add") {
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => DeliveryAddress(),
                                                      ),
                                                      (Route<dynamic> route) => false);
                                                } else {
                                                  CommonUtils.showToast(
                                                    msg: "Thanks, we will ",
                                                  );
                                                  Navigator.of(context).pushReplacementNamed(Routes.homeScreen);
                                                }
                                              } else {
                                                CommonUtils.errorMessage(msg: value.message);
                                              }
                                            }).catchError((error) {
                                              CommonUtils.dismissProgressDialog(context);
                                              CommonUtils.errorMessage(
                                                  msg: "Something Went wrong  ! Please retry again");
                                            });
                                          })),
                                  Padding(
                                    padding: EdgeInsets.only(top: 230),
                                  ),
                                ])
                              ]));
                    } else {
                      return CommonUtils.fullScreenProgressWidget(context);
                    }
                  }))),
    );
  }

  void checkLocation() async {
    RestApiCalls apiCalls = RestApiCalls();

    String token = await SharedPrefHelper().getWithDefault("token", "");
    apiCalls
        .confirmDeliveryAddress(
            jsonEncode({'latitude': address.coordinates.latitude, 'longitude': address.coordinates.longitude}), token)
        .then((value) {
      if (value.status == 200) {
        streamController.sink.add(value);
        if (value.statusCode == "success") {
          if (type == "add") {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => DeliveryAddress(),
                ),
                (Route<dynamic> route) => false);
          } else {
            Navigator.of(context).pushReplacementNamed(Routes.homeScreen);
          }
        }
      } else {
        streamController.sink.addError(value.message);
      }
    }).catchError((error) {
      streamController.sink.addError(error);
    });
  }
}
