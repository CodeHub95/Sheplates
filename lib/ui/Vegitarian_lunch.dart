import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/modals/response/HomeListResponse.dart';
import 'package:flutter_sheplates/ui/ConfirmSubscription.dart';
import 'package:flutter_sheplates/ui/DrawerScreen.dart';

class VegitarianLunch extends StatefulWidget {
  final Rows rows;
  final bool suscriber;

  const VegitarianLunch({Key key, this.rows, this.suscriber}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<VegitarianLunch> {
  final _formKey = GlobalKey<FormState>();

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final color = Theme.of(context).accentColor;
    String mealName;
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
              child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    widget.rows.mealName,
                    style: TextStyle(color: Colors.black, fontSize: 17),
                    textAlign: TextAlign.center,
                  ))),
          leading: Builder(
            builder: (context) => IconButton(
              icon: new Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => {Navigator.pop(context)},
            ),
          ),
          bottom: PreferredSize(
              child: Container(
                color: Colors.grey,
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0)),
        ),
        body: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/bg_menu.png"))),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 30, right: 10, left: 10),
                              child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              "assets/menu_listing.png"))))),
                          Container(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                Padding(padding: EdgeInsets.only(top: 60)),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "QUALITY",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text(
                                              "A Taste of Home Made Food",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 10, right: 30, left: 30),
                                    child: Container(
                                        height: 10,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: AssetImage(
                                                    "assets/arrow_menu.png"))))),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 20, left: 30, right: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Monday:",
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.red),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Text(widget.rows.menu.monday,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white))),
                                        Padding(
                                          padding: EdgeInsets.only(top: 20),
                                          child: Text("Tuesday:",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.red)),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Text(
                                                widget.rows.menu.tuesday,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white))),
                                        Padding(
                                          padding: EdgeInsets.only(top: 20),
                                          child: Text("Wednesday:",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.red)),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Text(
                                                widget.rows.menu.wednesday,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white))),
                                        Padding(
                                          padding: EdgeInsets.only(top: 20),
                                          child: Text("Thursday:",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.red)),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Text(
                                                widget.rows.menu.thrusday,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white))),
                                        Padding(
                                          padding: EdgeInsets.only(top: 20),
                                          child: Text("Friday:",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.red)),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Text(widget.rows.menu.friday,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white))),
                                        Padding(
                                          padding: EdgeInsets.only(top: 20),
                                          child: Text("Saturday:",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.red)),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Text(
                                                widget.rows.menu.saturday,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white))),
                                      ],
                                    )),
                              ])),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                        top: 30,
                      )),
                      ScreenUtils.customButton(context, title: "Subscribe",
                          onCLick: () {
                        if (widget.suscriber) {
                          CommonUtils.showToast(
                              msg:
                                  "You have already one subscription plan running!",
                              bgColor: Colors.black,
                              textColor: Colors.white);
                        } else {
                          mealName = widget.rows.mealName;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ConfirmSubscription(widget.rows)),
                          );
                        }
                      }),
                    ]))));
  }
}
