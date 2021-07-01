import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'HomeScreenWithTabs.dart';
import 'package:flutter_sheplates/Utils/global.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/modals/response/MainCategoriesResponse.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var categoryData;
  String category1, category2;
  getCategoryData() async {
    String url = "user/mainCategories";

    var deviceToken = await SharedPrefHelper().get("token");
    var res = await NetworkUtil().get(url, token: deviceToken, context: context);
    MainCategoryResponse response = MainCategoryResponse.fromJson(res);
    if (response.status == 200) {
      category1 = response.data[0].type;
      category2 = response.data[1].type;
      categoryData = res;
      setState(() {});
    } else {
      CommonUtils.errorMessage(msg: res.message);
    }
  }

  @override
  void initState() {
    getCategoryData();

    super.initState();
  }

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
        body: categoryData == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
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
                            // "button 1",
                            category1,
                            // "${categoryData["data"][0]["type"]}",
                            // categoryData.data[0].type.toString(),
                            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                          ),
                        ),
                        onPressed: () {
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => HomeScreen()),
                          //   (Route<dynamic> route) => false,
                          // );
                          categoryCode = 1;
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreenWithTabs()));
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreenWithTabs()));
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
                            // "button 2",
                            category2,
                            // "${categoryData["status"][1]["type"]}",
                            // categoryData.data[1].type.toString(),
                            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                          ),
                        ),
                        onPressed: () {
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => HomeScreen()),
                          //   (Route<dynamic> route) => false,
                          // );
                          categoryCode = 2;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreenWithTabs()));
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
