import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/ui/DrawerScreen.dart';

class ApplyPromoCodeScreen extends StatefulWidget {

  @override
  _ApplyPromoCodeScreenState createState() => _ApplyPromoCodeScreenState();
}

class _ApplyPromoCodeScreenState extends State<ApplyPromoCodeScreen> {

  @override
  initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _streamController?.close();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                  ))),
          leading: Builder(
            builder: (context) => IconButton(
                icon: Icon(Icons.arrow_back_rounded),
              onPressed: () => {},
            ),
          ),
          actions: [
            IconButton(onPressed: () =>{},
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
            child: SingleChildScrollView(
                child: Column(children: [

                ]))));

  }
}
