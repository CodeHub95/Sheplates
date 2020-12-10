import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';

import 'package:flutter_sheplates/Utils/hexColor.dart';
import 'package:flutter_sheplates/modals/response/BaseResponse.dart';
import 'package:flutter_sheplates/modals/response/EditProfileResponse.dart';
import 'package:flutter_sheplates/modals/response/GetProfileResponse.dart';
import 'package:flutter_sheplates/ui/DemoUi/ChangePassword.dart';
import 'package:flutter_sheplates/ui/DemoUi/DrawerScreen.dart';
import 'package:flutter_sheplates/ui/DemoUi/HomeScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class EditProfileScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<EditProfileScreen> {
  bool viewVisible = true;


  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();

  TextEditingController dobController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  DateTime selectedDate = DateTime.now();
  var items = ['Male', 'Female', 'other'];
  String dropdownValue = 'Male';
  File _image;
  final picker = ImagePicker();
  bool select;

  bool verify = true;
// bool verified = false;
  StreamController<GetProfileResponse> _controller = StreamController();
  List<GetProfileResponse> showAddress = List();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dobController.value = TextEditingValue(text: picked.toString());
      });
  }

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controller?.close();
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
                    "Edit Profile",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    textAlign: TextAlign.center,
                  ))),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Image.asset(
                "assets/left_menu.png",
                // color: Colors.transparent,
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
              children: [
                StreamBuilder<GetProfileResponse>(
                    stream: _controller.stream,
                    builder: (context, snapshot) {
                      print("build");
                      if (!snapshot.hasData)
                        return Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ));
                      return Center(
                          child: new Column(children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      Container(
                                        height: 120,
                                        width: 120,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: CircleAvatar(
                                          // radius: 60,
                                          // backgroundColor: Colors.black,
                                          child: snapshot.data.data.userExist
                                              .profileImage !=
                                              null
                                              ? Container(
                                              width: 120,
                                              height: 120,
                                              decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                image: new DecorationImage(
                                                  image: new NetworkImage(snapshot
                                                      .data
                                                      .data
                                                      .userExist
                                                      .profileImage),
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                          )
                                              : _image != null && !select
                                              ? InkWell(
                                            onTap: () {
                                              getImage();
                                            },
                                            child: Container(
                                                width: 120,
                                                height: 120,
                                                decoration: new BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                    image:
                                                    new DecorationImage(
                                                      image: new FileImage(
                                                          _image),
                                                      fit: BoxFit.cover,
                                                    ))),
                                          )
                                              : InkWell(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey[200],
                                                ),
                                                width: 120,
                                                height: 120,
                                              )),
                                        ),
                                      ),
                                      Positioned(
                                        // bottom: -20,
                                        // right: -20,
                                          child: Stack(
                                            children: [
                                              Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors
                                                        .red, //remove this when you add image.
                                                  ),
                                                  child: InkWell(
                                                    child: IconButton(
                                                        icon: Icon(
                                                          Icons.edit,
                                                          color: Colors.white,
                                                        ),
                                                        onPressed: () => {
                                                          getImage()
                                                          // _showPicker(context)
                                                        }),
                                                  ))
                                            ],
                                          ))
                                    ],
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                        top: 20,
                                      ),
                                      child: GestureDetector(
                                          child: Text(
                                            ("Change Password"),
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                          onTap: () => {
                                            Navigator.push(
                                                context, MaterialPageRoute(builder: (context) => ChangePasswordScreen(phoneNumber: numberController.text,)))
                                          })),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                                    child: Form(
                                        key: _formKey,
                                        child: Column(children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),

                                            child: TextFormField(
                                              controller: nameController,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: "John"),
                                              validator: (val) {
                                                if (val.isEmpty) {
                                                  return ("Please Enter Name");
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onSaved: (val) => {
                                                nameController.text = val,
                                                print("on saved name " +
                                                    val +
                                                    " >> " +
                                                    nameController.text),
                                                // name= val
                                              },
                                              // onFieldSubmitted: (val)=> FocusScope.of(context).requestFocus(f1),
                                            ),
                                            // )
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 20, top: 20),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),

                                            child: TextFormField(
                                              controller: lastnameController,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: "Deo"),
                                              validator: (val) {
                                                if (val.isEmpty) {
                                                  return ("Please Enter Last Name");
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onSaved: (val) => {
                                                lastnameController.text = val,
                                                print("on saved name " +
                                                    val +
                                                    " >> " +
                                                    lastnameController.text),
                                                // name= val
                                              },
                                              // onFieldSubmitted: (val)=> FocusScope.of(context).requestFocus(f1),
                                            ),
                                            // )
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                                            child: TextFormField(
                                              readOnly: true,
                                              controller: genderController,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
//                                              labelText: ('Male'),
                                                hintText: ('Male'),
                                                suffixIcon: PopupMenuButton<String>(
                                                  icon: Image.asset(
                                                    "assets/dropdown_icon.png",
                                                    fit: BoxFit.fill,
                                                  ),
                                                  onSelected: (String value) {
                                                    genderController.text = value;
                                                  },
                                                  itemBuilder: (BuildContext context) {
                                                    return items
                                                        .map<PopupMenuItem<String>>(
                                                            (String value) {
                                                          return new PopupMenuItem(
                                                              child: new Text(value),
                                                              value: value);
                                                        }).toList();
                                                  },
                                                ),
                                              ),
                                              onSaved: (val) => {
                                                genderController.text = val,
                                                print("on saved name " +
                                                    val +
                                                    " >> " +
                                                    genderController.text),
                                                // gender =   genderController.text
                                              },
                                              validator: (val) {
                                                if (val.isEmpty) {
                                                  return ("Please Select Gender");
                                                } else {
                                                  return null;
                                                }
                                              },
                                              // onFieldSubmitted: (val)=> FocusScope.of(context).requestFocus(f5),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),

                                            child: TextFormField(
                                              controller: dobController,
                                              keyboardType: TextInputType.datetime,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: "29/09/1997",
                                                suffixIcon: (IconButton(
                                                  onPressed: () {
                                                    _selectDate(context);
                                                  },
                                                  icon: Image.asset(
                                                    "assets/calendar_icon.png",
                                                  ),
                                                )),
                                              ),
                                              validator: (val) {
                                                if (val.length < 10)
                                                  return ('Please enter a valid DOB');

                                                return null;
                                              },
                                              onSaved: (val) => {
                                                dobController.text = val,
                                                print("on saved name " +
                                                    val +
                                                    " >> " +
                                                    dobController.text),
                                              },
                                            ),
                                            // )
                                          ),
                                          Padding(
                                              padding:
                                              EdgeInsets.fromLTRB(20, 30, 20, 0),
                                              child: TextFormField(
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: "john@gmail.con"),
                                                controller: emailController,
                                                validator: (val) => !val.contains('@')
                                                    ? "Enter a valid Email"
                                                    : null,
                                                onSaved: (val) => {
                                                  emailController.text = val,
                                                  print("on saved name " +
                                                      val +
                                                      " >> " +
                                                      emailController.text),
                                                  // email = emailController.text
                                                },
                                              )
                                            // ),
                                          ),

                                          Padding(
                                              padding: EdgeInsets.only(right: 20),
                                              child:  Align(
                                                  alignment: Alignment.bottomRight,
                                                  child: GestureDetector (
                                                      onTap :  ()
                                                      {
                                                        verifyMail();


                                                        // setState(() => verified = !verified);
                                                      },
                                                     //  child: !verify? Text(
                                                     //    "verify",
                                                     //    style: TextStyle(color: Colors.red),
                                                     //  ):
                                                     // Text(
                                                     //      "verifed",
                                                     //      style: TextStyle(color: Colors.black),
                                                     //    ),
                                                    child:
                                                      !verify ? Text('verify', style: TextStyle(color: Colors.red),
                                                      ): Text('verified',style: TextStyle(color: Colors.black), ),
                                                    //   style: TextStyle(
                                                    //     // fontSize: 20,
                                                    //       color: Colors.black
                                                    //   ),
                                                    //
                                                    // ),

                                                  )
                                              )
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                            child: TextFormField(
                                              controller: numberController,
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                hintText: "+917070707070",
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Align(
                                                alignment: Alignment.bottomRight,
                                                child: GestureDetector(
                                                    onTap: (){

                                                    },   // this line is not working
                                                    child: Text(
                                                      "verified",
                                                      style: TextStyle(color: Colors.black),
                                                    ))),
                                          ),
                                          Padding(
                                              padding:
                                              EdgeInsets.fromLTRB(20, 20, 20, 0),
                                              child: TextFormField(
                                                maxLines: 3,
                                                readOnly: true,
                                                keyboardType: TextInputType.multiline,
                                                controller: locationController,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText:
                                                    "A20, Lucknow, Uttar Pradesh"),
                                                validator: (val) {
                                                  if (val.isEmpty) return ('Empty');
                                                  return null;
                                                },
                                                onSaved: (val) => {
                                                  locationController.text = val,
                                                  print("on saved name " +
                                                      val +
                                                      " >> " +
                                                      locationController.text),
                                                  // password =   passwordController.text
                                                },
                                              )
                                            // ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(top: 30),
                                          ),
                                          Container(
                                              padding:
                                              EdgeInsets.fromLTRB(20, 10, 20, 10),
                                              height: 70,
                                              width: 500,
                                              child: RaisedButton(
                                                color: HexColor("#FF5657"),
                                                textColor: Colors.white,
                                                child: Text(
                                                  'Edit',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  submit();
                                                },
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                bottom: 20,
                                              )),
                                        ])),
                                  )
                                ]),
                          ]));
                    })
              ],
            )));
  }

  submit() async {
    final form = _formKey.currentState;
    form.save();
    if (form.validate()) {
      CommonUtils.fullScreenProgress(context);
      editProfile();

    }
  }


  getProfile() async {
    String email = await SharedPrefHelper().getWithDefault("email", null);
    String token = await SharedPrefHelper().getWithDefault("token", null);

    var res = await NetworkUtil().get("user/profile", token: token);
    GetProfileResponse getProfileResponse = GetProfileResponse.fromJson(res);

    if (getProfileResponse.status == 200) {


      numberController.text = getProfileResponse.data.userExist.phone != null
          ? getProfileResponse.data.userExist.phone.toString()
          : "";
      nameController.text = getProfileResponse.data.userExist.firstName != null
          ? getProfileResponse.data.userExist.firstName
          : "";
      lastnameController.text =
      getProfileResponse.data.userExist.lastName != null
          ? getProfileResponse.data.userExist.lastName
          : "";
      dobController.text = getProfileResponse.data.userExist.dob != null
          ? getProfileResponse.data.userExist.dob
          : "";
      genderController.text = getProfileResponse.data.userExist.gender != null
          ? getProfileResponse.data.userExist.gender.toString()
          : "";
      locationController.text = getProfileResponse.data.userExist.userAddresses[0].fullAddress !=null?
      getProfileResponse.data.userExist.userAddresses[0].fullAddress: "";

      emailController.text = getProfileResponse.data.userExist.email != null
          ? getProfileResponse.data.userExist.email.toString()
          : "";
      select = getProfileResponse.data.userExist.profileImage != null
          ? true
          : false;
      _controller.sink.add(getProfileResponse);

    }
  }

  getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print("work");
      select = false;
      _image = File(pickedFile.path);
      setState(() {
        _image = _image;
      });
    }
  }

  verifyMail()async
  {
    CommonUtils.fullScreenProgress(context);
    String token = await SharedPrefHelper().getWithDefault("token", null);
    String url = "user/email-verification";
    var res = await NetworkUtil()
        .post(url: url,  token: token);
    BaseResponse baseResponse =BaseResponse.fromJson(res);
    if (baseResponse.status == 200) {
      CommonUtils.dismissProgressDialog(context);
      CommonUtils.showToast(msg: baseResponse.message);
      setState(() => verify = !verify);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
      // Navigator.pop(context);

    } else {
      CommonUtils.dismissProgressDialog(context);
      CommonUtils.showToast(msg: baseResponse.message);
    }


  }

  editProfile() async {
    FormData formData = FormData.fromMap({
      "first_name": nameController.text,
      "last_name": lastnameController.text,
      "phone": numberController.text,
      "email": emailController.text,
      "dob": dobController.text,
      "gender": genderController.text,
      "full_address": locationController.text,
    });
    List<MapEntry<String, MultipartFile>> listImages = List();
    if (_image != null) {
      listImages.add(MapEntry(
        "image",
        await MultipartFile.fromFile(_image.path,
            filename: path.basename(_image.path)),
      ));
    }
    // if (listImages.length != 0) {

      formData.files.addAll(listImages);
      CommonUtils.fullScreenProgress(context);
      String token = await SharedPrefHelper().getWithDefault("token", null);
      String url = "user/edit-profile";
      var res = await NetworkUtil()
          .putApi(url: url, body: formData, isFormData: true, token: token);

      EditProfileResponse response = EditProfileResponse.fromJson(res);

      if (response.status == 200) {
        CommonUtils.dismissProgressDialog(context);
        CommonUtils.showToast(msg: response.message);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        CommonUtils.dismissProgressDialog(context);
        CommonUtils.showToast(msg: response.message);
      }
    // }

  }
}
