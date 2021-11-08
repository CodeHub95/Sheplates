import 'package:flutter/material.dart';

import 'hexColor.dart';

class ScreenUtils {
  static Widget customText(
      {@required String data,
      FontWeight fontWeight,
      double fontSize = 15.0,
      TextAlign textAlign: TextAlign.start,
      Color color = Colors.black}) {
    return Text(
      data,
      textAlign: textAlign,
      style: TextStyle(
          fontFamily: "Ubuntu",
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }

  Widget customTextField(
      @required TextEditingController controller,
      @required String hint,
      FontWeight fontWeight,
      @required String labelText,
      bool borderRequired) {
    return TextField(
      controller: controller,
      decoration: !borderRequired
          ? InputDecoration(
              hintText: hint,
              labelText: labelText,
              labelStyle: TextStyle(fontFamily: "Ubuntu", color: Colors.black),
              hintStyle: TextStyle(fontWeight: fontWeight),
              filled: true,
              fillColor: Colors.white,
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Color(00000000)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Color(00000000)),
              ),
            )
          : InputDecoration(
              hintText: hint,
              labelText: labelText,
              labelStyle: TextStyle(fontFamily: "Ubuntu", color: Colors.black),
              hintStyle:
                  TextStyle(fontFamily: "Ubuntu", fontWeight: fontWeight),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
    );
  }

  static Widget customButton(BuildContext context,
      {@required String title, @required Function onCLick}) {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        margin: EdgeInsets.only(top: 40, bottom: 0, right: 10, left: 25),
        height: 40,
        width: MediaQuery.of(context).size.width / 1.2,
        child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            color: AppColor.themeButtonColor,
            textColor: Colors.white,
            child: Text(
              (title),
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            onPressed: () {
              onCLick();
            }));
  }
}
