import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Initial'),
      ),
      body: Center(
          child: Text('Hello World!')
      ),
    );
  }
}