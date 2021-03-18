import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/auth/Auth.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/painting.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:google_geocoding/google_geocoding.dart' as geo;

class EditLocation extends StatefulWidget {
  @override
  _ConfirmLocationScreenState createState() => _ConfirmLocationScreenState();
}

class _ConfirmLocationScreenState extends State<EditLocation> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController controller;
  Location location;
  String address = "";

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

  StreamController<Marker> _markerStreamController =
  StreamController.broadcast();

  StreamController<String> _addressStreamContoller =
  StreamController.broadcast();

  Auth auth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    location = Location();

    auth = Auth();
    googleGeocoding =
        geo.GoogleGeocoding("AIzaSyDv7BRWslfhqpUXAc5brYXtITXjWZqFxQE");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _markerStreamController?.close();
    _addressStreamContoller?.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,

          title: Center(
              child:      Padding(
                padding: EdgeInsets.only(right: 20),

            child:  Text("Edit Location", style: TextStyle(color: Colors.black,
                  fontSize: 15),
                textAlign: TextAlign.center, ))),

          leading:Builder(
            builder: (context) => IconButton(
              icon: new Icon(Icons.close, color: Colors.black,),
              onPressed: () => null,
            ),
          ),

          bottom: PreferredSize(
              child: Container(
                color: Colors.grey,
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0)),
        ),
        body: Stack(
          children: <Widget>[
            StreamBuilder<Marker>(
                stream: _markerStreamController.stream,
                initialData: marker,
                builder: (context, snapshot) {
                  return GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                    markers: {marker},
                    onCameraMove: (position) async {
                      cameraPosition = position;
                      marker = Marker(
                        markerId: MarkerId('currentLocation'),
                        position: LatLng(cameraPosition.target.latitude,
                            cameraPosition.target.longitude),
                        infoWindow: InfoWindow(title: "Current Location"),
                        onTap: () {},
                      );
                      geo.GeocodingResponse result =
                      await googleGeocoding.geocoding.getReverse(geo.LatLon(
                          cameraPosition.target.latitude,
                          cameraPosition.target.longitude));

                      print("Length " + result.results.length.toString());
                      print(result.status);

                      if (result.results.length != 0) {
                        address = result.results[0].formattedAddress;
                      }
                      _markerStreamController.sink.add(marker);
                      _addressStreamContoller.sink.add(address);
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      getLocation();
                    },
                  );
                }),

              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red[500],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5))
                ),

                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10,),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Form(
child: Column(
  children: [
          Padding(padding: const EdgeInsets.only( right: 10.0),
                          child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              // new Expanded(
                               TextFormField(
                                  // LOGIN SCREEN EMAIL
                                 controller: _controllerTextAddress,
                                  maxLines: 2,
                                  autofocus: false,
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey, width: 1)
                                    ),
                                    border: InputBorder.none,
                                    hintText: "Select Area",
                                    hintStyle: TextStyle(color: Colors.black,
                                    fontSize: 12),
                                  ),

                                // ),
                              ),
                            ],
                          ),
                        ),


    new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Flexible(
          child:  TextFormField(
     // LOGIN SCREEN EMAIL
     maxLines: 1,
     autofocus: false,
     textAlign: TextAlign.left,
     decoration: InputDecoration(

       enabledBorder: UnderlineInputBorder(
           borderSide: BorderSide(color: Colors.grey, width: 1)
       ),
       border: InputBorder.none,
       hintText: "House No",
       hintStyle: TextStyle(color: Colors.black,
           fontSize: 12),
     ),

   ),
        ),
        SizedBox(width: 20.0,),
        new Flexible(
          child:   TextFormField(
          // LOGIN SCREEN EMAIL
          maxLines: 1,
          autofocus: false,
          textAlign: TextAlign.left,
          decoration: InputDecoration(

            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1)
            ),
            border: InputBorder.none,
            hintText: "Street No",
            hintStyle: TextStyle(color: Colors.black,
                fontSize: 12),
          ),

        ),
        ),
        SizedBox(width: 20.0,),
        new Flexible(
          child:  TextFormField(
            // LOGIN SCREEN EMAIL
            maxLines: 1,
            autofocus: false,
            textAlign: TextAlign.left,
            decoration: InputDecoration(

              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1)
              ),
              border: InputBorder.none,
              hintText: "Pincode",
              hintStyle: TextStyle(color: Colors.black,
                  fontSize: 12),
            ),

          ),
        ),
      ],
    ),


    Padding(padding: const EdgeInsets.only( right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextFormField(
              // LOGIN SCREEN EMAIL
              maxLines: 1,
              autofocus: false,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1)
                ),
                border: InputBorder.none,
                hintText: "Landmark",
                hintStyle: TextStyle(color: Colors.black,
                    fontSize: 12),
              ),

            ),
          ),
        ],
      ),
    ),
    Padding(padding: const EdgeInsets.only( right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextFormField(
              // LOGIN SCREEN EMAIL
              maxLines: 1,
              autofocus: false,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1)
                ),
                border: InputBorder.none,
                hintText: "Select ",
                hintStyle: TextStyle(color: Colors.black,
                    fontSize: 12),


                  suffixIcon:
                IconButton(
                      icon: Icon(Icons.arrow_drop_down, color: Colors.grey)

              ),
              ),

            ),
          ),
        ],
      ),
    ),
    Padding(padding: const EdgeInsets.only( right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextFormField(
              // LOGIN SCREEN EMAIL
              maxLines: 1,
              autofocus: false,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1)
                ),
                border: InputBorder.none,
                hintText: "Apartment",
                hintStyle: TextStyle(color: Colors.black,
                    fontSize: 12),

              ),

            ),
          ),
        ],
      ),
    ),
  ],
),

)
                      ],
                    ),
                  ),

              ),
            // ),
          ],
        ),
        bottomNavigationBar:

                Padding(
                  padding: const EdgeInsets.only(top: 10.0,
               left: 40, right: 40 ),
                  child: ButtonTheme(
                    height: 30,
                    minWidth: MediaQuery.of(context).size.width / 2.5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: FlatButton(
                        onPressed: () =>{
                          null
                          // ChoosedPlace place = ChoosedPlace();
                          // place.address = address;
                          // place.lat = marker.position.latitude;
                          // place.lng = marker.position.longitude;
                          // print(jsonEncode(place));
                          // Navigator.of(context).pop(place);
                        },
                        color: Colors.red,
                        child: Text(
                          "Confirm Delivery Address", style: TextStyle( color: Colors.white,

                            fontSize: 15),
                        ),

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
        controller
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

        marker = Marker(
          markerId: MarkerId('currentLocation'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(title: "Current Location"),
          draggable: true,
          onTap: () {},
        );

        geo.GeocodingResponse result = await googleGeocoding.geocoding
            .getReverse(geo.LatLon(cameraPosition.target.latitude,
            cameraPosition.target.longitude));

        print("Length " + result.results.length.toString());
        print(result.status);

        if (result.results.length != 0) {
          address = result.results[0].formattedAddress;
        }
        _markerStreamController.sink.add(marker);
        _addressStreamContoller.sink.add(address);
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
}
