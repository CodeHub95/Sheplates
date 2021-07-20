import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'Feedback.dart';

class PastWidgetTabData extends StatefulWidget {

  @override
  _PastWidgetTabDataState createState() => _PastWidgetTabDataState();
}

class _PastWidgetTabDataState extends State<PastWidgetTabData> {
 bool selected =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SingleChildScrollView(
      child:  Column(
          children: [

            Container(
              padding: EdgeInsets.only(left: 10, top: 10, right: 10),
              height: MediaQuery.of(context).size.height * .7,

              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Card(
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            // color: Colors.grey[200],
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10,top:10, bottom:10),
                                    child: Container(
                                      width:MediaQuery.of(context).size.width/1.5,

                                      child: Text(
                                        'Meal',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    )),
                                Spacer(

                                ),
                                IconButton(
                                    icon: (selected
                                        ? Icon(Icons.add,
                                        color: Colors.grey)
                                        : Icon(Icons.minimize,
                                        color: Colors.grey)),
                                    onPressed: (){

                                      setState(() {
                                        selected = !selected;
                                      });
                                    }

                                )
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                            visible: selected,
                            child: Container(
                              // height: 50,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 10, right: 10),
                                child: Container(
                                    child: Column(children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 30, right: 30, top: 30),
                                          child: Container(
                                            // height: 250,
                                            width: MediaQuery.of(context).size.width,
                                            child: DottedBorder(
                                              padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                              dashPattern: [5, 2],
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(padding: EdgeInsets.only(top: 10)),
                                                    Text(
                                                   'XYZ Kitchen',
                                                      style: TextStyle(color: Colors.red, fontSize: 20),
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets.only(
                                                          top: 10,
                                                        ),
                                                        child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text("Zone"+
                                                                  ", " +
                                                              'City'),
                                                            ])),
                                                    Padding(
                                                        padding: EdgeInsets.only(
                                                          top: 10,
                                                        ),
                                                        child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                             'fssaiNumber',
                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                              ),
                                                            ])),
                                                    Padding(
                                                        padding: EdgeInsets.only(
                                                          top: 10,
                                                        ),
                                                        child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text(

                                                             'razorpayOrderId'
                                                                ,
                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                              ),
                                                            ])),
                                                    Padding(padding: EdgeInsets.only(top: 10)),
                                                    Text(
                                                      "Meal Name",
                                                      style: TextStyle(fontSize: 25),
                                                    ),
                                                    Padding(padding: EdgeInsets.only(top: 10)),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "Expire on ",
                                                          style: TextStyle(fontSize: 15),
                                                        ),
                                                        Text('22/08/2021')
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                width: double.maxFinite,
                                                decoration: BoxDecoration(),
                                              ),
                                            ),
                                          )),
                                      Padding(padding: EdgeInsets.only(top: 30)),
                                      Container(
                                          height: 80,
                                          color: Colors.transparent,
                                          child: Row(children: [
                                            Padding(
                                                padding: const EdgeInsets.only(left: 20),
                                                child: Text(
                                                  'Duration: ',
                                                  style: TextStyle(color: Colors.grey, fontSize: 16),
                                                )),
                                            Text(
                                              "1 month",
                                              style: TextStyle(color: Colors.black, fontSize: 16),
                                            ),
                                          ])),
                                      Container(
                                          height: 50,
                                          color: Colors.grey[200],
                                          child: Row(
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.only(left: 20),
                                                  child: Text(
                                                    'Start Date: ',
                                                    style: TextStyle(color: Colors.grey, fontSize: 16),
                                                  )),
                                              Text(
                                                "1/08/2021",
                                                style: TextStyle(color: Colors.black, fontSize: 16),
                                              )
                                            ],
                                          )),
                                      Container(
                                          height: 80,
                                          color: Colors.transparent,
                                          child: Row(
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.only(left: 20),
                                                  child: Text(
                                                    'Amount Paid: ',
                                                    style: TextStyle(color: Colors.grey, fontSize: 16),
                                                  )),
                                              Text(
                                                "100",
                                                style: TextStyle(color: Colors.black, fontSize: 16),
                                              )
                                            ],
                                          )),
                                      Container(
                                          height: 50,
                                          color: Colors.grey[200],
                                          child: Row(
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.only(left: 20),
                                                  child: Text(
                                                    'Meals served: ',
                                                    style: TextStyle(color: Colors.grey, fontSize: 16),
                                                  )),
                                              Text(
                                                "5",
                                                style: TextStyle(color: Colors.black, fontSize: 16),
                                              )
                                            ],
                                          )),
                                      Container(
                                          height: 80,
                                          color: Colors.transparent,
                                          child: Row(
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.only(left: 20),
                                                  child: Text(
                                                    'Meals Remaining: ',
                                                    style: TextStyle(color: Colors.grey, fontSize: 16),
                                                  )),
                                              Text(
                                                "9",
                                                style: TextStyle(color: Colors.black, fontSize: 16),
                                              )
                                            ],
                                          ))
                                    ]))
                            )),
                        Padding(padding: EdgeInsets.only(top: 10)),

                      ],
                    );})
            ),
          ],
        )),
      );

  }
}

