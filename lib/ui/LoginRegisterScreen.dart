import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/ui/LoginScreen.dart';
import 'package:flutter_sheplates/ui/RegisterScreen.dart';

class LoginRegisterScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginRegisterScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: SingleChildScrollView(child:
        Align(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[


              Padding(
                  padding: EdgeInsets.only(
                    top: 70,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.fill,
                      // color: Colors.transparent,
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                    top: 50,
                  )),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    Text("Healthy", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Padding(
                        padding: EdgeInsets.only(
                          top: 40,
                        )),
                    Text("Homemade Food", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  ],),

                  Column(children: [
                    Text("Hygienic", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                    ,
                    Padding(
                        padding: EdgeInsets.only(
                          top: 40,
                        )),
                    Text("Delivered", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                  ],)


                ],),
              Padding(
                  padding: EdgeInsets.only(
                    top: 50,
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/cooking_bottom.png"),
                        fit: BoxFit.cover)),
              ),
              Positioned(
                  bottom: 0,
                  child: Row(children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      color: AppColor.themeButtonColor,
                      child: Row(children: <Widget>[
                        Expanded(
                          child: FlatButton(
                            child: Text(
                              "LOGIN",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: double.maxFinite,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: FlatButton(
                            child: Text(
                              "REGISTER",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen(
                                    type: "register",
                                  )),
                            ),
                          ),
                        )
                      ]),
                    )
                  ]))
            ],
          ),
        ),   )


      ),
    );
  }
}
