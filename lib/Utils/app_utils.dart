import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/ui/stateful/edit_address_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:fluttertoast/fluttertoast.dart' as toast;
import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';

enum AddressType { Apartment, Work }

class CommonUtils {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Future<String> getFcmToken() async {
    String token = await firebaseMessaging.getToken();
    return token;
  }

  static getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      print("Device id for ios: " + iosDeviceInfo.identifierForVendor);
      return iosDeviceInfo.identifierForVendor.toString(); // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      print(androidDeviceInfo.version);
      return androidDeviceInfo.androidId.toString(); // unique ID on Android
    }
  }

  static String getSimpleDate(DateTime dateTime) {
    if (dateTime != null) {
      var formatter = new DateFormat('dd MMMM yyyy');
      String formatted = formatter.format(dateTime);
      return formatted;
    }
    return "";
  }

  static String getSimpleDateForApi(DateTime dateTime) {
    if (dateTime != null) {
      var formatter = new DateFormat('yyyy-MM-dd');
      String formatted = formatter.format(dateTime);
      return formatted;
    }
    return "";
  }

  static Future<DateTime> setCalender(BuildContext context,
      {DateTime initialDate}) async {
    final DateTime selectDate = await showDatePicker(
        context: context,
        initialDate: initialDate != null ? initialDate : DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(3000));

    return selectDate;
  }

  static String getDate(String date) {
    if (date == "null") {
      return "";
    }
    var _date = DateTime.parse(date);
    return new DateFormat("d MMM y").format(_date);
  }

  static String getPauseDate(String date) {
    if (date == "null") {
      return "";
    }
    var _date = DateTime.parse(date);
    return new DateFormat("yyyy-MM-dd").format(_date);
  }

  // ignore: missing_return
  static Future<bool> isNetworkAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static dismissProgressDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static void fullScreenProgress(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            child: Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SpinKitFadingCircle(
                        color: AppColor.lightThemeBlueColor,
                      ),
                    )),
              ),
            ),
            onWillPop: () {},
          );
        });
  }

  static Widget fullScreenProgressWidget(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SpinKitFadingCircle(
                color: AppColor.lightThemeBlueColor,
              ),
            )),
      ),
    );
  }

  static void fullScreenProgressWithMessage(
      BuildContext context, String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Center(
                  child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: SpinKitDualRing(
                                color: Colors.black,
                              ),
                            ),
                            // Expanded(
                            //     child: Padding(
                            //   padding: const EdgeInsets.only(left: 50.0),
                            //   child: ScreenUtils.customText(
                            //       data: message,
                            //       fontSize: 18,
                            //       fontWeight: FontWeight.w600),
                            // ))
                          ],
                        ),
                      )),
                ),
              ),
            ),
            onWillPop: () {},
          );
        });
  }

  static void showToast(
      {Key key,
      @required String msg,
      @required Color bgColor,
      @required Color textColor}) {
    toast.Fluttertoast.showToast(
        msg: msg,
        toastLength: toast.Toast.LENGTH_SHORT,
        gravity: toast.ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: bgColor,
        textColor: textColor,
        fontSize: 15.0);
  }

  static void showSnackBar(
      GlobalKey<ScaffoldState> scaffoldState, String message,
      {@required MaterialColor backgroundColor,
      @required Function onClick,
      @required String actionText,
      @required Color color}) {
    if (message.isEmpty) return;
    // Find the Scaffold in the Widget tree and use it to show a SnackBar
    scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: actionText,
        onPressed: onClick,
        textColor: color,
      ),
    ));
  }

  static errorMessage({@required msg}) {
    showToast(msg: msg, bgColor: Colors.red, textColor: Colors.white);
  }

  static List<AddressTypeModal> getAllAddressType() {
    List<AddressTypeModal> list = List();
    list.add(AddressTypeModal(AddressType.Apartment, "Apartment"));
    list.add(AddressTypeModal(AddressType.Work, "Work"));
    return list;
  }

  static Future<Address> getAddressDetailsFromLatLong(
      BuildContext context, Coordinates latLng) async {
    List<Address> addresses =
        await Geocoder.local.findAddressesFromCoordinates(latLng);

    if (addresses != null && addresses.length != 0) {
      return addresses[0];
    }
    return null;
  }
}
