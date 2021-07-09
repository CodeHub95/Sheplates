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

var mainCategoryData;

class _CategoryScreenState extends State<CategoryScreen> {
  String category1, category2;
  int categoryOneID, categoryTwoID;
  getCategoryData() async {
    String url = "user/mainCategories";
    var deviceToken = await SharedPrefHelper().get("token");
    var res = await NetworkUtil().get(url, token: deviceToken, context: context);
    MainCategoryResponse response = MainCategoryResponse.fromJson(res);
    if (response.status == 200) {
      category1 = response.data[0].type;
      category2 = response.data[1].type;
      categoryOneID = response.data[0].id;
      categoryTwoID = response.data[1].id;
      mainCategoryData = res;
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
        body: mainCategoryData == null
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChooseCategoryMessage(),
                    SizedBox(height: MediaQuery.of(context).size.width * .3),
                    BuildButton(categoryName: category1, categoryID: categoryOneID),
                    SizedBox(height: MediaQuery.of(context).size.width * .1),
                    BuildButton(categoryName: category2, categoryID: categoryTwoID),
                    SizedBox(height: MediaQuery.of(context).size.width * .4),
                  ],
                ),
              ),
      ),
    );
  }
}

class BuildButton extends StatelessWidget {
  const BuildButton({Key key, @required this.categoryName, this.categoryID}) : super(key: key);

  final String categoryName;
  final int categoryID;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .66,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        elevation: 10,
        color: AppColor.themeButtonColor,
        textColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            categoryName == null ? "" : categoryName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.normal,
              fontFamily: 'CallingHeart',
            ),
          ),
        ),
        onPressed: () {
          categoryCode = 1;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreenWithTabs(categoryName: categoryName, categoryID: categoryID)));
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
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        Expanded(child: Container(color: Colors.grey, height: .5)),
        SizedBox(width: MediaQuery.of(context).size.width * .1),
      ],
    );
  }
}
