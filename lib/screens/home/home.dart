import 'package:flutter/material.dart';
import 'package:flutter_app_true_false/services/localizations.dart';

class HomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyLocalizations.of(context).localization['app_title']),
      ),
      body: Center(
          child: Text('Hello World!')
      ),
    );
  }
}