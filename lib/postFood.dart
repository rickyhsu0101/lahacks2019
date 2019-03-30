
import 'package:flutter/material.dart';
import 'stateBloc.dart';
class PostFood extends StatefulWidget{
  final FormBloc formBloc;
  PostFood({Key key, @required this.formBloc}) : super(key: key);
  @override
  _PostFoodState createState() => _PostFoodState();
}
class _PostFoodState extends State<PostFood>{
  

  final _formKey = GlobalKey<FormState>();
  submit(){
    _formKey.currentState.save();
  }
  
  @override
  Widget build(BuildContext context) {
    return new ListView(
      padding: EdgeInsets.all(8.0),
      children: <Widget>[new Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10.0), //camera icon
            IconButton(
              icon: Icon(Icons.camera_enhance),
              iconSize: 150.0,
              tooltip: 'Take picture',
              onPressed: (){
                setState(() {
                  //photo handling
                });
              },
            ),
            const SizedBox(height: 30.0),
            TextFormField(
              decoration: new InputDecoration(
                labelText: "Type of Food",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 40.0, color: Colors.blue),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              onSaved: (String value){
                  widget.formBloc.changeForm("Type of Food", value);
              }
            ),
            const SizedBox(height: 30.0),
            TextFormField(
              decoration: new InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 40.0, color: Colors.blue),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              onSaved: (String value){
                  widget.formBloc.changeForm("Description", value);
              }
            ),
            const SizedBox(height: 30.0),
            TextFormField(
              decoration: new InputDecoration(
                labelText: "Location",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 40.0, color: Colors.blue),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              onSaved: (String value){
                  widget.formBloc.changeForm("Location", value);
              }
            ),
            const SizedBox(height: 20.0),
            RaisedButton(
              onPressed: submit,
              child: const Text('Submit!'),
            ),
          ]
        )
      ),]
    );
  }
}
