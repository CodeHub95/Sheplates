import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/modals/request/UserAddFeedbackRequest.dart';
import 'package:flutter_sheplates/modals/response/BaseResponse.dart';
import 'package:flutter_sheplates/modals/response/DeliveredMealResponse.dart';
import 'package:flutter_sheplates/modals/response/GetFeedbackResponse.dart';
import 'package:flutter_sheplates/ui/DrawerScreen.dart';
import 'package:flutter_sheplates/ui/HomeScreen.dart';

class FeedBack extends StatefulWidget {
  // DeliveredData data;
   int idd;
   String startDate;
   String endDate;
  // final int subscriptionID;
  FeedBack({this.idd,this.startDate, this.endDate}
      // {this.subscriptionID, }
      );
  @override
  _FeedBackState createState() => _FeedBackState(
    this.idd, this.startDate, this.endDate,
      // subscriptionID: this.subscriptionID
  );
}

class _FeedBackState extends State<FeedBack> {
  int idd; String startDate; String endDate;
  final int subscriptionID;
  _FeedBackState(  this.idd, this.startDate, this.endDate,{this.subscriptionID});
  final _formKey = GlobalKey<FormState>();
  TextEditingController startDateController = new TextEditingController();
  TextEditingController endDateController = new TextEditingController();

  StreamController _controller = StreamController.broadcast();

