import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/ui/DrawerScreen.dart';

class ReferralCodeScreen extends StatefulWidget {
  @override
  _ReferralCodeScreenState createState() => _ReferralCodeScreenState();
}

class _ReferralCodeScreenState extends State<ReferralCodeScreen> {
  String referralCode = "DOKG4GS86";
  var size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 20),
            child: title(),
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Image.asset("assets/left_menu.png", fit: BoxFit.fill),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        bottom: PreferredSize(child: Container(color: Colors.grey, height: 1.0), preferredSize: Size.fromHeight(1.0)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 40),
                logo(),
                SizedBox(height: 60),
                subTitle(),
                SizedBox(height: 25),
                referralCodeFieldAndButton(),
                SizedBox(height: 60),
                textField(),
                SizedBox(height: 60),
                inviteButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inviteButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: HexColor("#FF5657"),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Center(child: Text("Invite", style: TextStyle(color: Colors.white, fontSize: 18))),
      ),
    );
  }

  Widget textField() {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 17.5, color: Colors.black),
        children: [
          TextSpan(text: "Invite your friend to join "),
          TextSpan(
            text: "Sheplates App ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: "and get "),
          TextSpan(
            text: "RS 100 cashback ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: "for each friend that joins using your referral code. "),
          TextSpan(text: "\n\n"),
          TextSpan(text: "Your friends also get "),
          TextSpan(
            text: "RS 50 ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: "off on his first order "),
        ],
      ),
    );
  }

  Widget referralCodeFieldAndButton() {
    return SizedBox(
      width: 335,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            margin: EdgeInsets.only(right: 2),
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(30),
              padding: EdgeInsets.zero,
              dashPattern: [7],
              color: HexColor("#FF5657"),
              strokeWidth: 2,
              child: Row(
                children: [
                  Container(
                    width: 220,
                    height: 70,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                    ),
                    child: Center(
                      child: Text(
                        referralCode,
                        style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Expanded(child: Container(height: 70)),
                ],
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(width: 220),
              Expanded(
                child: Container(
                  height: 72,
                  decoration: BoxDecoration(
                    color: HexColor("#FF5657"),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
                  ),
                  child: InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: referralCode));
                        Fluttertoast.showToast(
                            msg: "Copied",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                      child: Center(child: Text("COPY", style: TextStyle(color: Colors.white, fontSize: 18)))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget subTitle() {
    return Text(
      "Refer Your Friends, Earn Cashback",
      style: TextStyle(color: Colors.black, fontSize: 20),
      textAlign: TextAlign.center,
    );
  }

  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Referral Code",
          style: TextStyle(color: Colors.black, fontSize: 17),
          textAlign: TextAlign.center,
        ),
        SizedBox(width: 25),
      ],
    );
  }

  Widget logo() => Image.asset('assets/2.0x/referral_code.png', height: size.width * .4);
}
