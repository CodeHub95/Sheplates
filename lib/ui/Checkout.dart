import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/Routes.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/Utils/app_constants.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/auth/api_config.dart';
import 'package:flutter_sheplates/modals/request/CheckOutRequest.dart';
import 'package:flutter_sheplates/modals/request/CreateOrderOnRazorRequest.dart';
import 'package:flutter_sheplates/modals/request/PaymentSubmitRequest.dart';
import 'package:flutter_sheplates/modals/request/StockCheckRequest.dart';
import 'package:flutter_sheplates/modals/response/CheckOutResponse.dart';
import 'package:flutter_sheplates/modals/response/CreateOrderOnRazorResponse.dart';
import 'package:flutter_sheplates/modals/response/StockCheckOutResponse.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Checkout extends StatefulWidget {
  final CheckOutResponse stockCheckOutResponse;
  final StockCheckRequest stockCheckRequest;

  const Checkout({Key key, this.stockCheckOutResponse, this.stockCheckRequest})
      : super(key: key);

  @override
  _HomeScreenState createState() =>
      _HomeScreenState(this.stockCheckOutResponse, this.stockCheckRequest);
}

class _HomeScreenState extends State<Checkout> {
  final CheckOutResponse stockCheckOutResponse;
  final StockCheckRequest stockCheckRequest;

  _HomeScreenState(this.stockCheckOutResponse, this.stockCheckRequest);

  String create_order_id;
  Razorpay _razorpay;
  num amount;
  String currency;
  String receipt;
  int payment_capture;

