import 'package:flutter/material.dart';
import 'stateBloc.dart';
class Navigation extends StatefulWidget {
  final StateBloc stateBloc;
  Navigation({Key key, @required this.stateBloc}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  final _widgetOptions = [
    Text('Map'),
    Text('Post'),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.stateBloc.pageStream.listen((onData){
      setState(() {
        _selectedIndex = onData;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.map), title: _widgetOptions[0]),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), title: _widgetOptions[1]),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Color(0xff64dd17),
        onTap: _onItemTapped,
      );
  }

  void _onItemTapped(int index) {
    widget.stateBloc.changePage(index);
    
    
  }
}
