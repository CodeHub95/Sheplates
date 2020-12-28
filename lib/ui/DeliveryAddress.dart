import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/Routes.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/modals/request/AddDeliveryAddressRequest.dart';
import 'package:flutter_sheplates/modals/request/PauseSubscriptionRequest.dart';
import 'package:flutter_sheplates/modals/request/SetAddressRequest.dart';
import 'package:flutter_sheplates/modals/response/BaseResponse.dart';
import 'package:flutter_sheplates/modals/response/GetAddressList.dart';
import 'package:flutter_sheplates/ui/ChooseLocation.dart';
import 'package:flutter_sheplates/ui/DrawerScreen.dart';

class DeliveryAddress extends StatefulWidget {
  @override
  _DeliveryAddressState createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  TextEditingController locationController = TextEditingController();
  int sid;

// Declare this variable
  int selectedRadioTile;
  int selectedRadio;
  int _value = 0;

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    getAddressList();
  }

  StreamController<List<Rows>> _streamController = StreamController.broadcast();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _streamController?.close();
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
                    "Delivery Address",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    textAlign: TextAlign.center,
                  ))),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Image.asset(
                "assets/left_menu.png",
                fit: BoxFit.fill,
                // color: Colors.transparent,
              ),
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
          Container(
              child: StreamBuilder<List<Rows>>(
                  stream: _streamController.stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      );
                    if (snapshot.data.length != 0) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 50, left: 20),
                            child: Row(
                              children: [
                                Text(
                                  " Current Address",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(8),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey,
                                              // set border color
                                              width: 1.0),
                                          // set border width
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            snapshot.data[index].fullAddress,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                .copyWith(
                                                    color: index ==
                                                            snapshot.data.length
                                                        ? Colors.black38
                                                        : Colors.black),
                                          ),
                                          leading: Radio(
                                            value: index,
                                            groupValue: _value,
                                            activeColor: Color(0xFF6200EE),
                                            onChanged:
                                                index == snapshot.data.length
                                                    ? null
                                                    : (int value) {
                                                        setState(() {
                                                          _value = value;
                                                          print(
                                                              "radioButton: $_value");
                                                        });
                                                      },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                        top: 30,
                                      )),
                                    ]);
                              }),
                          Container(
                              padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                              height: 60,
                              width: 400,
                              child: RaisedButton(
                                  color: HexColor("#FF5657"),
                                  textColor: Colors.white,
                                  child: Text(
                                    'Add More',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  onPressed: () => {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ChooseLocation(
                                                type: "add",
                                                is_delivery: 0,
                                              ),
                                            ),
                                            (Route<dynamic> route) => false)
                                      })),
                          Container(
                              padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                              height: 60,
                              width: 400,
                              child: RaisedButton(
                                  // color: HexColor("#FF5657"),
                                  color: HexColor("#FF5657"),
                                  textColor: Colors.white,
                                  child: Text(
                                    'Change Address',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_value == null) {
                                    } else {
                                      CommonUtils.fullScreenProgress(context);
                                      String token = await SharedPrefHelper()
                                          .getWithDefault("token", "");
                                      print(token);

                                      SetAddressRequest request =
                                          SetAddressRequest(
                                              latitude: snapshot
                                                  .data[_value].latitude,
                                              longitude: snapshot
                                                  .data[_value].longitude);

                                      int sid = snapshot.data[_value].id;
                                      String url = "user/set-delvery-address/";
                                      var res = await NetworkUtil().post(
                                          url: url + sid.toString(),
                                          body: jsonEncode(request),
                                          token: token);

                                      BaseResponse response =
                                          BaseResponse.fromJson(res);

                                      if (response.status == 200) {
                                        CommonUtils.dismissProgressDialog(
                                            context);

                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            Routes.homeScreen,
                                            (route) => false);
                                        CommonUtils.showToast(
                                            msg: response.message,
                                            bgColor: Colors.black,
                                            textColor: Colors.white);
                                      } else {
                                        CommonUtils.errorMessage(
                                            msg: response.message);
                                        CommonUtils.dismissProgressDialog(
                                            context);
                                      }
                                    }
                                  })),
                        ],
                      );
                    } else {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: Text(
                                  "Not Available",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                        ),
                      );
                    }
                  }))
        ])));
  }

  getAddressList() async {
    String token = await SharedPrefHelper().getWithDefault("token", "");
    var res = await NetworkUtil().get("user/address-list", token: token);
    PauseSubscriptionRequest request = PauseSubscriptionRequest(token: token);
    GetAddressResponse response = GetAddressResponse.fromJson(res);

    if (response.status == 200) {
      _streamController.sink.add(response.data.address.rows);

      int i = 0;
      response.data.address.rows.forEach((element) {
        if (element.isDeliveryAddress == 1) {
          _value = i;
        }
        i++;
      });

      setState(() {});
    } else {
      CommonUtils.showToast(
          msg: "Please Select Delivery Address",
          bgColor: AppColor.darkThemeBlueColor,
          textColor: Colors.white);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChooseLocation(
                  is_delivery: 0,
                  type: "add",
                )),
      );
    }
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }
}