  Future<void> completePayment(
      PaymentSuccessResponse paymentSuccessResponse) async {
    CommonUtils.fullScreenProgress(context);
    String url = "user/payment";
    PaymentSubmitRequest request = PaymentSubmitRequest(
      razorpay_payment_id: paymentSuccessResponse.paymentId,
      razorpay_order_id: paymentSuccessResponse.orderId,
      razorpay_signature: paymentSuccessResponse.signature,
      type: "Payment",
      status: "Success",
      paymentMode: "Razor Pay",
      orderId: stockCheckOutResponse.data.orders.id.toString(),
      amount: stockCheckOutResponse.data.orders.totalAmount.toInt(),
    );
    String token = await SharedPrefHelper().getWithDefault("token", "");
    var res = await NetworkUtil()
        .post(url: url, body: jsonEncode(request), token: token);
    CreateOrderOnRazorResponse response =
        CreateOrderOnRazorResponse.fromJson(res);

    print(response);

    if (response.status == 200) {
      CommonUtils.dismissProgressDialog(context);
      CommonUtils.showToast(
          msg: response.message, bgColor: Colors.red, textColor: Colors.white);
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.proceedToPayment, (route) => false,
          arguments: {'order': stockCheckOutResponse.data.orders});
    } else {
      CommonUtils.errorMessage(msg: response.message);
      CommonUtils.dismissProgressDialog(context);
    }
  }

  void openCheckout(
    String name,
    num amount,
    String order_id,
  ) async {
    print("Order Id " + order_id);
    var options = {
      'key': AppConstants.RazorPayLiveKeyId,
      'amount': amount,
      'name': name,
      'order_id': order_id,
      'description': 'Payment',
      'prefill': {'contact': "1234567890", 'email': "a@gmail.com"},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse paymentSuccessResponse) {
    Fluttertoast.showToast(msg: "SUCCESS: " + paymentSuccessResponse.paymentId);

    String paymentId = paymentSuccessResponse.paymentId.toString();
    String signature = paymentSuccessResponse.signature.toString();
    String orderId = paymentSuccessResponse.orderId.toString();
    completePayment(paymentSuccessResponse);

    print("paymentID: $paymentId");
    print("orderId: $orderId");
    print("signature: $signature");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("@Error");
    print(response.message);
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIos: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
  }

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final color = Theme.of(context).accentColor;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Padding(
              padding: EdgeInsets.only(right: 30),
              child: Center(
                  child: Text(
                "Checkout",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ))),
          leading: Builder(
            builder: (context) => IconButton(
              icon: new Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => {Navigator.pop(context)},
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Stack(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 40.0),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      "assets/order_summary_icon.png"))),
                          child: Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 40, left: 20, right: 20)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              (getDays().toString() +
                                                  " Meal Plan"),
                                              style: TextStyle(
                                                fontSize: 16,
                                              )),
                                          Text(calculatePrice(),
                                              style: TextStyle(
                                                fontSize: 16,
                                              ))
                                        ],
                                      )),
                                  Divider(),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 5,
                                          bottom: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Delivery Charges",
                                              style: TextStyle(
                                                fontSize: 16,
                                              )),
                                          Text(
                                              stockCheckOutResponse
                                                  .data.orders.delieveryCharges
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 16,
                                              ))
                                        ],
                                      )),
                                  Divider(),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 5,
                                          bottom: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Packaging Charges",
                                              style: TextStyle(
                                                fontSize: 16,
                                              )),
                                          Text(
                                              stockCheckOutResponse
                                                  .data.orders.packagingCharges
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 16,
                                              ))
                                        ],
                                      )),
                                  Divider(),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 5,
                                          bottom: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("SGST@2.5%",
                                              style: TextStyle(
                                                fontSize: 16,
                                              )),
                                          Text(
                                              stockCheckOutResponse
                                                  .data.gst.sgst
                                                  .toStringAsFixed(2),
                                              style: TextStyle(
                                                fontSize: 16,
                                              ))
                                        ],
                                      )),
                                  Divider(),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 5,
                                          bottom: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("CGST@2.5%",
                                              style: TextStyle(
                                                fontSize: 16,
                                              )),
                                          Text(
                                              stockCheckOutResponse
                                                  .data.gst.cgst
                                                  .toStringAsFixed(2),
                                              style: TextStyle(
                                                fontSize: 16,
                                              ))
                                        ],
                                      )),
                                  Divider(),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 5,
                                          bottom: 20),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Total",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              stockCheckOutResponse
                                                  .data.orders.totalAmount
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      )),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "ORDER SUMMARY",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ],
                  )),
              ScreenUtils.customButton(context, title: "Proceed to Payment",
                  onCLick: () {
                submit1();
                // submit();
              })
            ])));
  }

  Future<void> submit1() async {
    CommonUtils.fullScreenProgress(context);
    String url = "user/create-order";

    CreateOrderOnRazorRequest request = CreateOrderOnRazorRequest(
      currency: 'INR',
      payment_capture: "",
      receipt: stockCheckOutResponse.data.orders.id.toString(),
      amount: stockCheckOutResponse.data.orders.totalAmount * 100,
    );

    String token = await SharedPrefHelper().getWithDefault("token", "");
    var res = await NetworkUtil()
        .post(url: url, body: jsonEncode(request), token: token);
    CreateOrderOnRazorResponse orderResponse =
        CreateOrderOnRazorResponse.fromJson(res);
    if (orderResponse.status == 200) {
      CommonUtils.dismissProgressDialog(context);
      num amount = orderResponse.data.order.amount;
      String orderId = orderResponse.data.order.id;

      String name = await SharedPrefHelper().getWithDefault("name", "");
      String email = await SharedPrefHelper().getWithDefault("email", "");
      String phone = await SharedPrefHelper().getWithDefault("phone", "");

      openCheckout(
        name, amount, orderId,
        // email, phone
      );
    } else {
      CommonUtils.errorMessage(msg: orderResponse.message);
      CommonUtils.dismissProgressDialog(context);
    }
  }

  String calculatePrice() {
    return (stockCheckOutResponse.data.orders.totalAmount -
            (stockCheckOutResponse.data.gst.sgst +
                stockCheckOutResponse.data.gst.cgst +
                stockCheckOutResponse.data.orders.packagingCharges +
                stockCheckOutResponse.data.orders.delieveryCharges))
        .toStringAsFixed(2);
  }

  String getDays() {
    if (stockCheckOutResponse.data.orders.duration == "weekly") {
      return "7 Days";
    } else if (stockCheckOutResponse.data.orders.duration == "monthly") {
      return "30 Days";
    } else {
      return "Custom" /*stockCheckOutResponse.data.orders.total_meal_count.toString()*/;
    }
  }
}
