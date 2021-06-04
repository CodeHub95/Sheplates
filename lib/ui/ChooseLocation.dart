import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/app_utils.dart';
import 'package:flutter_sheplates/auth/Auth.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/painting.dart';
import 'package:flutter_sheplates/auth/RestApiCalls.dart';
import 'package:flutter_sheplates/modals/request/AddDeliveryAddressRequest.dart';
import 'package:flutter_sheplates/ui/stateful/edit_address_screen.dart';
import 'package:flutter_sheplates/ui/stateful/location_check_screen.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:google_geocoding/google_geocoding.dart' as geo;

class ChooseLocation extends StatefulWidget {
  final String type;
  final int is_delivery;

  const ChooseLocation({Key key, this.type, this.is_delivery}) : super(key: key);

  @override
  _ConfirmLocationScreenState createState() => _ConfirmLocationScreenState(this.type, this.is_delivery);
}

class _ConfirmLocationScreenState extends State<ChooseLocation> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController controller;
  Location location;
  String address = "";
  final String type;
  final int is_delivery;
  var onChangeMap = '1';
  geo.GoogleGeocoding googleGeocoding;
  List<geo.GeocodingResult> geocodingResults = [];
  List<geo.GeocodingResult> reverseGeocodingResults = [];

  TextEditingController _controllerTextAddress = TextEditingController();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  CameraPosition cameraPosition = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  // creating a new MARKER
  Marker marker = Marker(
    markerId: MarkerId('currentLocation'),
    position: LatLng(37.43296265331129, -122.08832357078792),
    infoWindow: InfoWindow(title: "Current Location", snippet: '*'),
    onTap: () {},
  );

  StreamController<Marker> _markerStreamController = StreamController.broadcast();

  // StreamController<String> _addressStreamContoller = StreamController.broadcast();

  Auth auth;

  _ConfirmLocationScreenState(this.type, this.is_delivery);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    location = Location();

    auth = Auth();
    googleGeocoding = geo.GoogleGeocoding("AIzaSyBqLg77qJqXhiA8u1TRPxmT3QCFt8ZLTR8");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _markerStreamController?.close();
    // _addressStreamContoller?.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Center(
                  child: Text(
                "Choose Location",
                style: TextStyle(color: Colors.black, fontSize: 15),
                textAlign: TextAlign.center,
              ))),
          bottom: PreferredSize(
              child: Container(
                color: Colors.grey,
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0)),
        ),
        body: Stack(
          children: <Widget>[
            // StreamBuilder<Marker>(
            //     stream: _markerStreamController.stream,
            //     initialData: marker,
            //     builder: (context, snapshot) {
            //       return
            Container(
                child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              markers: {marker},
              onCameraMove: (position) async {
                if (onChangeMap == '1') {
                  cameraPosition = position;
                  marker = Marker(
                    markerId: MarkerId('currentLocation'),
                    position: LatLng(cameraPosition.target.latitude, cameraPosition.target.longitude),
                    icon: await BitmapDescriptor.fromAssetImage(
                        ImageConfiguration(size: Size(50, 50)), "assets/2.0x/current_location.png"),
                    infoWindow: InfoWindow(title: "Current Location"),
                    onTap: () {},
                  );
                  geo.GeocodingResponse result = await googleGeocoding.geocoding
                      .getReverse(geo.LatLon(cameraPosition.target.latitude, cameraPosition.target.longitude));

                  print(result.status + "onchangehitting");

                  if (result.results.length != 0) {
                    address = result.results[0].formattedAddress;
                  }
                  _markerStreamController.sink.add(marker);
                  // _addressStreamContoller.sink.add(address);
                  setState(() {});
                }
              },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                getLocation();
              },
            )),
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: EdgeInsets.all(10),
                child: Card(
                  shadowColor: Colors.grey,
                  elevation: 3,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/search_icon.png"),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, bottom: 2),
                            child: TypeAheadField(
                              textFieldConfiguration: TextFieldConfiguration(
                                  autofocus: false,
                                  controller: _controllerTextAddress,
                                  decoration: InputDecoration.collapsed(
                                      hintText: "Search by area, landmark",
                                      hintStyle: TextStyle(color: Colors.black, fontSize: 14))),
                              suggestionsCallback: (pattern) async {
                                if (pattern.trim().length == 1 ||
                                    pattern.trim().length == 3 ||
                                    pattern.trim().length == 5 ||
                                    pattern.trim().length == 8 ||
                                    pattern.trim().length == 11 ||
                                    pattern.trim().length == 14 ||
                                    pattern.trim().length == 17 ||
                                    pattern.trim().length <= 20) {
                                  geo.GeocodingResponse response = await googleGeocoding.geocoding.get(pattern, null);

                                  if (response != null && response.results.length != 0) {
                                    geocodingResults = response.results;
                                    print("@Length");
                                    print(geocodingResults.length);
                                  }
                                }
                                return geocodingResults;
                              },
                              itemBuilder: (context, geo.GeocodingResult suggestion) {
                                return ListTile(
                                  title: Text(suggestion.formattedAddress),
                                );
                              },
                              onSuggestionSelected: (geo.GeocodingResult suggestion) async {
                                marker = Marker(
                                  markerId: MarkerId('currentLocation'),
                                  icon: await BitmapDescriptor.fromAssetImage(
                                      ImageConfiguration(size: Size(50, 50)), "assets/2.0x/current_location.png"),
                                  position: LatLng(suggestion.geometry.location.lat, suggestion.geometry.location.lng),
                                  infoWindow: InfoWindow(title: suggestion.formattedAddress, snippet: '*'),
                                  onTap: () {
                                    onChangeMap = '2';
                                    Future.delayed(const Duration(seconds: 1), () {
// Here you can write your code
                                      onChangeMap = '1';
                                      setState(() {
                                        // Here you can write your code for open new view
                                      });
                                    });
                                  },
                                );

                                cameraPosition = CameraPosition(
                                    bearing: 192.8334901395799,
                                    target: LatLng(suggestion.geometry.location.lat, suggestion.geometry.location.lng),
                                    tilt: 0,
                                    zoom: 19.151926040649414);
                                controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

                                _controllerTextAddress.text = suggestion.formattedAddress;

                                _markerStreamController.sink.add(marker);
                                // _addressStreamContoller.sink.add(suggestion.formattedAddress);
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Card(
          margin: EdgeInsets.zero,
          elevation: 3,
          shadowColor: Colors.grey,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      // StreamBuilder<String>(
                      //     stream: _addressStreamContoller.stream,
                      //     initialData: address,
                      //     builder: (context, snapshot) {
                      //       return
                      Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          alignment: Alignment.topLeft,
                          child: Text(
                            address,
                            maxLines: 3,
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: SizedBox(
                            height: 20,
                            width: 65,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.red, width: 1),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              color: Colors.white,
                              child: Text(
                                "Edit",
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () async {
                                Address address = await CommonUtils.getAddressDetailsFromLatLong(
                                    context, Coordinates(marker.position.latitude, marker.position.longitude));
                                editDialog(address);
                              },
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ButtonTheme(
                    height: 40,
                    minWidth: MediaQuery.of(context).size.width / 1.5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: FlatButton(
                        onPressed: () async {
                          Address address = await CommonUtils.getAddressDetailsFromLatLong(
                              context, Coordinates(marker.position.latitude, marker.position.longitude));
                          editDialog(address);
                        },
                        color: Colors.red,
                        child: Text(
                          "Confirm Location",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getLocation() {
    location.hasPermission().then((value) {
      if (value != PermissionStatus.granted) {
        location.requestPermission().then((value) {
          if (value == PermissionStatus.granted) {
            checkServiceEnabled();
          }
        });
      } else {
        checkServiceEnabled();
      }
    });
  }

  void getCurrentLocation() {
    print("Fetching Location");
    location.getLocation().then((value) async {
      if (value != null) {
        print("Getting Location");
        print(value.latitude);

        cameraPosition = CameraPosition(
            bearing: 192.8334901395799,
            target: LatLng(value.latitude, value.longitude),
            tilt: 0,
            zoom: 19.151926040649414);
        controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

        marker = Marker(
          markerId: MarkerId('currentLocation'),
          position: LatLng(value.latitude, value.longitude),
          icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(size: Size(50, 50)), "assets/2.0x/current_location.png"),
          infoWindow: InfoWindow(title: "Current Location"),
          draggable: true,
          onTap: () {},
        );

        geo.GeocodingResponse result = await googleGeocoding.geocoding
            .getReverse(geo.LatLon(cameraPosition.target.latitude, cameraPosition.target.longitude));

        print("Length " + result.results.length.toString());
        print(result.status);

        if (result.results.length != 0) {
          address = result.results[0].formattedAddress;
        }
        _markerStreamController.sink.add(marker);
        // _addressStreamContoller.sink.add(address);
        setState(() {});
      }
    }).catchError((error) {
      print(error);
    });
  }

  void checkServiceEnabled() {
    if (Platform.isAndroid) {
      // For Android
      location.serviceEnabled().then((value) {
        if (value) {
          getCurrentLocation();
        } else {
          location.requestService().then((value) {
            if (value) {
              getCurrentLocation();
            }
          });
        }
      });
    } else {
      // For Ios
      getCurrentLocation();
    }
  }

  editDialog(Address address) {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    CommonUtils.dismissProgressDialog(context);
                  },
                )
              ],
            ),
            content: EditAddressScreen(
              address: address,
            ),
          );
        }).then((value) async {
      if (value != null) {
        AddDeliveryAddressRequest request = value as AddDeliveryAddressRequest;
        request.is_delivery_address = is_delivery;
        RestApiCalls apiCalls = RestApiCalls();

        String token = await SharedPrefHelper().getWithDefault("token", "");

        CommonUtils.fullScreenProgress(context);
        apiCalls.addDeliveryAddress(jsonEncode(request), token).then((value) {
          CommonUtils.dismissProgressDialog(context);
          if (value.status == 200) {
            CommonUtils.showToast(msg: value.message, bgColor: Colors.black, textColor: Colors.white);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (buildContext) {
              return LocationCheckScreen(address: address, type: widget.type);
            }));
          } else {
            CommonUtils.errorMessage(msg: value.message);
          }
        }).catchError(() {
          CommonUtils.dismissProgressDialog(context);
          CommonUtils.errorMessage(msg: "Something went wrong , Please try again");
        });
      }
    });
  }
}
