

import 'package:flutter/material.dart';


import 'navigation.dart';
import 'map.dart';
import 'stateBloc.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}
StateBloc stateBloc = new StateBloc();
class _MyAppState extends State<MyApp> {
  final List<Widget> pages = [
    new Map(),
    new Text("data"),
  ];
  int pageNum = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Food Locator'),
          backgroundColor: Color(0xff64dd17),
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