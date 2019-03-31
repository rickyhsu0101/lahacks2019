import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:latlong/latlong.dart';
import 'foodItem.dart';
import 'package:location/location.dart';
import 'stateBloc.dart';
class FoodList extends StatefulWidget{
  final String currentUser;
  final StateBloc sBloc;
  final RecenterBloc rBloc;
  FoodList({Key key,  @required this.currentUser, @required this.sBloc, @required this.rBloc,}) : super(key: key);
  @override
  _FoodListState createState() => _FoodListState();
}
class _FoodListState extends State<FoodList>{
  List postingList = new List(); 
  Location location = new Location();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    http.get("https://safe-forest-54595.herokuapp.com/api/food/all")
      .then((response){
        print("${response.body}");
        Map<dynamic,dynamic> mapping = jsonDecode(response.body);
        List list = mapping['food']; 
        //location.getLocation().then((response){
          for(int i = 0; i < list.length; i++){
            
            Map<String, dynamic> tempMap = list[i];
            
            Distance distance = new Distance();
            
            double miles = distance.as(LengthUnit.Mile, new LatLng(34.066624, -118.4469441),new LatLng(tempMap['locationLat'], tempMap['locationLong']));
            tempMap.putIfAbsent("distance", ()=>miles);
          }
          
          if(list.length >= 2){
            list.sort((dynamic map1, dynamic map2) {
            return map1['distance'].compareTo(map2['distance']);
            });
          }
          
          print("${list.length}");
          setState((){
            postingList = list;
          });
        //});
        
      });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return postingList.length == 0? Center(child: CircularProgressIndicator()): ListView.builder(
        itemCount: postingList.length,
        itemBuilder: (context, int index){
          return new Card(
            key: new Key("$index"),
            child: Column(children: <Widget>[
              Row(
                children: <Widget>[
                  new Image.network(postingList[index]['image'], fit: BoxFit.cover, width: 100, height: 100,),
                  Column(
                    children: <Widget>[
                      Text(postingList[index]['type']),
                      Text("Distance: ${postingList[index]['distance']} miles")
                    ],
                  )
                  
                ]
                
              ),
              new FlatButton(
                child: Text("See Detail"),
                onPressed: (){
                  ()async{
                    final  String value = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FoodItem(
                          lat: postingList[index]['locationLat'],
                          long: postingList[index]['locationLong'],
                          currentUser: widget.currentUser,
                        ),
                        )   
                    );
                    print(value);
                    if(value != null){
                      widget.sBloc.changePage(0);
                      widget.rBloc.changeCenter(value);
                    }
                  }();
                },
              )

            ],)
          );
        },
    );
  }
}