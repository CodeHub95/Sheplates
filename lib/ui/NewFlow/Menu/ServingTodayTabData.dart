import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/modals/response/MenuResponse.dart';
import 'package:intl/intl.dart';

class ServingTodayTabData extends StatefulWidget {
  List<Obj> menuData;
  ServingTodayTabData(
      this.menuData);
  @override
  _ActiveWidgetTabDataCopyState createState() => _ActiveWidgetTabDataCopyState(this.menuData);
}

class _ActiveWidgetTabDataCopyState extends State<ServingTodayTabData> {
  List<Obj> menuData;
  _ActiveWidgetTabDataCopyState(this.menuData);
  bool isExpanded = false;

  @override
  void initState() {
    // TODO: implement initState
    if(menuData == null){
      setState(() {
        menuData = null;
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      menuData == null
      ||
      menuData.length == 0
          || menuData.isEmpty
          ? Center(child: Text("You don't have any subscription", style: TextStyle(color: Colors.black), ))
          :

      Padding(
        padding: EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: menuData.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ExpansionPanelList(

                  children: [
                    ExpansionPanel(
                      canTapOnHeader: true,

                      headerBuilder: (BuildContext context, bool isExpanded) => Center(
                        child: Row(
                          children: [

                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                menuData[index].mealName,
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                      body: Container(
                        // color: Colors.grey,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                AssetImage("assets/bg_menu.png"))),
                        width: MediaQuery.of(context).size.width,

                        child: Stack(children: [
                          Container(height: MediaQuery.of(context).size.height / 1.1,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                    AssetImage("assets/bg_menu.png"))),

                            width: MediaQuery.of(context).size.width,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10, top:20),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(fit: BoxFit.fill, image: AssetImage("assets/menu_listing.png"))),
                              child: Column(
                                children: [
                                  Padding(padding: EdgeInsets.only(top: 70)),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width/1.2,
                                            alignment: Alignment.center,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Text(
                                                // snapshot.data.data.obj.kitchen,

                                                menuData != null
                                                    ? menuData[index].kitchen
                                                    : '',
                                                // overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 20, color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(top: 10, right: 30, left: 30),
                                      child: Container(
                                          height: 10,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.fill, image: AssetImage("assets/arrow_menu.png"))))),
                                  Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width/1.2,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(left: 20.0),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Text(
                                                toBeginningOfSentenceCase(menuData[index].mealName.toString()),
                                                style: TextStyle(fontSize: 25, color: Colors.red),
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(top: 30, left: 20),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                      padding: const EdgeInsets.only(left: 0),
                                                      child: Text(
                                                        'Duration: ',
                                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                                      )),
                                                  Text(
                                                    toBeginningOfSentenceCase(menuData[index].duration.toString()),
                                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                                  )
                                                ],
                                              ),
                                              Padding(padding: EdgeInsets.only(top: 22)),
                                              Row(
                                                children: [
                                                  Padding(
                                                      padding: const EdgeInsets.only(left: 0),
                                                      child: Text(
                                                        'Start Date: ',
                                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                                      )),
                                                  Text(
                                                    menuData[index].startDate.toString(),
                                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                                  )
                                                ],
                                              ),
                                              Padding(padding: EdgeInsets.only(top: 22)),
                                              Row(
                                                children: [
                                                  Padding(
                                                      padding: const EdgeInsets.only(left: 0),
                                                      child: Text(
                                                        'Amount paid: ',
                                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                                      )),
                                                  Text(
                                                    menuData[index].amountPaid.toString(),
                                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                                  )
                                                ],
                                              ),
                                              Padding(padding: EdgeInsets.only(top: 22)),
                                              Row(
                                                children: [
                                                  Padding(
                                                      padding: const EdgeInsets.only(left: 0),
                                                      child: Text(
                                                        'Meals Served: ',
                                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                                      )),
                                                  Text(
                                                    menuData[index].mealsServed.toString(),
                                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                                  )
                                                ],
                                              ),
                                              Padding(padding: EdgeInsets.only(top: 22)),
                                              Row(
                                                children: [
                                                  Padding(
                                                      padding: const EdgeInsets.only(left: 0),
                                                      child: Text(
                                                        'Meals Remaining: ',
                                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                                      )),
                                                  Text(
                                                    menuData[index].mealsRemaining.toString(),
                                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                                  )
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                        left: 25,
                                        right: 25,
                                        top: 45,
                                      ),
                                      child: Container(
                                          height: 150,
                                          width: MediaQuery.of(context).size.width,
                                          child: DottedBorder(
                                              color: Colors.white,
                                              padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                                              dashPattern: [5, 2],
                                              child: Container(
                                                  child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Padding(padding: EdgeInsets.only(top: 10)),
                                                        Align(
                                                          child: Center(
                                                            child: Text(
                                                              "Serving Today",
                                                              style: TextStyle(color: Colors.red, fontSize: 23),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(padding: EdgeInsets.only(top: 20)),
                                                        Align(
                                                            alignment: Alignment.center,
                                                            child: Center(
                                                              child: Text(
                                                                menuData[index].servingToday.toString(),
                                                                style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors.white,
                                                                ),
                                                              ),
                                                            )),
                                                      ]))))),
                                  SizedBox(
                                    height: 80,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                      isExpanded: menuData[index].isExpanded==null? false:menuData[index].isExpanded ,
                    )
                  ],
                  expansionCallback: (int item, bool status) => setState(
                        () =>
                    menuData[index].isExpanded =   menuData[index].isExpanded==null? true: !menuData[index].isExpanded
                    // !menuData[index].isExpanded ,
                  )),
            );
          },
        ),
      ),
    );
  }
}
