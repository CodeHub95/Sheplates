import 'package:flutter/material.dart';
import 'package:flutter_sheplates/modals/response/CheckOutResponse.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

class PaymentScreen extends StatefulWidget {
  final Orders orders;

  PaymentScreen({
    Key key,
    this.orders,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PaymentScreen> {
  num totalAmount;
  Razorpay _razorpay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_ImjhrLwWSMXD55',
      'amount': totalAmount ,
      'name': 'SHEPLATES',
      'description': 'Test Payment',
      'prefill': {'contact': '', 'email': ''},
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "SUCCESS: " + response.paymentId);
    String paymentId = response.paymentId.toString();
    String signature = response.signature.toString();
    String orderId = response.orderId.toString();

    print("paymentID: $paymentId");
    print("signature + $orderId");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "EXTERNAL WALLET: " + response.walletName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: LimitedBox(
                  maxWidth: 150,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "please enter some amount",
                    ),
                    onChanged: (value) {
                      setState(() {
                        totalAmount = num.parse(value);
                      });
                    },
                  ),
                )),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
                color: Colors.teal,
                child: Text(
                  "Make Payment",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  openCheckout();
                })
          ],
        ),
      ),
    );
  }
}