  DateTime selectStartDate = DateTime.now();
  DateTime selectEndDate = DateTime.now();
  double _tasterating;
  double _qualityrating;
  double _packagingrating;
  double _moneyrating;
  double _experiencerating;
  int id;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controller?.close();
  }

  Future<Null> _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context, initialDate: selectStartDate, firstDate: DateTime(1901, 1), lastDate: DateTime(2100));
    if (picked != null && picked != selectStartDate)
      setState(() {
        selectStartDate = picked;
        startDateController.value = TextEditingValue(text: picked.toString());
      });
  }

  Future<Null> _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context, initialDate: selectEndDate, firstDate: DateTime(1901, 1), lastDate: DateTime(2100));
    if (picked != null && picked != selectEndDate)
      setState(() {
        selectEndDate = picked;
        endDateController.value = TextEditingValue(text: picked.toString());
      });
  }

  bool _isVertical = false;
  IconData _selectedIcon;

  @override
  initState() {
    // TODO: implement initState
    _tasterating = 0;
    _experiencerating = 0;
    _moneyrating = 0;
    _packagingrating = 0;
    _qualityrating = 0;
    super.initState();
    getFeedBackDetails();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final color = Theme.of(context).accentColor;
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
              child: Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Text(
                    "Feedback",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    textAlign: TextAlign.center,
                  ))),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Image.asset(
                "assets/left_menu.png",
                fit: BoxFit.fill,
              ),
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Padding(
                padding: EdgeInsets.only(top: 30, left: 20),
                child: Row(
                  children: [
                    Text(
                      "Please let us know you thoughts on your\nsubscription",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Subscription Start Date",
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ],
                        )),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            enabled: false,
                            readOnly: true,
                            enableInteractiveSelection: true,
                            controller: startDateController,
                            // keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "29/09/1997",
                              suffixIcon: (IconButton(
                                onPressed: () {
                                  _selectStartDate(context);
                                },
                                icon: Icon(
                                  Icons.date_range,
                                ),
                              )),
                            ),
                            validator: (val) {
                              if (val.length < 10) return ('Please enter a valid Start Date');

                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Subscription End Date",
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ],
                        )),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            readOnly: true,
                            enabled: false,
                            enableInteractiveSelection: true,
                            controller: endDateController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "29/09/1997",
                              suffixIcon: (IconButton(
                                onPressed: () {
                                  _selectEndDate(context);
                                },
                                icon: Icon(
                                  Icons.date_range,
                                ),
                              )),
                            ),
                            validator: (val) {
                              if (val.length < 10) return ('Please enter a valid End Date');

                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Taste",
                                  style: TextStyle(fontSize: 17),
                                ),
                                _tasteRatingBar()
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Quality",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    _qualityRatingBar()
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Packaging",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    _packagingRatingBar()
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Value For Money",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    _moneyRatingBar()
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Delivery Experience",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    _experienceRatingBar()
                                  ],
                                )),
                          ],
                        ))
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                top: 30,
              )),
              Container(
                  padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                  height: 60,
                  width: 400,
                  child: RaisedButton(
                    color: HexColor("#FF5657"),
                    textColor: Colors.white,
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                     submit();
                    },
                  )),
            ])));
  }

  Future<void> submit() async {
    CommonUtils.fullScreenProgress(context);

    String token = await SharedPrefHelper().getWithDefault("token", "");

    String url = "user/add-feedback";
    UserFeedbackRequest request = UserFeedbackRequest(
      orderId: id.toInt(),
      taste: _tasterating.toInt(),
      quantity: _qualityrating.toInt(),
      packaging: _packagingrating.toInt(),
      valueOfMoney: _moneyrating.toInt(),
      deliveryExperience: _experiencerating.toInt(),
    );
    var res = await NetworkUtil().post(url: url, body: jsonEncode(request), token: token);
    BaseResponse response = BaseResponse.fromJson(res);
    if (response.status == 200) {
      CommonUtils.dismissProgressDialog(context);
      _showcontent();
    } else {
      CommonUtils.errorMessage(msg: response.message);
      CommonUtils.dismissProgressDialog(context);
    }
    // }
  }

  void _showcontent() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          contentPadding: EdgeInsets.all(0.0),
          content: new SingleChildScrollView(
            child: Container(
                height: 130,
                child: new Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 20.0,
                              color: Colors.black,
                            ),
                            onPressed: () => Navigator.pop(context)),
                      ],
                    ),
                    Text(
                      'Thank you for\n Feedback',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }

  Widget _tasteRatingBar() {
    return RatingBar.builder(
      initialRating: _tasterating,
      minRating: 1,
      direction: _isVertical ? Axis.vertical : Axis.horizontal,
      unratedColor: Colors.grey,
      itemCount: 5,
      itemSize: 25.0,
      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => Icon(
        _selectedIcon ?? Icons.star,
        color: Colors.yellow[600],
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _tasterating = rating;

          print(rating);
        });
        return _tasterating;
      },
      updateOnDrag: true,
    );
  }

  Widget _qualityRatingBar() {
    return RatingBar.builder(
      initialRating: _qualityrating,
      minRating: 1,
      direction: _isVertical ? Axis.vertical : Axis.horizontal,
      unratedColor: Colors.grey,
      itemCount: 5,
      itemSize: 25.0,
      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => Icon(
        _selectedIcon ?? Icons.star,
        color: Colors.yellow[600],
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _qualityrating = rating;
          print(rating);
        });
        return _qualityrating;
      },
      updateOnDrag: true,
    );
  }

  Widget _packagingRatingBar() {
    return RatingBar.builder(
      initialRating: _packagingrating,
      minRating: 1,
      direction: _isVertical ? Axis.vertical : Axis.horizontal,
      unratedColor: Colors.grey,
      itemCount: 5,
      itemSize: 25.0,
      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => Icon(
        _selectedIcon ?? Icons.star,
        color: Colors.yellow[600],
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _packagingrating = rating;
          print("_packagingrating: $rating");
        });
        return _packagingrating;
      },
      updateOnDrag: true,
    );
  }

  Widget _moneyRatingBar() {
    return RatingBar.builder(
      initialRating: _moneyrating,
      minRating: 1,
      direction: _isVertical ? Axis.vertical : Axis.horizontal,
      unratedColor: Colors.grey,
      itemCount: 5,
      itemSize: 25.0,
      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => Icon(
        _selectedIcon ?? Icons.star,
        color: Colors.yellow[600],
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _moneyrating = rating;
          print(rating);
        });
        return _moneyrating;
      },
      updateOnDrag: true,
    );
  }

  Widget _experienceRatingBar() {
    return RatingBar.builder(
      initialRating: _experiencerating,
      minRating: 1,
      direction: _isVertical ? Axis.vertical : Axis.horizontal,
      unratedColor: Colors.grey,
      itemCount: 5,
      itemSize: 25.0,
      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => Icon(
        _selectedIcon ?? Icons.star,
        color: Colors.yellow[600],
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _experiencerating = rating;
          print(rating);
        });
        return _experiencerating;
      },
      updateOnDrag: true,
    );
  }

  getFeedBackDetails() async {
    String token = await SharedPrefHelper().getWithDefault("token", "");
    var getFeedback = await NetworkUtil().get("user/feedback", token: token);
    GetFeedbackResponse feedbackResponse = GetFeedbackResponse.fromJson(getFeedback);
    _controller.sink.add(feedbackResponse);

    if (feedbackResponse.status == 200) {
      if (feedbackResponse.data.lastPlanFeedback != null) {
        if (feedbackResponse.data.lastPlanFeedback.startDate != null) {
          if (feedbackResponse.data.lastPlanFeedback.id == widget.idd) {
          id = widget.idd;
              // feedbackResponse.data.lastPlanFeedback.id.toInt();
          startDateController.text = feedbackResponse.data.lastPlanFeedback.startDate.toString();
          endDateController.text = feedbackResponse.data.lastPlanFeedback.endDate.toString();
          if (feedbackResponse.data.lastPlanFeedback.feedback != null) {
            id = feedbackResponse.data.lastPlanFeedback.id.toInt();
            _tasterating = feedbackResponse.data.lastPlanFeedback.feedback.taste.toDouble();
            _experiencerating = feedbackResponse.data.lastPlanFeedback.feedback.deliveryExperience.toDouble();
            _moneyrating = feedbackResponse.data.lastPlanFeedback.feedback.valueOfMoney.toDouble();
            _packagingrating = feedbackResponse.data.lastPlanFeedback.feedback.packaging.toDouble();
            _qualityrating = feedbackResponse.data.lastPlanFeedback.feedback.quantity.toDouble();
            startDateController.text = feedbackResponse.data.lastPlanFeedback.startDate.toString();
            endDateController.text = feedbackResponse.data.lastPlanFeedback.endDate.toString();
            print("ex: $_experiencerating");
            print("money: $_moneyrating");
            print("pack: $_packagingrating");
            print("quality: $_qualityrating");
            print("taste: $_tasterating");

            setState(() {
              _tasterating = feedbackResponse.data.lastPlanFeedback.feedback.taste.toDouble();
              _experiencerating = feedbackResponse.data.lastPlanFeedback.feedback.deliveryExperience.toDouble();
              _moneyrating = feedbackResponse.data.lastPlanFeedback.feedback.valueOfMoney.toDouble();
              _packagingrating = feedbackResponse.data.lastPlanFeedback.feedback.packaging.toDouble();
              _qualityrating = feedbackResponse.data.lastPlanFeedback.feedback.quantity.toDouble();
              startDateController.text = feedbackResponse.data.lastPlanFeedback.startDate.toString();
              endDateController.text = feedbackResponse.data.lastPlanFeedback.endDate.toString();
            });
          }
        } }else {
          CommonUtils.showToast(
              msg: "Do not have any active subscription Plan",
              bgColor: AppColor.darkThemeBlueColor,
              textColor: Colors.white);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      } else {
        CommonUtils.showToast(
            msg: "Do not have any active subscription Plan",
            bgColor: AppColor.darkThemeBlueColor,
            textColor: Colors.white);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } else {
      CommonUtils.errorMessage(
        msg: feedbackResponse.message,
      );
      CommonUtils.dismissProgressDialog(context);
    }
  }

  // void checkMealServed() async {
  //   String token = await SharedPrefHelper().getWithDefault("token", "");
  //   var getFeedback = await NetworkUtil().get("user/feedback", token: token);
  //   GetFeedbackResponse feedbackResponse = GetFeedbackResponse.fromJson(getFeedback);
  //   _controller.sink.add(feedbackResponse);
  //
  //   if (feedbackResponse.status == 200) {
  //     if (feedbackResponse.data.lastPlanFeedback.meals_served != 0) {
  //       submit();
  //     } else {
  //       return showDialog(
  //         context: context, barrierDismissible: false, // user must tap button!
  //
  //         builder: (BuildContext context) {
  //           return new AlertDialog(
  //             contentPadding: EdgeInsets.all(0.0),
  //             content: new SingleChildScrollView(
  //               child: Container(
  //                   height: 130,
  //                   child: new Column(
  //                     children: [
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.end,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           IconButton(
  //                               icon: Icon(
  //                                 Icons.close,
  //                                 size: 20.0,
  //                                 color: Colors.black,
  //                               ),
  //                               onPressed: () => Navigator.pop(context)),
  //                         ],
  //                       ),
  //                       Text(
  //                         'Meal has not been sent yet',
  //                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  //                         textAlign: TextAlign.center,
  //                       ),
  //                     ],
  //                   )),
  //             ),
  //           );
  //         },
  //       );
  //     }
  //   }
  // }
}
