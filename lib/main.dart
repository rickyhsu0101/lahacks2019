

import 'package:flutter/material.dart';


import 'navigation.dart';
import 'map.dart';
import 'postFood.dart';
import 'stateBloc.dart';
import 'foodlisting.dart';
void main() => runApp(Wrapper());

String user = "";
String phone = "";
class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: new ThemeData(
        primaryColor: Color(0xff64dd17),
      ),
      home: Login()
    );
  }
}
class Login extends StatefulWidget{
  @override
  _LoginState createState()=>_LoginState();
}
class _LoginState extends State<Login>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(brightness: Brightness.light,
          /*leading: Builder(
            builder: (BuildContext context) {
        /*  return IconButton(
                icon: new ImageIcon(new AssetImage("assets/FeedMeLogo.jpg")),
                disabledColor: Color(0xff737373),
                onPressed: null
              );*/
            },
          ),*/
          title: Text('Feed Me', style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Color(0xff64dd17))),
          backgroundColor: Color(0xfff5f5f5),
        ),
        body: Center(
          child: new Stack(
            children: <Widget>[
              Center(child: Container(
                alignment: AlignmentDirectional(0.0, 0.0),
                color: Color(0xff64dd17),
               
                ),
              ),
              Center(child: Container(
                margin: EdgeInsets.all(20.0),
                child: new ListView(
                  children: <Widget>[
                    const SizedBox(height: 30.0),
                    Image.asset("assets/FeedMe.png", height: 153, width: 240),
                    const SizedBox(height: 40.0),
                    TextField(
                    decoration: new InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        //labelText: "Enter Username",
                        hintText: 'Enter Username',
                        border: const OutlineInputBorder(
                          borderSide: const BorderSide(width: 40.0),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                      ),
                      onChanged: (text){
                        user = text;
                      },
                ),

                const SizedBox(height: 30.0),
                TextField(
                  decoration: new InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Phone',
                    border: const OutlineInputBorder(
                      borderSide: const BorderSide(width: 40.0),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                  ),
                  onSubmitted: (text){
                      
                  },
                  onChanged: (text){
                    phone = text;
                  },
                ),

                const SizedBox(height: 30.0),
                new RaisedButton(
                  child: Text("Login", ),
                  color: Colors.grey[700],
                  textColor: Colors.white,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)
                  ),
                  onPressed: (){
                    print(user);
                    print(phone);
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>MyApp()),);
                  },
                  
                )],
                
              
              )
              )
              )
              
            ]
          )
          )
          
       
    );
  }
}


class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  FormBloc formBloc = new FormBloc();
  final List<Widget> pages = new List<Widget>();
  int pageNum = 0;
  StateBloc stateBloc = new StateBloc();
  RecenterBloc centerBloc = new RecenterBloc();

  @override
  void initState() {
    super.initState();
    pages.add(new MapView(currentUser: user,rBloc: centerBloc,));
    pages.add(new PostFood(formBloc: formBloc, stateBloc: stateBloc,user: user, phone: phone));
    pages.add(new FoodList(currentUser: user, sBloc: stateBloc, rBloc: centerBloc));
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          /*leading: Builder(
            builder: (BuildContext context) {
              /*return IconButton(
                icon: Icon(Icons.local_pizza),
                disabledColor: Color(0xff737373),
                onPressed: null
              );*/
            },
          ),*/
          title: Text('Feed Me', style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Color(0xff64dd17))),
          backgroundColor: Color(0xfff5f5f5),
        ),
        body: StreamBuilder(
                initialData: 0,
                stream: stateBloc.pageStream,
                builder: (BuildContext context, snapShot) => pages[snapShot.data],
              ),
        
        bottomNavigationBar: new Navigation(stateBloc: stateBloc),
      );
  }
}