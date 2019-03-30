import 'package:flutter/material.dart';
import 'stateBloc.dart';
class Navigation extends StatefulWidget {
  final StateBloc stateBloc;
  Navigation({Key key, @required this.stateBloc}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 1;
  final _widgetOptions = [
    Text('Index 0: Home'),
    Text('Index 1: Business'),
    Text('Index 2: School'),
  ];
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('Business')),
          //BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('School')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.deepPurple,
        onTap: _onItemTapped,
      );
  }

  void _onItemTapped(int index) {
    widget.stateBloc.changePage(index);
    setState(() {
      _selectedIndex = index;
    });
  }
}