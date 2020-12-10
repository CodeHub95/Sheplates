import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/Routes.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/modals/request/SupportRequest.dart';
import 'package:flutter_sheplates/modals/response/BaseResponse.dart';
import 'package:flutter_sheplates/modals/response/FaqResponse.dart';
import 'package:flutter_sheplates/ui/DemoUi/DrawerScreen.dart';

class FaqScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<FaqScreen> {
  TextEditingController typeController = new TextEditingController();
  TextEditingController helpController = new TextEditingController();
  StreamController<List<Rows>> _controller = StreamController.broadcast();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controller?.close();
  }
  bool _pressAttention = true;
  bool _pressMapping = true;
  bool viewVisible = false;
  bool viewMapping = false;

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    getList();
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
                  padding: EdgeInsets.only(right: 30),
                  child: Text(
                    "FAQs",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                    textAlign: TextAlign.center,
                  ))),
          leading: Builder(
            builder: (context) => IconButton(
              icon: new Image.asset('assets/left_menu.png'),
              onPressed: () => Scaffold.of(context).openDrawer(),
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
            child: Column(children: [
          Container(
              child: StreamBuilder<List<Rows>>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      );
                    if (snapshot.data.length != 0) {
                            return Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 20)),
                                Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey[200],
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Text(
                                            // 'We are enterpreneurs who want to\n change the Skilled jobs Market ',
                                            snapshot.data[0].question
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
                                          )),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: IconButton(
                                                  icon: (_pressAttention
                                                      ? Icon(Icons.add,
                                                          color: Colors.grey)
                                                      : Icon(Icons.minimize,
                                                          color: Colors.grey)),
                                                  onPressed: _pressAttention
                                                      ? () {
                                                          setState(() {
                                                            if (_pressAttention) {
                                                              _pressAttention =
                                                                  false;
                                                            } else {
                                                              _pressAttention =
                                                                  true;
                                                            }
                                                          });

                                                          showWidget(
                                                              _pressAttention);
                                                        }
                                                      : () {
                                                          hideWidget(
                                                              _pressAttention);
                                                        }))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Visibility(
                                    visible: viewVisible,
                                    child: Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        // color: Colors.green,
                                        margin: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 10,
                                            right: 10),
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                                // 'Show Hide Text View Widget in Flutter',
                                                snapshot.data[0].answer
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15))))),
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey[200],
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.only(left: 10, right: 10),
                                          child: Text(
                                            // 'Mapping between the direction of \nthe icon and the',
                                            snapshot.data[1].question,
                                            style: TextStyle(color: Colors.black, fontSize: 15),
                                          )),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(left: 10, right: 10),
                                              child: IconButton(
                                                  icon: (_pressMapping
                                                      ? Icon(Icons.add, color: Colors.grey)
                                                      : Icon(Icons.minimize, color: Colors.grey)),
                                                  onPressed: _pressMapping
                                                      ? () {
                                                    setState(() {
                                                      if (_pressMapping) {
                                                        _pressMapping = false;
                                                      } else {
                                                        _pressMapping = true;
                                                      }
                                                    });

                                                    showMapping();
                                                  }
                                                      : () {
                                                    hideMapping();
                                                  }))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Visibility(
                                    visible: viewMapping,
                                    child: Container(
                                        height: 50,
                                        width: MediaQuery.of(context).size.width,
                                        // color: Colors.green,
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10, left: 10, right: 10),
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                                // 'Show Hide Text View Widget in Flutter',
                                                snapshot.data[1].answer,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black, fontSize: 15))))),
                              ],
                            );
                          // }
                    // );
                    } else {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: Text(" not available")),
                          ],
                        ),
                      );
                    }
                  }))
        ])));
  }

  void showWidget(index) {
    setState(() {
      viewVisible = true;
      _pressAttention = false;
    });
  }

  void hideWidget(index) {
    setState(() {
      viewVisible = false;
      _pressAttention = true;
    });
  }

  void showMapping() {
    setState(() {
      viewMapping = true;
      _pressMapping = false;
    });
  }

  void hideMapping() {
    setState(() {
      viewMapping = false;
      _pressMapping = true;
    });
  }

  getList() async {
    String token = await SharedPrefHelper().getWithDefault("token", "");
    var res = await NetworkUtil().get("admin/faq", token: token);
    FaqResponse faqResponse = FaqResponse.fromJson(res);
    if (faqResponse.status == 200) {

      _controller.sink.add(faqResponse.data.faq.rows);
    }
  }
}
