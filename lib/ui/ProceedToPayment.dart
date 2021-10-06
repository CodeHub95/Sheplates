import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/modals/response/CardResponse.dart';
import 'package:flutter_sheplates/modals/response/CheckOutResponse.dart';
import 'package:flutter_sheplates/modals/response/CreateOrderOnRazorResponse.dart';
import 'package:flutter_sheplates/modals/response/StockCheckOutResponse.dart';
import 'package:flutter_sheplates/ui/EditProfile.dart';
import 'package:flutter_sheplates/ui/FaqScreen.dart';
import 'package:flutter_sheplates/ui/Feedback.dart';
import 'package:flutter_sheplates/ui/HomeScreen.dart';
import 'package:flutter_sheplates/ui/NewFlow/CategoryScreen.dart';
import 'package:flutter_sheplates/ui/Support.dart';

class ProceedToPayment extends StatefulWidget {
  // final CardResponse orders;
   Orders orders;
   ProceedToPayment({Key key, this.orders}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState(this.orders);
}

class _HomeScreenState extends State<ProceedToPayment> {
  Orders orders;
  _HomeScreenState(this.orders);

  @override
  initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      top: true,
      child: Scaffold(
          body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
            Padding(
                padding: EdgeInsets.only(
                  top: 80,
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Image.asset(
                    "assets/thanks_icon.png",
                    fit: BoxFit.fill,
                  ),
                )),
            Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Thanks for Subscribing",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text(
                          "to our services!",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ))
                  ],
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Your Subscription starts on",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    )
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  CommonUtils.getSimpleDate(
                      DateTime.parse(widget.orders.startDate)),
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  "See you then!",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                )),
            ScreenUtils.customButton(context, title: "Dashboard", onCLick: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryScreen(),
                  ),
                  (Route<dynamic> route) => false);
            }),
            Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Other Useful links",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                )),
            Padding(padding: EdgeInsets.only(top: 25)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(child:   Container(
                    height: 80,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/customer_care.png",
                              fit: BoxFit.fill,
                            ),
                            Text(
                              "Support",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
               ),
                    onTap: () => {
                      // null
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SupportScreen(),
                          ),
                              (Route<dynamic> route) => false)
                    }),


                GestureDetector(child:
                Container(
                    height: 80,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/profile_icon.png",
                              fit: BoxFit.fill,
                            ),
                            Text(
                              "Profile",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                    ),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(),
                          ),
                              (Route<dynamic> route) => false);
                    }
                  )

              ],
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
              child: Container(
                  height: 80,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/faq.png",
                            fit: BoxFit.fill,
                          ),
                          Text(
                            "FAQ's",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
             ),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FaqScreen(),
                          ),
                              (Route<dynamic> route) => false);
                    }
                ),

                GestureDetector(child: Container(
                    height: 80,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/feedback.png",
                              fit: BoxFit.fill,
                            ),
                            Text(
                              "Feedback",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                  ),       onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeedBack(idd: widget.orders.id, startDate: widget.orders.startDate, endDate: widget.orders.endDate),
                      ),
                          (Route<dynamic> route) => false
                  );
                })

              ],
            ),
          ]))),
    );
  }
}
