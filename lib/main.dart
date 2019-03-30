

import 'package:flutter/material.dart';


import 'navigation.dart';
import 'map.dart';
import 'postFood.dart';
import 'stateBloc.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  FormBloc formBloc = new FormBloc();
  final List<Widget> pages = new List<Widget>();
  int pageNum = 0;
  StateBloc stateBloc = new StateBloc();

  @override
  void initState() {
    super.initState();
    pages.add(new Map());
    pages.add(new PostFood(formBloc: formBloc));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
      primaryColor: Color(0xff64dd17),
      ),
      home: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.local_pizza),
                disabledColor: Color(0xff737373),
                onPressed: null
              );
            },
          ),
          title: Text('Food Locator', style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: Color(0xff64dd17))),
          backgroundColor: Color(0xfff5f5f5),
        ),
        body: StreamBuilder(
                initialData: 0,
                stream: stateBloc.pageStream,
                builder: (BuildContext context, snapShot) => pages[snapShot.data],
              ),
        
        bottomNavigationBar: new Navigation(stateBloc: stateBloc),
      ),
    );
  }
}
