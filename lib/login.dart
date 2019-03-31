import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Container(
          alignment: AlignmentDirectional(0.0, 0.0),
          margin: new EdgeInsets.all(20.0),
          decoration: new BoxDecoration(
          image: new DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          )
        ),
        child: TextField(
            decoration: new InputDecoration(
                filled: true,
                fillColor: Colors.white,
                //labelText: "Enter Username",
                labelText: 'Enter Username',
                border: const OutlineInputBorder(
                  borderSide: const BorderSide(width: 40.0),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
            onSubmitted: (text){
              Navigator.pop(context);
            },
          )
      )
      )
    );
  }
}