import 'package:flutter/material.dart';
import 'package:flutter_app_true_false/screens/home/home.dart';
import 'package:flutter_app_true_false/styles/style.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() {
    return _MyAppState();
  }

}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'True/False Quiz',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: HomePage(),
    );
  }

}
