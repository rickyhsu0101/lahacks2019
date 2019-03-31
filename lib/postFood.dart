
import 'package:flutter/material.dart';
import 'stateBloc.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:location/location.dart';

class PostFood extends StatefulWidget{
  final FormBloc formBloc;
  final StateBloc stateBloc;
  PostFood({Key key, @required this.formBloc, @required this.stateBloc}) : super(key: key);
  @override
  _PostFoodState createState() => _PostFoodState();
}
class _PostFoodState extends State<PostFood>{
  
  TextEditingController typeController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Location location = new Location();
  submit(){
    _formKey.currentState.save();
    
    http.post("https://safe-forest-54595.herokuapp.com/api/postfood", body: {
        'img': base64Image,
        'type': typeController.text,
        'description': descriptionController.text,
        'locationLat': locationController.text.split(',')[0],
        'locationLong': locationController.text.split(',')[1]
      })
      .then((response){
        print("${response.body}");
        widget.stateBloc.changePage(0);
      });
  }
  
var url = "https://safe-forest-54595.herokuapp.com/api/sendImage";
  File _image;
  //List<Widget> widgetList;
  String base64Image;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    List<int> imageBytes = _image.readAsBytesSync();
    base64Image = base64Encode(imageBytes);
    print(base64Image.length);
    http.post(url, body:{"img": base64Image}).then((response) {
      Map<String, Object> responseMap = json.decode(response.body);
      typeController.text = responseMap['tags'] as String;
   // print("Response status: ${response.statusCode}");
    //print("Response body: ${responseMap['tags']}");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    location.getLocation().then((LocationData currentLocation){
      widget.formBloc.changeForm("Location", "${currentLocation.latitude},${currentLocation.longitude}");
      locationController.text = "${currentLocation.latitude},${currentLocation.longitude}";
    });
  }
  @override
  Widget build(BuildContext context) {
    return new ListView(
      padding: EdgeInsets.all(30.0),
      children: <Widget>[new Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
              _image == null ? SizedBox(height: 0): Image.file(_image),
              Opacity(
                opacity: _image == null ? 1.0 : 0.0,
                child: IconButton(
                icon: Icon(Icons.camera_enhance),
                iconSize: 150.0,
                tooltip: 'Take picture',
                color: Color(0xff737373),
                onPressed: getImage,
                )
              )
              
              ],
            ),
            const SizedBox(height: 30.0),
            TextFormField(
              decoration: new InputDecoration(
                labelText: "Type of Food",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 40.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
               
              ),
              controller: typeController,
              onSaved: (String value){
                  widget.formBloc.changeForm("Type of Food", value);
                  widget.formBloc.changeForm("Image", base64Image);
                  
              }
            ),
            const SizedBox(height: 30.0),
            TextFormField(
              decoration: new InputDecoration(
                labelText: "Description",
                border: const OutlineInputBorder(
                  borderSide: const BorderSide(width: 40.0),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              onSaved: (String value){
                  widget.formBloc.changeForm("Description", value);
              },
              controller: descriptionController,
            ),
            const SizedBox(height: 30.0),
            TextFormField(
              decoration: new InputDecoration(
                labelText: "Location",
                border: const OutlineInputBorder(
                  borderSide: const BorderSide(width: 40.0),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              onSaved: (String value){
                location.getLocation().then((LocationData currentLocation){
                    widget.formBloc.changeForm("Location", "${currentLocation.latitude},${currentLocation.longitude}");
                  });
              },
              controller: locationController,
            ),
            const SizedBox(height: 20.0),
            ButtonTheme(
              minWidth: 80.0,
              height: 40.0,
              child: RaisedButton(
                child: const Text('Submit!'),
                color: const Color(0xff64dd17),
                onPressed: submit,
                textColor: Colors.white,
              ),
            ),
          ]
        )
      ),]
    );
  }
}
