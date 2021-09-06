import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/ui/DrawerScreen.dart';
import 'package:flutter_sheplates/modals/promoCode.dart';

class ApplyPromoCodeScreen extends StatefulWidget {
  @override
  _ApplyPromoCodeScreenState createState() => _ApplyPromoCodeScreenState();
}

var size;

class _ApplyPromoCodeScreenState extends State<ApplyPromoCodeScreen> {
  List<PromoCode> promoCodes = [
    PromoCode("Get 60% Off for first Order", "SHI4l201"),
    PromoCode("Get 20% Off using Credit Card Get 20% Off using Credit Card", "SHI4l202"),
    PromoCode("Order 1 Meal Get 1 MealFree", "SHI4l203"),
    PromoCode("Get 10% Off using HDFC Card", "SHI4l204"),
    PromoCode("Get 60% Off for first order", "SHI4l205"),
    PromoCode("Get 60% Off for first order", "SHI4l206"),
    PromoCode("Get 60% Off for first order", "SHI4l207"),
  ];
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
            onPressed: () => {},
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Image.asset(
              "assets/info_icon.png",
              fit: BoxFit.fill,
            ),
          )
        ],
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
          child: Column(
            children: [
              promoCodeFieldAndButton(),
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
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: promoCodes.length,
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
                  codeDescription(index),
                  code(index),
                ],
              ),
              applyButton(),
            ],
          ),
        );
      },
    );
  }

  Widget applyButton() {
    return Text(
      "APPLY",
      style: TextStyle(
        color: Colors.red,
        fontSize: 17,
        fontWeight: FontWeight.w700,
        // shadows: <Shadow>[
        //   Shadow(
        //     offset: Offset(2, 3),
        //     blurRadius: 3,
        //     color: Colors.grey[300],
        //   ),
        // ],
      ),
    );
  }

  Widget codeDescription(int index) {
    return SizedBox(
      width: size.width * .65,
      child: Text(
        // fades when text is long
        promoCodes[index].description,
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

  Widget code(int index) {
    return Text(
      promoCodes[index].code,
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

  Widget promoCodeFieldAndButton() {
    return SizedBox(
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
              SizedBox(width: 270),
              Expanded(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: HexColor("#FF5657"),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                  ),
                  child: Center(child: Text("APPLY", style: TextStyle(color: Colors.white, fontSize: 18))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
