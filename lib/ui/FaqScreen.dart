import 'dart:async';
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/Routes.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/modals/response/FaqResponse.dart';
import 'package:flutter_sheplates/ui/DrawerScreen.dart';
import 'package:flutter_html/flutter_html.dart';


class FaqScreen extends StatefulWidget {
  final FaqResponse faqResponse = FaqResponse();

  // const FaqScreen({Key key, this.faqResponse}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState( this.faqResponse);
}

class _HomeScreenState extends State<FaqScreen> {
  TextEditingController typeController = new TextEditingController();
  TextEditingController helpController = new TextEditingController();
  StreamController<List<Rows>> _controller = StreamController.broadcast();
FaqResponse faqResponse =FaqResponse();

  _HomeScreenState(this.faqResponse);
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controller?.close();
  }

  // bool _pressAttention = true;
  // bool _pressMapping = true;
  // bool _presssMapping = true;
  // bool viewVisible = false;
  // bool viewMapping = false;
  // bool viewwMapping = false;
  bool _pressAttention = true;
  // bool _pressMapping ;
  // bool _presssMapping ;
  bool viewVisible = true;
  // bool viewMapping = true;
  // bool viewwMapping =false;
  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    getList();
    // faqResponse.data.faq.rows.forEach((element) {
    //   element.selected = false;
    // });
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
                    return  ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[200],
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10,top:10, bottom:10),
                                    child: Container(
                                      width:MediaQuery.of(context).size.width/1.4,

                                      child: Text(
                                        // 'We are enterpreneurs who want to\n change the Skilled jobs Market ',
                                        snapshot.data[index].question.toString(),

                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    )),
                                Spacer(

                                ),
                                IconButton(
                                    icon: (!snapshot.data[index].selected1
                                        ? Icon(Icons.add,
                                            color: Colors.grey)
                                        : Icon(Icons.minimize,
                                            color: Colors.grey)),
                                    onPressed: (){
                                      setState(() {
                                        snapshot.data.forEach((element) {
                                          // element.selected = false;
                                          // element.selected1 = false;

                                        });
                                        // snapshot.data[index].selected=!snapshot.data[index].selected;
                                        // .offersPlan.forEach((element) {
                                        //   element.selected = false;
                                        // });

                                        snapshot.data[index].selected = !snapshot.data[index].selected;
                                        snapshot.data[index].selected1 = !snapshot.data[index].selected1;
                                        // data.offersPlan[index].selected = true;
                                        // viewVisible = snapshot.data[index].selected;

print("selectedddd" + snapshot.data[index].selected1.toString() );
                                        // isRadiobutton =
                                        //     data.offersPlan[index].selected;
                                        // plan = data.offersPlan[index];
                                      });
                                    }
                                    // _pressAttention
                                    //     ? () {
                                    //         setState(() {
                                    //           if (_pressAttention) {
                                    //             _pressAttention= !_pressAttention;
                                    //
                                    //           }
                                    //           // else {
                                    //           //   _pressAttention = true;
                                    //           // }
                                    //         });
                                    //
                                    //         showWidget(index);
                                    //       }
                                    //     : () {
                                    //         hideWidget(index);
                                    //       }
                                          )
                              ],
                            ),
                          ),
                          Visibility(
                              visible: snapshot.data[index].selected,
                              child: Container(
                                  // height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Html(
                                          // 'Show Hide Text View Widget in Flutter',
                                         data: snapshot.data[index].answer.toString(),
                                          // defaultTextStyle: TextStyle(
                                          //       color: Colors.black,
                                          //       fontSize: 15
                                          // )
                                        // style( fontSize: 15)
                                          style: {
                                            // tables will have the below background color
                                            "p": Style(
                                            color: Colors.grey,
                                            alignment: Alignment.center,

                                            // fontSize: FontSize.medium
                                            //     fontSize: 15
                                          )
                                         }

                                  )
                                  ))),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          // Container(
                          //   height: 60,
                          //   width: MediaQuery.of(context).size.width,
                          //   color: Colors.grey[200],
                          //   child: Row(
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Padding(
                          //           padding: const EdgeInsets.only(
                          //               left: 10, right: 10),
                          //           child: Text(
                          //             // 'Mapping between the direction of \nthe icon and the',
                          //             snapshot.data[1].question,
                          //             style: TextStyle(
                          //                 color: Colors.black, fontSize: 15),
                          //           )),
                          //       Column(
                          //         crossAxisAlignment: CrossAxisAlignment.center,
                          //         children: [
                          //           Padding(
                          //               padding: const EdgeInsets.only(
                          //                   left: 10, right: 10),
                          //               child: IconButton(
                          //                   icon: (_pressMapping
                          //                       ? Icon(Icons.add,
                          //                           color: Colors.grey)
                          //                       : Icon(Icons.minimize,
                          //                           color: Colors.grey)),
                          //                   onPressed: _pressMapping
                          //                       ? () {
                          //                           setState(() {
                          //                             if (_pressMapping) {
                          //                               _pressMapping = false;
                          //                             } else {
                          //                               _pressMapping = true;
                          //                             }
                          //                           });
                          //
                          //                           showMapping();
                          //                         }
                          //                       : () {
                          //                           hideMapping();
                          //                         }))
                          //         ],
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // Visibility(
                          //     visible: viewMapping,
                          //     child: Container(
                          //         height: 50,
                          //         width: MediaQuery.of(context).size.width,
                          //         // color: Colors.green,
                          //         margin: EdgeInsets.only(
                          //             top: 10, bottom: 10, left: 10, right: 10),
                          //         child: Align(
                          //             alignment: Alignment.topLeft,
                          //             child: Text(
                          //                 // 'Show Hide Text View Widget in Flutter',
                          //                 snapshot.data[1].answer,
                          //                 textAlign: TextAlign.center,
                          //                 style: TextStyle(
                          //                     color: Colors.grey,
                          //                     fontSize: 15))))),
                          // Padding(padding: EdgeInsets.only(top: 10)),
                          // Container(
                          //   height: 60,
                          //   width: MediaQuery.of(context).size.width,
                          //   color: Colors.grey[200],
                          //   child: Row(
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Padding(
                          //           padding: const EdgeInsets.only(
                          //               left: 10, right: 10),
                          //           child: Text(
                          //             // 'Mapping between the direction of \nthe icon and the',
                          //             snapshot.data[2].question,
                          //             style: TextStyle(
                          //                 color: Colors.black, fontSize: 15),
                          //           )),
                          //       Column(
                          //         crossAxisAlignment: CrossAxisAlignment.center,
                          //         children: [
                          //           Padding(
                          //               padding: const EdgeInsets.only(
                          //                   left: 10, right: 10),
                          //               child: IconButton(
                          //                   icon: (_presssMapping
                          //                       ? Icon(Icons.add,
                          //                       color: Colors.grey)
                          //                       : Icon(Icons.minimize,
                          //                       color: Colors.grey)),
                          //                   onPressed: _presssMapping
                          //                       ? () {
                          //                     setState(() {
                          //                       if (_presssMapping) {
                          //                         _presssMapping = false;
                          //                       } else {
                          //                         _presssMapping = true;
                          //                       }
                          //                     });
                          //
                          //                     shMapping();
                          //                   }
                          //                       : () {
                          //                     hiMapping();
                          //                   }))
                          //         ],
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // Visibility(
                          //     visible: viewwMapping,
                          //     child: Container(
                          //         height: 50,
                          //         width: MediaQuery.of(context).size.width,
                          //         // color: Colors.green,
                          //         margin: EdgeInsets.only(
                          //             top: 10, bottom: 10, left: 10, right: 10),
                          //         child: Align(
                          //             alignment: Alignment.topLeft,
                          //             child: Text(
                          //               // 'Show Hide Text View Widget in Flutter',
                          //                 snapshot.data[2].answer,
                          //                 textAlign: TextAlign.center,
                          //                 style: TextStyle(
                          //                     color: Colors.grey,
                          //                     fontSize: 15))))),
                        ],
                      );});
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

  // void showWidget(index) {
  //   setState(() {
  //     viewVisible = true;
  //     _pressAttention = false;
  //   });
  // }
  //
  // void hideWidget(index) {
  //   setState(() {
  //     viewVisible = false;
  //     _pressAttention = true;
  //   });
  // }

  // void showMapping() {
  //   setState(() {
  //     viewMapping = true;
  //     _pressMapping = false;
  //   });
  // }
  //
  // void hideMapping() {
  //   setState(() {
  //     viewMapping = false;
  //     _pressMapping = true;
  //   });
  // }
  //
  // void shMapping() {
  //   setState(() {
  //     viewwMapping = true;
  //     _presssMapping = false;
  //   });
  // }
  //
  // void hiMapping() {
  //   setState(() {
  //     viewwMapping = false;
  //     _presssMapping = true;
  //   });
  // }

  getList() async {
    String token = await SharedPrefHelper().getWithDefault("token", "");
    var res = await NetworkUtil().get("admin/faq", token: token);
    FaqResponse faqResponse = FaqResponse.fromJson(res);
    if (faqResponse.status == 200) {
      _controller.sink.add(faqResponse.data.faq.rows);
    }
  }
}
