import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'HomeScreen.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Image.asset(
              "assets/logo_home.png",
              fit: BoxFit.fill,
              // color: Colors.transparent,
            ),
          ),
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * .66,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RaisedButton(
                  elevation: 10,
                  color: AppColor.themeButtonColor,
                  textColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      ('Health Niches'),
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => HomeScreen()),
                    //   (Route<dynamic> route) => false,
                    // );

                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
                SizedBox(height: 50),
                RaisedButton(
                  elevation: 10,
                  color: AppColor.themeButtonColor,
                  textColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      ('Sheplates Regular'),
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => HomeScreen()),
                    //   (Route<dynamic> route) => false,
                    // );

                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
