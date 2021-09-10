import 'dart:async';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/auth/api_config.dart';
import 'package:flutter_sheplates/modals/response/PromoCodeListResponse.dart';
import 'package:flutter_sheplates/ui/DrawerScreen.dart';

class PromoCodeList extends StatefulWidget {
  @override
  _ApplyPromoCodeScreenState createState() => _ApplyPromoCodeScreenState();
}

var size;

class _ApplyPromoCodeScreenState extends State<PromoCodeList> {

  // List<PromoCode> promoCodes = [
  //   PromoCode("Get 60% Off for first Order", "SHI4l201"),
  //   PromoCode("Get 20% Off using Credit Card Get 20% Off using Credit Card", "SHI4l202"),
  //   PromoCode("Order 1 Meal Get 1 MealFree", "SHI4l203"),
  //   PromoCode("Get 10% Off using HDFC Card", "SHI4l204"),
  //   PromoCode("Get 60% Off for first order", "SHI4l205"),
  //   PromoCode("Get 60% Off for first order", "SHI4l206"),
  //   PromoCode("Get 60% Off for first order", "SHI4l207"),
  // ];
  StreamController<List<Promocode>> _streamController = StreamController.broadcast();
  // TextEditingController codeController = TextEditingController();
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
        return Container(
          height: 100,
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 11, horizontal: 3),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(blurRadius: 2, color: Colors.grey[200], offset: Offset(0, 2), spreadRadius: 2.0),
            ],
            border: Border.all(color: Colors.grey[350], width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  codeDescription(snapshot.data[index].description),
                  code(snapshot.data[index].code),
                ],
              ),
              applyButton(),
            ],
          ),
        );
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

  Widget applyButton() {
    return Text(
      "APPLY",
      style: TextStyle(
        color: Colors.red,
        fontSize: 17,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget codeDescription(String description) {
    return SizedBox(
      width: size.width * .65,
      child: Text(
        // fades when text is long
        description,
        overflow: TextOverflow.fade,
        maxLines: 1,
        softWrap: false,
        //
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
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

  // Widget promoCodeFieldAndButton() {
  //   return SizedBox(
  //     width: double.infinity,
  //     child: Stack(
  //       alignment: Alignment.centerRight,
  //       children: [
  //         Container(
  //           margin: EdgeInsets.only(right: 2),
  //           child: DottedBorder(
  //             borderType: BorderType.RRect,
  //             radius: Radius.circular(8),
  //             padding: EdgeInsets.zero,
  //             dashPattern: [7],
  //             color: HexColor("#FF5657"),
  //             strokeWidth: 2,
  //             child: Row(
  //               children: [
  //                 Container(
  //                   width: 270,
  //                   height: 58,
  //                   decoration: BoxDecoration(
  //                     color: Colors.transparent,
  //                     borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
  //                   ),
  //                   child: Padding(
  //                     padding: EdgeInsets.only(left: 10),
  //                     child: TextField(
  //                       controller: codeController,
  //                       style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
  //                       decoration: InputDecoration(
  //                         border: InputBorder.none,
  //                         hintText: "Enter Promo Code",
  //                         hintStyle: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.normal, fontSize: 16),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Expanded(child: Container(height: 58)),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Row(
  //           children: [
  //             SizedBox(width: 270),
  //             Expanded(
  //               child: Container(
  //                 height: 60,
  //                 decoration: BoxDecoration(
  //                   color: HexColor("#FF5657"),
  //                   borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
  //                 ),
  //                 child: Center(
  //                     child: FlatButton(
  //                         child: Text("APPLY", style: TextStyle(color: Colors.white, fontSize: 18)),
  //                       onPressed: (){
  //                         applyCode(codeController.text);
  //                       },
  //                     )),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

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

  // applyCode(String code)async {
  //   String token = await SharedPrefHelper().getWithDefault("token", "");
  //   print(token);
  //   var type = code.contains("RE", 0)? "REFERRAL" : code.contains("FO", 0)? "FIRSTRORDER" :" ";
  //   ApplyPromoCodeRequest request = ApplyPromoCodeRequest(
  //     type: type,
  //     code: code,
  //   );
  //   CommonUtils.fullScreenProgress(context);
  //   NetworkUtil().post(url: ApiConfig.applyPromoCode, token: token, body: jsonEncode(request)).then((res) {
  //     CommonUtils.dismissProgressDialog(context);
  //     ApplyPromoCodeResponse response = ApplyPromoCodeResponse.fromJson(res);
  //
  //     if (response.status == 200) {
  //
  //       CommonUtils.showToast(msg: response.message, bgColor: Colors.black, textColor: Colors.white);
  //       Navigator.pop(context);
  //       setState(() {
  //         ReferralAmount =100;
  //         name = "REFERRAL CODE";
  //       });
  //     } else {
  //       CommonUtils.showToast(
  //           msg: response.message, bgColor: Colors.black, textColor: Colors.white);
  //     }
  //   }).catchError((error) {
  //     CommonUtils.dismissProgressDialog(context);
  //     CommonUtils.showToast(
  //         msg: "Something went wrong , Please try again", bgColor: Colors.red, textColor: Colors.white);
  //   });
  // }
}
