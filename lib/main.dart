import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Completer<GoogleMapController> _controller = Completer();

  LatLng _center = LatLng(45.521563, -122.677433);
  
  void _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
    var location = new Location();
    location.getLocation().then((LocationData currentLocation){
      _controller.future.then((GoogleMapController controller){
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(currentLocation.latitude, currentLocation.longitude),
              zoom: 16.0
            ),
          ),
        );
      });
    });
    location.onLocationChanged().listen((LocationData currentLocation) {
      _controller.future.then((GoogleMapController controller){
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(currentLocation.latitude, currentLocation.longitude),
              zoom: 16.0
            ),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
          myLocationEnabled: true,
        ),
      ),
    );
  }
}