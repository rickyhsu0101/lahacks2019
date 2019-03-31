import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'foodItem.dart';

import 'stateBloc.dart';

class MapView extends StatefulWidget{
   final String currentUser;
   final RecenterBloc rBloc;

   MapView({Key key, @required this.currentUser, @required this.rBloc}) : super(key: key);
  @override
  _MapState createState() => _MapState();
}
class _MapState extends State<MapView>{
  Completer<GoogleMapController> _controller = Completer();
  var initialLocation = new Location();
  LatLng _center = LatLng(34.0522342, -118.2436849);
  //Set<Marker> markers = new Set<Marker>();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    
  }
  void _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
    var location = new Location();


    http.get("https://safe-forest-54595.herokuapp.com/api/food/all")
      .then((response){
        print("${response.body}");
        var map = jsonDecode(response.body);
        var list = map['food']; 
        print("${list.length}");
          if(this.mounted){
          setState((){
              
             for(int i = 0; i < list.length; i++){
               final MarkerId mI= new MarkerId("${i}");
                final Marker m = new Marker(
                    markerId: mI,
                    position: new LatLng(list[i]['locationLat'], list[i]['locationLong']),
                    infoWindow: new InfoWindow(title: list[i]['type'], snippet: list[i]['description']),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                    visible: true,
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FoodItem(lat: list[i]['locationLat'], long: list[i]['locationLong'], currentUser: widget.currentUser,)),
                      );
                    }
                  );
                
                  markers[mI] = m;
               
              }
           
          });
          }
         
        
        
        print("${markers.length}");

      });
    
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
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 16.0,
      ),
      myLocationEnabled: true,
      markers: Set<Marker>.of(markers.values),
    );
  }
}