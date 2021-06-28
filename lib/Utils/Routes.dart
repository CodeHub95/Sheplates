import 'package:flutter/material.dart';
import 'package:flutter_sheplates/ui/ChooseLocation.dart';
import 'package:flutter_sheplates/ui/DeliveryStaticScreen.dart';
import 'package:flutter_sheplates/ui/HomeScreen.dart';
import 'package:flutter_sheplates/ui/CategoryScreen.dart';
import 'package:flutter_sheplates/ui/LoginScreen.dart';
import 'package:flutter_sheplates/ui/OtpVerificationScreen.dart';
import 'package:flutter_sheplates/ui/PaymentScreen.dart';
import 'package:flutter_sheplates/ui/ProceedToPayment.dart';
import 'package:flutter_sheplates/ui/RegisterScreen.dart';
import 'package:flutter_sheplates/ui/SplashScreen.dart';
import 'package:flutter_sheplates/ui/custom/date_range_picker.dart';

class Routes {
  static const String initialRoute = "/";
  static const String loginScreen = "/Login";
  static const String homeScreen = "/homeScreen";
  static const String otpVerificationScreen = "/OtpVerificationScreen";
  static const String registerScreen = "/RegisterScreen";
  static const String registerdetailScreen = "/RegisterDetailScreen";
  static const String chooseLocation = "/ChooseLocation";
  static const String deliveryStaticScreen = "/DeliveryStaticScreen";
  static const String vegitarianLunch = "/VegitarianLunch";
  static const String rangePickerPage = "/RangePickerPage";
  static const String proceedToPayment = "/ProceedToPayment";
  static const String paymentscreen = "/PaymentScreen";
  static const String pauseSubscription = "/PauseSubscription";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map map = settings.arguments;
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());

      case registerScreen:
        return MaterialPageRoute(builder: (context) => RegisterScreen());

      // case chooseLocation:
      //   return MaterialPageRoute(builder: (context) => ChooseLocation(type: map['add'],is_delivery: map['is_delivery_address'],));
      case rangePickerPage:
        return MaterialPageRoute(
            builder: (context) => RangePickerPage(events: [], selectionType: map['selectionType']));

      case proceedToPayment:
        return MaterialPageRoute(builder: (context) => ProceedToPayment(orders: map['order']));

      case deliveryStaticScreen:
        return MaterialPageRoute(builder: (context) => DeliveryStaticScreen());

      case homeScreen:
        // return MaterialPageRoute(builder: (context) => HomeScreen());
        return MaterialPageRoute(builder: (context) => CategoryScreen());

      case paymentscreen:
        return MaterialPageRoute(builder: (context) => PaymentScreen(orders: map['order']));

      case otpVerificationScreen:
        return MaterialPageRoute(
            builder: (context) => OtpVerificationScreen(
                map['mobileNumber'], map['verificationId'], map['forceResendingToken'], map['type']));

      default:
        return MaterialPageRoute(builder: (context) => SplashScreen());
    }
  }
}
