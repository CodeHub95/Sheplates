import 'dart:async';
import 'dart:convert';
import 'package:flutter_sheplates/Utils/Routes.dart';
import 'package:flutter_sheplates/Utils/app_constants.dart';
import 'package:flutter_sheplates/modals/request/CreateOrderOnRazorRequest.dart';
import 'package:flutter_sheplates/modals/request/PaymentSubmitRequest.dart';
import 'package:flutter_sheplates/modals/response/CreateOrderOnRazorResponse.dart';
import 'package:flutter_sheplates/ui/NewFlow/HomeScreenWithTabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/modals/request/ConfirmOrderRequest.dart';
import 'package:flutter_sheplates/modals/response/BaseResponse.dart';
import 'package:flutter_sheplates/modals/response/CardResponse.dart';
import 'package:flutter_sheplates/modals/response/CheckOutResponse.dart';
import 'package:flutter_sheplates/ui/ProceedToPayment.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartScreen extends StatefulWidget {
  final CheckOutResponse stockCheckOutResponse;
  final ConfirmOrderRequestModel confirmOrderRequestModel;

  const CartScreen(
      {Key key, this.stockCheckOutResponse, this.confirmOrderRequestModel})
      : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState(
      this.stockCheckOutResponse, this.confirmOrderRequestModel);
}

class _CartScreenState extends State<CartScreen> {
  final CheckOutResponse stockCheckOutResponse;
  final ConfirmOrderRequestModel confirmOrderRequestModel;
  StreamController<CardResponse> _streamController =
      StreamController.broadcast();
  StreamController<BaseResponse> _deleteController =
      StreamController.broadcast();

  _CartScreenState(this.stockCheckOutResponse, this.confirmOrderRequestModel);

  int oId;
  num totalAmount;
  Razorpay _razorpay;

