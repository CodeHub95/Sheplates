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
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChooseCategoryMessage(),
                    SizedBox(height: MediaQuery.of(context).size.width * .5),
                    BuildButton(category1: category1),
                    SizedBox(height: MediaQuery.of(context).size.width * .1),
                    BuildButton(category1: category2),
                  ],
                ),
              ),
      ),
    );
  }
}

class BuildButton extends StatelessWidget {
  const BuildButton({
    Key key,
    @required this.category1,
  }) : super(key: key);

  final String category1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .66,
      child: RaisedButton(
        elevation: 10,
        color: AppColor.themeButtonColor,
        textColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(category1, style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700)),
        ),
        onPressed: () {
          categoryCode = 1;
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreenWithTabs()));
        },
      ),
    );
  }
}

class ChooseCategoryMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * .1),
        Expanded(child: Container(color: Colors.grey, height: .5)),
        Text(
          " Choose a category ",
          style: TextStyle(fontSize: 19, color: Colors.grey, fontWeight: FontWeight.w700, letterSpacing: 2),
        ),
        Expanded(child: Container(color: Colors.grey, height: .5)),
        SizedBox(width: MediaQuery.of(context).size.width * .1),
      ],
    );
  }
}
