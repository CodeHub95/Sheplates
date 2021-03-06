import 'dart:async';
import 'dart:convert';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/auth/api_config.dart';
import 'package:flutter_sheplates/modals/request/ApplyPromoCodeRequest.dart';
import 'package:flutter_sheplates/modals/response/ApplyPromoCodeResponse.dart';
import 'package:flutter_sheplates/modals/response/PromoCodeListResponse.dart';
import 'package:flutter_sheplates/ui/DrawerScreen.dart';
import 'package:flutter_sheplates/ui/NewFlow/CartScreen.dart';

class PromoCodeList extends StatefulWidget {
  @override
  _ApplyPromoCodeScreenState createState() => _ApplyPromoCodeScreenState();
}

var size;

class _ApplyPromoCodeScreenState extends State<PromoCodeList> {

  StreamController<List<Promocode>> _streamController = StreamController.broadcast();
  // TextEditingController codeController = TextEditingController();
  String firstHalf;
  String secondHalf;
  String thirdHalf;
  String fourthHalf;
  bool flag = true;

  @override
  void initState() {
    // TODO: implement initState
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
            padding: EdgeInsets.only(
              right: 20,
            ),
            child: Text(
              "Apply Promo Code",
              style: TextStyle(color: Colors.black, fontSize: 17),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () => {
              Navigator.pop(context)
            },
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () => {},
        //     icon: Image.asset(
        //       "assets/info_icon.png",
        //       fit: BoxFit.fill,
        //     ),
        //   )
        // ],
        bottom: PreferredSize(
            child: Container(
              color: Colors.grey,
              height: 1.0,
            ),
            preferredSize: Size.fromHeight(1.0)),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 10),
        child: SingleChildScrollView(
          child:

          Column(
            children: [
              // promoCodeFieldAndButton(),
              SizedBox(height: 20),
              applyPromoCodeText(),
              SizedBox(height: 5),
              buildPromoCodes()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPromoCodes() {
    return StreamBuilder<List<Promocode>>(
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
        return
          ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        if(snapshot.data[index].type != "REFERRAL") {
          return  Container(
              margin: EdgeInsets.fromLTRB(1, 1, 1, 1),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(blurRadius: 2,
                      color: Colors.grey[200],
                      offset: Offset(0, 2),
                      spreadRadius: 2.0),
                ],
                border: Border.all(color: Colors.grey[350], width: 1.5),
                borderRadius: BorderRadius.all(Radius.circular(10)),

              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(snapshot.data[index].name),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        code(snapshot.data[index].code),
                        applyButton(snapshot.data[index].code, snapshot
                            .data[index].offerUpTo, snapshot.data[index].name),
                      ],
                    ),

                    codeDescription(snapshot.data[index].description),
                  ])
          );
        }else return Container();
      },
    );}else{

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
                      data: "No Promo code is Available :)",
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          );
      }});
  }

  Widget applyButton(String code, int ReferralAmount, String name) {
    return GestureDetector(
      child: Text(
        "APPLY",
        style: TextStyle(
          color: Colors.red,
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
      ),
      onTap: (){
        applyCode(code, ReferralAmount, name);
      },
    );
  }

  Widget codeDescription(String description) {
    if (description.length > 60) {
      firstHalf = description.substring(0, 40);
       secondHalf = description.substring(40, 80);
      thirdHalf = description.substring(80, 120);
      fourthHalf = description.substring(120, description.length);
    } else {
      firstHalf = description;
      secondHalf = "";
    }
    return Row(
      children: [
        Container(
          padding: new EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
          child: secondHalf.isEmpty
              ? new Text(firstHalf)
              : new Column(
            children: <Widget>[
              new Text(flag ? (firstHalf + "...") : (firstHalf + "\n"+secondHalf + "\n" + thirdHalf + "\n" + fourthHalf)),
              new InkWell(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Text(
                      flag ? "show more" : "show less",
                      style: new TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    flag = !flag;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget code(String code) {
    return Text(
      code,
      style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
    );
  }

  Widget applyPromoCodeText() {
    return Row(
      children: [
        Text(
          "Apply Promo Code",
          style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

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
            msg: "Something went wrong!", bgColor: Colors.black, textColor: Colors.white);
      }
    }).catchError((error) {
      CommonUtils.dismissProgressDialog(context);
      CommonUtils.showToast(
          msg: "Something went wrong , Please try again", bgColor: Colors.red, textColor: Colors.white);
    });
  }

  Future<void> applyCode(String code, int ReferralAmount, String name)async {
    String token = await SharedPrefHelper().getWithDefault("token", "");
    print(token);

    var type = code.contains("FI", 0)? "FIRSTORDER" :  code.contains("FR", 0)? "FREEDELIVERY":" " ;
    if(type!= " "){
      ApplyPromoCodeRequest request = ApplyPromoCodeRequest(
        type: type,
        code: code,
      );
      CommonUtils.fullScreenProgress(context);

      NetworkUtil().post(url: ApiConfig.applyPromoCode, token: token, body: jsonEncode(request)).then((res) {

        ApplyPromoCodeResponse response = ApplyPromoCodeResponse.fromJson(res);

      // var res = await NetworkUtil().post(url: "user/applyPromoCode", body: jsonEncode(request), token: token);
      // ApplyPromoCodeResponse response = ApplyPromoCodeResponse.fromJson(res);
        if (response.status == 200) {
          CommonUtils.dismissProgressDialog(context);
          CommonUtils.showToast(msg: response.message, bgColor: Colors.black, textColor: Colors.white);
          // Navigator.pop(context);
          setState(() {
            ReferralAmount = ReferralAmount;
            name = "FIRST ORDER";
            code = code;
            type = type;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartScreen(ReferralAmount: ReferralAmount, name: name, code: code, codeType: type,)),
          );
        }
        else {
          CommonUtils.dismissProgressDialog(context);
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