  CardResponse orders;

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    getCartItem();
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
      orderId: oId.toString(),
      // stockCheckOutResponse.data.orders.id.toString(),
      amount: totalAmount
      // stockCheckOutResponse.data.orders.totalAmount,
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
      // Navigator
      //     .of(context)
      //     .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
      //   return ProceedToPayment( CardResponse);
      // }));
    } else {
      CommonUtils.dismissProgressDialog(context);
    }
  }

  void openCheckout(
      String name,
      int amount,
      String order_id,
      ) async {
    String email = await SharedPrefHelper().getWithDefault("email", "");
    String phone = await SharedPrefHelper().getWithDefault("phone", "");
    print("Order Iddddd " + order_id);
    print("amounttttt " + amount.toString());
    print("nameee " + name);
    print("phoneeee" + phone);
    print("emaillll" + email);
    var options = {
      // 'key': AppConstants.RazorPayLiveKeyId,
      'key': AppConstants.RazorPayTestKeyId,
      'amount': amount,
      // stockCheckOutResponse.data.orders.totalAmount.toInt(),
      'name': name.toString(),
      'order_id': order_id.toString(),
      'description': 'Payment',
      'prefill': {'contact': phone, 'email': email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);

    } catch (e) {
      debugPrint(e);
      print("------------" + e);
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
    // Fluttertoast.showToast(
    //     msg: "ERROR: " + response.code.toString() + " - " + response.message,
    //     timeInSecForIos: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo_home.png", fit: BoxFit.fill),
              Text('Cart', style: TextStyle(color: Colors.black, fontSize: 17)),
            ],
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => {Navigator.pop(context)},
          ),
        ),
        elevation: 4,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                  padding: EdgeInsets.only(left: 15, right: 15, top: 25),
                  height: MediaQuery.of(context).size.height * .55,
                  width: MediaQuery.of(context).size.width - 15,
                  // color: Colors.tealAccent,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: StreamBuilder<CardResponse>(
                          stream: _streamController.stream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData)
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              );
                            if (snapshot.data.data != null) {
                              oId = snapshot.data.data.cartItems[0].id;
                              totalAmount = snapshot.data.data.grandTotal;
                              orders = snapshot.data;
                              return Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.all(8),
                                    itemCount:
                                        snapshot.data.data.cartItems.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return buildCartItem(
                                          mealTitle: snapshot
                                              .data
                                              .data
                                              .cartItems[index]
                                              .catalog
                                              .mealName,
                                          mealDesc: "Qty:" +
                                              snapshot.data.data
                                                  .cartItems[index].quantity
                                                  .toString() +
                                              "," "Days:" +
                                              snapshot.data.data
                                                  .cartItems[index].days
                                                  .toString() +
                                              "," +
                                              "Time:" +
                                              snapshot
                                                  .data
                                                  .data
                                                  .cartItems[index]
                                                  .preferredDeliveryTime,
                                          mealAmount: snapshot.data.data
                                              .cartItems[index].catalog.price
                                              .toString(),
                                          itemId: snapshot
                                              .data.data.cartItems[index].id);
                                    },
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Packaging",
                                              style: TextStyle(fontSize: 17)),
                                          Text(
                                              snapshot.data.data.packingCharges
                                                  .toString(),
                                              style: TextStyle(fontSize: 17)),
                                        ],
                                      ),
                                      SizedBox(height: 7),
                                      Container(color: Colors.grey, height: .5),
                                      SizedBox(height: 7),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Item Total",
                                              style: TextStyle(fontSize: 17)),
                                          Text(
                                              snapshot.data.data.itemTotalForApp
                                                  .toString(),
                                              style: TextStyle(fontSize: 17)),
                                        ],
                                      ),
                                      SizedBox(height: 7),
                                      Container(color: Colors.grey, height: .5),
                                      // SizedBox(height: 5),
                                    ],
                                  ),
                                  buildOtherDetails(
                                      "Delivery",
                                      snapshot.data.data.deliveryCharges
                                          .toString(),
                                      snapshot.data.data.cartItems,
                                      snapshot.data.data.taxObj),
                                  buildOtherDetails(
                                      "Taxes",
                                      snapshot.data.data.taxes.toString(),
                                      snapshot.data.data.cartItems,
                                      snapshot.data.data.taxObj),
                                  Column(
                                    children: [
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Total",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              snapshot.data.data.grandTotal
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Container(color: Colors.grey, height: .5),
                                      SizedBox(height: 5),
                                    ],
                                  ),
                                ],
                              );
                            } else
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: ScreenUtils.customText(
                                      data: "No Detail Found",
                                      textAlign: TextAlign.center),
                                ),
                              );
                          })),
                ),
                Container(
                  // color: Colors.white,
                  color: Colors.grey[50],
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Text("ORDER SUMMARY",
                        style: TextStyle(fontSize: 25, color: Colors.black)),
                  ),
                ),
              ],
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    width: 180,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.red, width: 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      color: Colors.redAccent,
                      child: Text("Proceed to buy",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        submit();
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    width: 180,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.red, width: 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      color: Colors.white,
                      child: Text("Back to plans",
                          style: TextStyle(color: Colors.redAccent)),
                      onPressed: () {
                        // Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreenWithTabs()),
                            (route) => false);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  buildCartItem(
      {String mealTitle, String mealDesc, String mealAmount, int itemId}) {
    return Column(
      children: [
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mealTitle,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 4),
                Text(mealDesc,
                    style: TextStyle(color: Colors.grey, fontSize: 14))
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width / 4.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete_outline,
                        size: 30, color: Colors.grey),
                    onPressed: () {
                      deleteItem(itemId: itemId);
                    },
                  ),
                  Center(
                      child: Text(mealAmount, style: TextStyle(fontSize: 17)))
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(color: Colors.grey, height: .5),
      ],
    );
  }

  buildOtherDetails(
    String name,
    String amount,
    List<CartItems> cartItems,
    TaxObj taxObj,
  ) {
    return Column(
      children: [
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 18),
                        child: Text(name, style: TextStyle(fontSize: 17))),
                    Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 1))),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>

                              _buildPopupDialog(
                            context,
                            name,
                            amount,
                            cartItems,
                            taxObj,
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Text("i", style: TextStyle(fontSize: 12)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(amount, style: TextStyle(fontSize: 17)),
          ],
        ),
        SizedBox(height: 7),
        Container(color: Colors.grey, height: .5),
        SizedBox(height: 5),
      ],
    );
  }

  getCartItem() async {
    String token = await SharedPrefHelper().getWithDefault("token", "");
    var res = await NetworkUtil().get("user/cartItems", token: token);
    CardResponse cardResponse = CardResponse.fromJson(res);
    if (cardResponse.status == 200) {
      _streamController.sink.add(cardResponse);
    } else {
      _streamController.sink.add(cardResponse);
    }
  }

  deleteItem({int itemId}) async {
    String token = await SharedPrefHelper().getWithDefault("token", "");

    var res = await NetworkUtil().deleteApi(
      "user/cartItems/" + itemId.toString(),
      token: token,
    );
    BaseResponse baseResponse = BaseResponse.fromJson(res);
    if (baseResponse.status == 200) {
      _deleteController.sink.add(baseResponse);
      CommonUtils.showToast(
          msg: "Meal Successfully Deleted!", bgColor: null, textColor: null);
      setState(() {
        getCartItem();
      });
    } else {
      _deleteController.sink.add(baseResponse);
    }
  }

  Future<void> submit() async {
    CommonUtils.fullScreenProgress(context);
    String url = "user/create-order";
    CreateOrderOnRazorRequest request = CreateOrderOnRazorRequest(
      currency: "INR",
      payment_capture: "",
      receipt:
          // stockCheckOutResponse!=null? stockCheckOutResponse.data.orders.id.toString():

          oId.toString(),
      amount:
          // stockCheckOutResponse!=null?
          // (stockCheckOutResponse.data.orders.totalAmount*100).toInt():
         ( totalAmount*100).toInt(),
    );
    // print("create order razorpay request" + stockCheckOutResponse.data.orders.totalAmount.toString());
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
      print("create order razorpay response" +
          orderResponse.data.order.amount.toString());
      openCheckout(
        name!=null ? name.toString():" ",
       totalAmount,
        // stockCheckOutResponse.data.orders.totalAmount.toInt(),
        orderId.toString(),
        // email, phone
      );
    } else {
      // CommonUtils.errorMessage(msg: orderResponse.message);
      CommonUtils.dismissProgressDialog(context);
    }
  }

  Widget _buildPopupDialog(BuildContext context, String name, String amount,
      List<CartItems> cartItems, TaxObj taxObj) {
    return Dialog(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          name == "Delivery"
              ? Container(
                  height: 100,
                  // height: Get.height * 0.4,
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Text(
                            cartItems[index].catalog.mealName +
                                "-" +
                                cartItems[index]
                                    .catalog
                                    .deliveryCharges
                                    .toString(),
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                      );
                    },
                  ),
                )
              : Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Text(
                            "cGST25: " +
                                taxObj.cGST25.toString() +
                                "\n" +
                                "sGST25:" +
                                taxObj.sGST25.toString(),
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
