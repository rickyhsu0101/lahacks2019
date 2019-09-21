
import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:location/location.dart';
import 'dart:math';
import 'package:latlong/latlong.dart';
class FoodItem extends StatefulWidget {
  final double lat;
  final double long;
  final String currentUser;
  FoodItem({Key key,  @required this.lat, @required this.long, @required this.currentUser}) : super(key: key);
  @override
  _FoodItemState createState() => new _FoodItemState();
}
class _FoodItemState extends State<FoodItem>{
  String _url = "";
  String _description = "";
  String _type = "";
  String _donor = "";
  String _acceptor = "";
  double _distance= -1.0; 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    http.get("https://safe-forest-54595.herokuapp.com/api/food/${widget.lat}/${widget.long}")
      .then((response){
        Map<String, dynamic> map = jsonDecode(response.body);
        List list = map['food'];
        Map<String, dynamic> firstElement = list[0];
        Location location = new Location();
       // location.getLocation().then((data){
          Distance distance = new Distance();
            double miles = distance.as(LengthUnit.Mile,  new LatLng(34.066624, -118.4469441),new LatLng(widget.lat, widget.long));
            setState(() {
              _url = firstElement['image'];
              _description = firstElement['description'];
              _type = firstElement['type'];
              _donor = firstElement['donor'];
              _acceptor = firstElement['acceptor'];
              _distance = miles;
            });
        //});
        
      });
    
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          brightness: Brightness.light,
          /*leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.local_pizza),
                disabledColor: Color(0xff737373),
                onPressed: null
              );
            },
          ),*/
          title: Text('Feed Me', style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Color(0xff64dd17))),
          backgroundColor: Color(0xfff5f5f5),
        ),
      body: _acceptor == "" ? Center(child: new CircularProgressIndicator()):new ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          _url == ""? SizedBox() : new Image.network(_url),
          Text(_type, style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: Color(0xff64dd17))),
          Text(_description, style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold,)),
          Text("Donor: $_donor", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold,)),
          Text("Acceptor: $_acceptor", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold,)),
          Text("$_distance miles", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold,)),
          _donor == widget.currentUser ? new RaisedButton(
            child: Text("Delete"),
            onPressed: (){

            },
            
          ) : new RaisedButton(
            child: Text("Notify Donor"),
            onPressed: (){
              //run api
              http.get("https://safe-forest-54595.herokuapp.com/api/notify/${widget.lat}/${widget.long}/${widget.currentUser}")
                .then((response){
                  Navigator.pop(context);
                });
              

            },
          ),
          new RaisedButton(
            child: Text("Cancel"),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          new RaisedButton(
            child: Text("Location"),
            onPressed: (){
              Navigator.pop(context, "${widget.lat},${widget.long}");
            },
          )
        ]
      )
    );
  }
}