// import 'package:api_sukma/view/form_screen.dart';
import 'package:api_sukma/view/home_screen.dart';
// import 'package:api_sukma/view/menu.dart';
// import 'package:api_sukma/view/product_screen.dart';
import 'package:flutter/material.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.pinkAccent,
        accentColor: Colors.pink,
      ),
      home: HomeScreen(),
      //inisialisasi routes di dalam aplikasi untuk berpindah halaman
      // routes: {
      //   '/profile': (context) => HomeScreen(), 
      //   '/product': (context) => ProductScreen(), 
        
      // },
    );
  }
}