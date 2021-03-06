import 'dart:async';
import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_sheplates/Utils/app_constants.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/auth/api_config.dart';
import 'package:flutter_sheplates/modals/request/ApplyPromoCodeRequest.dart';
import 'package:flutter_sheplates/modals/request/CreateOrderOnRazorRequest.dart';
import 'package:flutter_sheplates/modals/request/PaymentSubmitRequest.dart';
import 'package:flutter_sheplates/modals/response/ApplyPromoCodeResponse.dart';
import 'package:flutter_sheplates/modals/response/CreateOrderOnRazorResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/modals/request/ConfirmOrderRequest.dart';
import 'package:flutter_sheplates/modals/response/BaseResponse.dart';
import 'package:flutter_sheplates/modals/response/CardResponse.dart';
import 'package:flutter_sheplates/modals/response/CheckOutResponse.dart';
import 'package:flutter_sheplates/ui/NewFlow/CategoryScreen.dart';
import 'package:flutter_sheplates/ui/NewFlow/HomeScreenWithTabs.dart';
import 'package:flutter_sheplates/ui/NewFlow/PromoCodeList.dart';
import 'package:flutter_sheplates/ui/ProceedToPayment.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartScreen extends StatefulWidget {
  final CheckOutResponse stockCheckOutResponse;
  final ConfirmOrderRequestModel confirmOrderRequestModel;
 int ReferralAmount;
 String name;
 String code;
 String codeType;
String categoryname;
final String type;
int maincategoryId;
  num payedAmountAfterDiscount;
  CartScreen({Key key, this.stockCheckOutResponse, this.confirmOrderRequestModel, this.ReferralAmount, this.name, this.code, this.codeType, this.categoryname, this.type, this.maincategoryId}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState(this.stockCheckOutResponse, this.confirmOrderRequestModel, this.ReferralAmount, this.name, this.code, this.codeType, this.type, this.maincategoryId);
}

class _CartScreenState extends State<CartScreen> {
  final CheckOutResponse stockCheckOutResponse;
  final ConfirmOrderRequestModel confirmOrderRequestModel;
  int ReferralAmount;
  String name;
  String code;
  String codeType;
  String type;
int maincategoryId;
  StreamController<CardResponse> _streamController = StreamController.broadcast();
  StreamController<BaseResponse> _deleteController = StreamController.broadcast();
  TextEditingController codeController = TextEditingController();
  _CartScreenState(this.stockCheckOutResponse, this.confirmOrderRequestModel, this.ReferralAmount, this.name, this.code, this.codeType, this.type, this.maincategoryId);

  int oId;
  num totalAmount;
  bool cartRes = false;
  Razorpay _razorpay;

