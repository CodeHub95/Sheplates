import 'dart:async';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/auth/api_config.dart';
import 'package:flutter_sheplates/modals/response/PromoCodeListResponse.dart';
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
  StreamController<List<Promocode>> _streamController =
      StreamController.broadcast();
  var size;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPromocodeList();
  }

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
        bottom: PreferredSize(
            child: Container(color: Colors.grey, height: 1.0),
            preferredSize: Size.fromHeight(1.0)),
      ),
      body: SingleChildScrollView(
          child: StreamBuilder<List<Promocode>>(
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
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        String code = snapshot.data[index].type == "REFERRAL"
                            ? snapshot.data[index].code
                            : "";
                        String description =
                            snapshot.data[index].type == "REFERRAL"
                                ? snapshot.data[index].description.toString()
                                : "";
                        String type = snapshot.data[index].type == "REFERRAL"
                            ? snapshot.data[index].type.toString()
                            : "";
                        int amount = (snapshot.data[index].type == "REFERRAL")
                            ? snapshot.data[index].offerUpTo
                            : 0;
                        String name = snapshot.data[index].type == "REFERRAL"
                            ? snapshot.data[index].name
                            : "";
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: snapshot.data[index].type == "REFERRAL"
                              ? Center(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 40),
                                      logo(),
                                      SizedBox(height: 60),
                                      subTitle(),
                                      SizedBox(height: 25),
                                      referralCodeFieldAndButton(
                                          code, description, type),
                                      SizedBox(height: 60),
                                      textField(amount),
                                      SizedBox(height: 60),
                                      inviteButton(code, description, type,
                                          amount, name),
                                    ],
                                  ),
                                )
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 30.0),
                                        child: ScreenUtils.customText(
                                            data:
                                                "No Referral code is Available :)",
                                            textAlign: TextAlign.center),
                                      ),
                                    ],
                                  ),
                                ),
                        );
                      });
                } else {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: ScreenUtils.customText(
                              data: "No Referral code is Available :)",
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  );
                }
              })),
    );
  }

  Widget inviteButton(
      String code, String description, String type, int amount, String name) {
    return InkWell(
      onTap: () {
        share(code, description, type, amount, name);
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: HexColor("#FF5657"),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Center(
            child: Text("Invite",
                style: TextStyle(color: Colors.white, fontSize: 18))),
      ),
    );
  }

  Widget textField(int amount) {
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
            text: "Rs" + amount.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
              text:
                  "cashback for each friend that joins using your referral code. "),
          TextSpan(text: "\n\n"),
          TextSpan(text: "Your friends also get "),
          TextSpan(
            text: "Rs" + amount.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: "off on his first order "),
        ],
      ),
    );
  }

  Widget referralCodeFieldAndButton(
      String code, String description, String type) {
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
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                    ),
                    child: Center(
                      child: Text(
                        code,
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w500),
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
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  ),
                  child: InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: code));
                        Fluttertoast.showToast(
                            msg: "Copied",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                      child: Center(
                          child: Text("COPY",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18)))),
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

  Widget logo() =>
      Image.asset('assets/2.0x/referral_code.png', height: size.width * .4);

  getPromocodeList() async {
    String token = await SharedPrefHelper().getWithDefault("token", "");
    print(token);
    CommonUtils.fullScreenProgress(context);
    var url = ApiConfig.promocode;
    NetworkUtil().get(url, token: token).then((res) {
      // CommonUtils.dismissProgressDialog(context);
      PromoCodeListResponse response = PromoCodeListResponse.fromJson(res);
      if (response.status == 200) {
        CommonUtils.dismissProgressDialog(context);
        _streamController.sink.add(response.data);
      } else {
        CommonUtils.dismissProgressDialog(context);
        CommonUtils.showToast(
            msg: "Something went wrong!",
            bgColor: Colors.black,
            textColor: Colors.white);
      }
    }).catchError((error) {
      CommonUtils.dismissProgressDialog(context);
      CommonUtils.showToast(
          msg: "Something went wrong , Please try again",
          bgColor: Colors.red,
          textColor: Colors.white);
    });
  }

  Future<void> share(String code, String description, String type, int amount,
      String name) async {
    await FlutterShare.share(
        title: code,
        text: "Code: " + code + "\n" + " \n" + description,
        chooserTitle: code);
  }
}