import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:camera/camera.dart';


class ImagePicking extends StatefulWidget {
  @override
  _ImagePickingState createState() => new _ImagePickingState();
}

class _ImagePickingState extends State<ImagePicking> {
  var url = "https://safe-forest-54595.herokuapp.com/api/sendImage";
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    List<int> imageBytes = _image.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    print(base64Image.length);
    http.post(url, body:{"img": base64Image}).then((response) {
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picking'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}