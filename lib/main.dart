import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main(){
  runApp(MaterialApp(
    title: 'Navigation',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Container(
          alignment: AlignmentDirectional(0.0, 0.0),
          margin: new EdgeInsets.all(20.0),
          decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("background.jpg"),
            fit: BoxFit.cover,
          )
        ),
        child: TextField(
            decoration: new InputDecoration(
                filled: true,
                fillColor: Colors.white,
                //labelText: "Enter Username",
                hintText: 'Enter Username',
                border: const OutlineInputBorder(
                  borderSide: const BorderSide(width: 40.0),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
            onSubmitted: (text){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondRoute()),
              );
            },
          )
      )
      )
    );
  }
}
class SecondRoute extends StatefulWidget {
  @override
  _SecondRoute createState() => _SecondRoute();
}

class _SecondRoute extends State<SecondRoute> {
  var url = "https://safe-forest-54595.herokuapp.com/api/sendImage";
  List<File> _images = new List<File>(100);
  int i = 0;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _images[i] = image;
    });

    List<int> imageBytes = _images[i].readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    print(base64Image.length);
    http.post(url, body:{"img": base64Image}).then((response) {
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");
    });
    i++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new ListView.builder(
        reverse: true,
        itemCount: _images == null 
                     ? 0 : _images.length,
        itemBuilder: (BuildContext ctxt, int index) {
          if (_images[index] != null){
            return Image.file(_images[index]);
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