  CardResponse orders;
  num payedAmountAfterDiscount;
  String categoryN;
  String maincateId;
  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){
      getCartItem();
    }

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

  Future<void> completePayment(PaymentSuccessResponse paymentSuccessResponse) async {
    CommonUtils.fullScreenProgress(context);
    String url = "user/payment";
    print("++++++++++++++++++++++");
    print(ReferralAmount);
    if(ReferralAmount==null){
      setState(() {
        payedAmountAfterDiscount = 0;
      });

    }else {
      setState(() {
        payedAmountAfterDiscount = double.parse(totalAmount.toString()) - double.parse(ReferralAmount.toString());
      });

    }
 // num payedAmountAfterDiscount =ReferralAmount==null ?  totalAmount : (double.parse(totalAmount.toString()) - double.parse(ReferralAmount.toString()));
    PaymentSubmitRequest request = PaymentSubmitRequest(
        razorpay_payment_id: paymentSuccessResponse.paymentId,
        razorpay_order_id: paymentSuccessResponse.orderId,
        razorpay_signature: paymentSuccessResponse.signature,
        type: "Payment",
        status: "Success",
        paymentMode: "Razor Pay",
        orderId: oId.toString(),
        // stockCheckOutResponse.data.orders.id.toString(),
        amount: totalAmount,
        //-----------********************
        code: code,
        codeType: codeType,
        isCodeApply: code!=null? true: false,
        discountAmount: ReferralAmount!=null? ReferralAmount: 0,
        payedAmountAfterDiscount: payedAmountAfterDiscount,
        //-------------*****************
        // stockCheckOutResponse.data.orders.totalAmount,
        );
    String token = await SharedPrefHelper().getWithDefault("token", "");
    var res = await NetworkUtil().post(url: url, body: jsonEncode(request), token: token);
    CreateOrderOnRazorResponse response = CreateOrderOnRazorResponse.fromJson(res);
    print(response);
    if (response.status == 200) {
      CommonUtils.dismissProgressDialog(context);
      CommonUtils.showToast(msg: "Successfully Subscribed!", bgColor: Colors.red, textColor: Colors.white);
      // Navigator.of(context).pushNamed(Routes.proceedToPayment, (route) => false,
      //     arguments: {'order': stockCheckOutResponse.data.orders});
      // Navigator.popAndPushNamed(
      //   context,
      //     Routes.proceedToPayment,
      //     arguments: {'order': stockCheckOutResponse.data.orders}
      // );
      Navigator
          .of(context)
          .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
        return ProceedToPayment(orders: orders);
      }));
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
    // Fluttertoast.showToast(msg: "SUCCESS: " + paymentSuccessResponse.paymentId);

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
    Fluttertoast.showToast(msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
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
            onPressed: () => {
            // Navigator.pop(context, "Update")
              type!=null?
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreenWithTabs(categoryName: widget.categoryname, mainCategoryID:  widget.maincategoryId,)),
            )
                  :

              Navigator.pop(context, "Update")
            },
          ),
        ),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        // child: Center(
            child:
            Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: Stack(
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
                                      // totalAmount = snapshot.data.data.grandTotal.toInt();

                                      // totalAmount =
                                      // ReferralAmount!=null?
                                      // (snapshot.data.data.grandTotal.toInt() - ReferralAmount.toInt()):
                                      // snapshot.data.data.grandTotal
                                      //  ;
                                      if(ReferralAmount ==null){
                                        totalAmount = snapshot.data.data.grandTotal;
                                      }
                                        else if(ReferralAmount!=null && ReferralAmount < snapshot.data.data.deliveryCharges)
                                       {
                                       totalAmount = snapshot.data.data.grandTotal - ReferralAmount;
                                       }else if(ReferralAmount!=null && ReferralAmount > snapshot.data.data.deliveryCharges) {

                                        totalAmount = snapshot.data.data.grandTotal - snapshot.data.data.deliveryCharges;
                                      }
                                      orders = snapshot.data;
                                      return Column(
                                        children: [
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            padding: const EdgeInsets.all(8),
                                            itemCount: snapshot.data.data.cartItems.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return buildCartItem(
                                                  mealTitle: snapshot.data.data.cartItems[index].catalog.mealName,
                                                  mealDesc: "Qty:" +
                                                      snapshot.data.data.cartItems[index].quantity.toString() +
                                                      "," "Days:" +
                                                      snapshot.data.data.cartItems[index].days.toString() +
                                                      "," +
                                                      "Time:" +
                                                      snapshot.data.data.cartItems[index].preferredDeliveryTime,
                                                  mealAmount: snapshot.data.data.cartItems[index].catalog.price.toString(),
                                                  itemId: snapshot.data.data.cartItems[index].id);
                                            },
                                          ),
                                          Column(
                                            children: [
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Packaging", style: TextStyle(fontSize: 17)),
                                                  Text(snapshot.data.data.packingCharges.toString(),
                                                      style: TextStyle(fontSize: 17)),
                                                ],
                                              ),
                                              SizedBox(height: 7),
                                              Container(color: Colors.grey, height: .5),
                                              SizedBox(height: 7),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Item Total", style: TextStyle(fontSize: 17)),
                                                  Text(snapshot.data.data.itemTotalForApp.toString(),
                                                      style: TextStyle(fontSize: 17)),
                                                ],
                                              ),
                                              SizedBox(height: 7),
                                              Container(color: Colors.grey, height: .5),
                                              // SizedBox(height: 5),
                                            ],
                                          ),
                                          buildOtherDetails("Delivery", snapshot.data.data.deliveryCharges.toString(),
                                              snapshot.data.data.cartItems, snapshot.data.data.taxObj),
                                          Visibility(
                                            visible: ReferralAmount!=null && name!=null,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                Column(
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
                                                            Container(
                                                                width: 15,
                                                                height: 15,
                                                                decoration:
                                                                BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 1))),
                                                            InkWell(
                                                              onTap: () {
                                                                showDialog(
                                                                  context: context,
                                                                  builder: (BuildContext context) => _codePopupDialog(
                                                                    context,
                                                                    name,
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
                                                    Text("Promo Code", style: TextStyle(fontSize: 17)),
                                                  ],
                                                ),
                                                SizedBox(height: 7),
                                                Container(color: Colors.grey, height: .5),
                                                SizedBox(height: 5),
                                              ],
                                            ),
                                                    // Text("Promo Code", style: TextStyle(fontSize: 17, height: 1.3)),
                                                    Text(ReferralAmount.toString(), style: TextStyle(fontSize: 17)),
                                                  ],
                                                ),
                                                Divider(color: Colors.grey, thickness: .5),
                                              ],
                                            ),
                                          ),
                                          buildOtherDetails("Taxes", snapshot.data.data.taxes.toString(),
                                              snapshot.data.data.cartItems, snapshot.data.data.taxObj, ),
                                          Column(
                                            children: [
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Total", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                                  Text(snapshot.data.data.grandTotal.toString(),
                                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                                          child: ScreenUtils.customText(data: "No Detail Found", textAlign: TextAlign.center),
                                        ),
                                      );
                                  })),
                        ),
                        Container(
                          // color: Colors.white,
                          color: Colors.grey[50],
                          child: Padding(
                            padding: EdgeInsets.only(left: 25, right: 25),
                            child: Text("ORDER SUMMARY", style: TextStyle(fontSize: 25, color: Colors.black)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  cartRes?
                  Padding(
                    padding: const EdgeInsets.only(top:20.0, bottom: 10),
                    child: promoCodeFieldAndButton(),
                  ): Container(),
                  cartRes
                      ? Padding(
                        padding: const EdgeInsets.only(bottom:10.0),
                        child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                        Padding(
                          padding: const EdgeInsets.only(right:20.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PromoCodeList()));
                            },
                            child: Text(
                              "Select Promo Code",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 17,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                      ): Container(),
                  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: Container(
                      child: Column(
                        children: [
                          // oId !=null
                          cartRes
                              ?  SizedBox(
                            height: 40,
                            width: 180,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.red, width: 1),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              color: Colors.redAccent,
                              child: Text("Proceed to buy", style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                submit();
                              },
                            ),
                          ): Container(),
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
                              child: Text("Back to plans", style: TextStyle(color: Colors.redAccent)),
                              onPressed: () async {
                                String categor= await SharedPrefHelper().getWithDefault("categoryName", "");
                                String maincat= await SharedPrefHelper().getWithDefault("mainCategoryID", "");
                                setState(() {
                                   categoryN = categor;
                                   maincateId = maincat;
                                });


                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => CategoryScreen(),
                                //     )):
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomeScreenWithTabs(
                                    categoryName: widget.categoryname==null && widget.maincategoryId==null ? categoryN: widget.categoryname,
                                    mainCategoryID: widget.categoryname==null && widget.maincategoryId==null ? int.parse(maincateId): widget.maincategoryId,
                                  )),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
     
          // ),
      ),

    );
  }

  buildCartItem({String mealTitle, String mealDesc, String mealAmount, int itemId}) {
    return Column(
      children: [
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Container(
                    width: MediaQuery.of(context).size.width/2,
                  
                      child: Text(
                        mealTitle,
                        style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.normal),
                      ),

                ),
                SizedBox(height: 4),
                Text(mealDesc, style: TextStyle(color: Colors.grey, fontSize: 14))
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width / 4.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete_outline, size: 30, color: Colors.grey),
                    onPressed: () {
                      deleteItem(itemId: itemId);
                    },
                  ),
                  Center(child: Text(mealAmount, style: TextStyle(fontSize: 17)))
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
    TaxObj taxObj
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
                    Padding(padding: EdgeInsets.only(right: 18), child: Text(name, style: TextStyle(fontSize: 17))),
                    Container(
                        width: 15,
                        height: 15,
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 1))),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => _buildPopupDialog(
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
            Text(
                // amount
               (double.parse(amount).toStringAsFixed(2)).toString()
                , style: TextStyle(fontSize: 17)),
          ],
        ),
        SizedBox(height: 7),
        Container(color: Colors.grey, height: .5),
        SizedBox(height: 5),
      ],
    );
  }

  getCartItem() async {

    // categoryName: widget.categoryname, mainCategoryID:  widget.maincategoryId,

    String token = await SharedPrefHelper().getWithDefault("token", "");
    var res = await NetworkUtil().get("user/cartItems", token: token);
    CardResponse cardResponse = CardResponse.fromJson(res);
    if (cardResponse.status == 200) {
      String categ= await SharedPrefHelper().getWithDefault("categoryName", '');
      String maincat = await SharedPrefHelper().getWithDefault("mainCategoryID", '');
      print("cat" + categ);
      print("mai" + maincat);

      _streamController.sink.add(cardResponse);
      setState(() {
        // String itemno = await SharedPrefHelper().save("itemno", cardResponse.data.cartItems !=null? cardResponse.data.cartItems.toString(): null);
        cartRes = cardResponse.data.cartItems !=null?
        true : false;
        widget.categoryname = categ;
        widget.maincategoryId = int.parse(maincat);

      });

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
      CommonUtils.showToast(msg: "Meal Successfully Deleted!", bgColor: null, textColor: null);
      setState(() {
        getCartItem();
      });
    } else {
      _deleteController.sink.add(baseResponse);
    }
  }

  Future<void> submit() async {
    if(oId !=null){
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
          (totalAmount * 100).toInt(),
    );
    // print("create order razorpay request" + stockCheckOutResponse.data.orders.totalAmount.toString());
    String token = await SharedPrefHelper().getWithDefault("token", "");
    var res = await NetworkUtil().post(url: url, body: jsonEncode(request), token: token);
    CreateOrderOnRazorResponse orderResponse = CreateOrderOnRazorResponse.fromJson(res);
    if (orderResponse.status == 200) {
      CommonUtils.dismissProgressDialog(context);
      num amount = orderResponse.data.order.amount;
      String orderId = orderResponse.data.order.id;

      String name = await SharedPrefHelper().getWithDefault("name", "");
      String email = await SharedPrefHelper().getWithDefault("email", "");
      String phone = await SharedPrefHelper().getWithDefault("phone", "");
      print("create order razorpay response" + orderResponse.data.order.amount.toString());
      openCheckout(
        name != null ? name.toString() : " ",
        totalAmount.toInt(),
        // stockCheckOutResponse.data.orders.totalAmount.toInt(),
        orderId.toString(),
        // email, phone
      );
    } else {
      CommonUtils.errorMessage(msg: "Something Went Wrong!");
      CommonUtils.dismissProgressDialog(context);
    }
  }else{
      CommonUtils.errorMessage(msg: "No item is Available!");
    }}

  Widget _buildPopupDialog(BuildContext context, String name, String amount, List<CartItems> cartItems, TaxObj taxObj) {
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
                  height: 120,
                  // height: Get.height * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom:20.0),
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        // print("deliveryyyyy" + cartItems[1].catalog.deliveryCharges .toString());
                        return Center(
                          child: SingleChildScrollView(
                            scrollDirection:Axis.horizontal,
                            child: Container(
                              width: MediaQuery.of(context).size.width/1.5,
                              child: Text(
                                 cartItems[index].catalog.mealName + ": " + (cartItems[index].distance).toString()+ "kms",
                                  style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : Container(
                  height: 100,
                  child: ListView.builder(
                    // itemCount: cartItems.length,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Text("CGST@2.5%: " + (double.parse((taxObj.cGST25).toString()).toStringAsFixed(2)).toString()
                           + "\n" + "SGST@2.5%: " +
                            (double.parse((taxObj.sGST25).toString()).toStringAsFixed(2)).toString()
                            // taxObj.sGST25.toString()
                            ,
                            style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600)),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
  Widget _codePopupDialog(BuildContext context, String name) {
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
         Container(
            height: 100,
            // height: Get.height * 0.4,
            child:  Center(
                  child: Text(
                      "Code Name: " +
                     name,
                      style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600)),
            )
          )
        ],
      ),
    );
  }


  Widget promoCodeFieldAndButton() {
    return Padding(
      padding: const EdgeInsets.only(left:15.0, right: 15),
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              margin: EdgeInsets.only(right: 2),

              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(8),
                padding: EdgeInsets.zero,
                dashPattern: [7],
                color: HexColor("#FF5657"),
                strokeWidth: 2,
                child: Row(
                  children: [
                    Container(
                      width: 270,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextField(
                          controller: codeController,
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Promo Code",
                            hintStyle: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.normal, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Container(height: 58)),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width/1.5),
                Expanded(
                  child: Container(
                    // padding: EdgeInsets.only(left: 20, right: 20),
                    height: 60,
                    decoration: BoxDecoration(
                      color: HexColor("#FF5657"),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                    ),
                    child: Center(
                        child: FlatButton(
                          child: Text("APPLY", style: TextStyle(color: Colors.white, fontSize: 18)),
                          onPressed: (){
                            applyCode(codeController.text, ReferralAmount, name);
                          },
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

 Future<void> applyCode(String code, int ReferralAmount, String name)async {
    String token = await SharedPrefHelper().getWithDefault("token", "");
    print(token);

    var type = code.contains("RE", 0)? "REFERRAL" : code.contains("FO", 0)? "FIRSTORDER" :" ";
    if(type!= " "){
      ApplyPromoCodeRequest request = ApplyPromoCodeRequest(
        type: type,
        code: code,
      );
      CommonUtils.fullScreenProgress(context);

      NetworkUtil().post(url: ApiConfig.applyPromoCode, token: token, body: jsonEncode(request)).then((res) {
        CommonUtils.dismissProgressDialog(context);
        ApplyPromoCodeResponse response = ApplyPromoCodeResponse.fromJson(res);

        if (response.status == 200) {

          CommonUtils.showToast(msg: response.message, bgColor: Colors.black, textColor: Colors.white);
          // Navigator.pop(context);
          setState(() {
            ReferralAmount = 100;
            name = "REFERRAL CODE";
            code = code;
            type = type;
          });
        } else {
          CommonUtils.showToast(
              msg: response.message, bgColor: Colors.black, textColor: Colors.white);
        }
      }).catchError((error) {
        CommonUtils.dismissProgressDialog(context);
        CommonUtils.showToast(
            msg: "This code is not valid for your order", bgColor: Colors.red, textColor: Colors.white);
      });
    }else{
      CommonUtils.dismissProgressDialog(context);
      CommonUtils.showToast(
          msg: "Invalid Promo Code", bgColor: Colors.red, textColor: Colors.white);
    }

  }
}
