import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_sheplates/Utils/ScreenUtils.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/modals/request/AddDeliveryAddressRequest.dart';
import 'package:geocoder/geocoder.dart';

class EditAddressScreen extends StatefulWidget {
  final Address address;

  const EditAddressScreen({Key key, this.address}) : super(key: key);

  @override
  _EditAddressScreenState createState() =>
      _EditAddressScreenState(this.address);
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final Address address;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  TextEditingController _areaTextEditingController;
  TextEditingController _houseNoTextEditingController;
  TextEditingController _streetTextEditingController;
  TextEditingController _pinCodeTextEditingController;
  TextEditingController _landmarkTextEditingController;
  TextEditingController _placeNameTextEditingController;

  StreamController<AddressTypeModal> _streamAddressType =
      StreamController.broadcast();

  AddressTypeModal defaultType;

  _EditAddressScreenState(this.address);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _areaTextEditingController = TextEditingController();
    _houseNoTextEditingController = TextEditingController();
    _streetTextEditingController = TextEditingController();
    _pinCodeTextEditingController = TextEditingController();
    _landmarkTextEditingController = TextEditingController();
    _placeNameTextEditingController = TextEditingController();

    // By Default apartment Address Type Choose
    defaultType = CommonUtils.getAllAddressType()[0];
    if (address != null) {
      _areaTextEditingController.text = address.addressLine;
      _houseNoTextEditingController.text = address.featureName;
      _pinCodeTextEditingController.text = address.postalCode;
      _landmarkTextEditingController.text = address.subLocality;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamAddressType?.close();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Container(
      alignment: Alignment.topCenter,
      color: Colors.white,
      height: MediaQuery.of(context).size.height /1.8,
      padding: EdgeInsets.only(
        left: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: FormBuilder(
              key: _fbKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: inputWidget(
                              attribute: 'area',
                              maxLine: 3,
                              validators: [FormBuilderValidators.required()],
                              textInputType: TextInputType.multiline,
                              textEditingController: _areaTextEditingController,
                              hint: "Select Area *"),
                        ),
                      ],
                    ),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Flexible(
                        child: inputWidget(
                            attribute: 'house_no',
                            validators: [],
                            textEditingController:
                                _houseNoTextEditingController,
                            hint: "House No.",
                            textInputType: TextInputType.text),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      new Flexible(
                        child: inputWidget(
                            attribute: 'street_no',
                            validators: [],
                            textEditingController: _streetTextEditingController,
                            hint: "Street No.",
                            textInputType: TextInputType.text),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      new Flexible(
                        child: inputWidget(
                            attribute: 'pin_code',
                            validators: [],
                            textEditingController:
                                _pinCodeTextEditingController,
                            hint: "PinCode",
                            textInputType: TextInputType.text),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: inputWidget(
                              attribute: 'landmark',
                              validators: [],
                              textEditingController:
                                  _landmarkTextEditingController,
                              hint: "Landmark",
                              textInputType: TextInputType.text),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: FormBuilderDropdown(
                            attribute: "address_type",
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            hint: Text(
                              "Address Type *",
                              style: TextStyle(fontSize: 14),
                            ),
                            onChanged: (value) {
                              defaultType = value;
                              _streamAddressType.sink.add(defaultType);
                            },
                            validators: [FormBuilderValidators.required()],
                            items: CommonUtils.getAllAddressType()
                                .map((type) => DropdownMenuItem(
                                      child: ScreenUtils.customText(
                                          data: type.title),
                                      value: type,
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: StreamBuilder<AddressTypeModal>(
                              stream: _streamAddressType.stream,
                              initialData: defaultType,
                              builder: (context, snapshot) {
                                return Container(
                                  child: inputWidget(
                                      attribute: 'address_type_name',
                                      validators: [
                                        FormBuilderValidators.required()
                                      ],
                                      textEditingController:
                                          _placeNameTextEditingController,
                                      hint: defaultType.title + " Name *",
                                      textInputType: TextInputType.text),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ButtonTheme(
              height: 40,
              minWidth: MediaQuery.of(context).size.width / 1.5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: FlatButton(
                  onPressed: () {
                    if (_validateInput()) {
                      // Validation Done
                      AddDeliveryAddressRequest request =
                          AddDeliveryAddressRequest(
                              full_address: address.addressLine,
                              address_line1: _areaTextEditingController.text,
                              area: _areaTextEditingController.text,
                              landmark: _landmarkTextEditingController.text,
                              pincode: _pinCodeTextEditingController.text,
                              place_type: defaultType.title,
                              place_name: _placeNameTextEditingController.text,
                              latitude: address.coordinates.latitude.toString(),
                              longitude:
                                  address.coordinates.longitude.toString());

                      Navigator.of(context).pop(request);
                    } else {
                      CommonUtils.errorMessage(
                          msg: "Please fill required filed");
                    }
                  },
                  color: Colors.red,
                  child: Text(
                    "Confirm Delivery Address",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  )),
            ),
          )
        ],
      ),
    ));
  }

  inputWidget(
      {@required String attribute,
      @required List<FormFieldValidator> validators,
      @required var textInputType,
      @required TextEditingController textEditingController,
      @required String hint,
      int maxLine: 1,
      bool readOnly: false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: FormBuilderTextField(
        maxLines: maxLine,
        autofocus: false,
        validators: validators,
        controller: textEditingController,
        textAlign: TextAlign.left,
        keyboardType: textInputType,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1)),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.black, fontSize: 12),
        ),
        attribute: attribute,
      ),
    );
  }

  bool _validateInput() {
    if (_fbKey.currentState.validate()) {
      // If all data are correct then save data to out variables
      _fbKey.currentState.save();
      return true;
    } else {
      // If all data are not valid then start auto validation.
      return false;
    }
  }
}

class AddressTypeModal {
  AddressType addressType;
  String title;

  AddressTypeModal(this.addressType, this.title);
}
