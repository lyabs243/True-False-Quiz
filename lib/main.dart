import 'package:flutter/material.dart';
import 'package:flutter_app_true_false/screens/home/home.dart';
import 'package:flutter_app_true_false/styles/style.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'services/constants.dart' as constants;

import 'services/localizations.dart';

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
      localizationsDelegates: [
        MyLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      locale: Locale(constants.LANG_CODE),
      onGenerateTitle: (BuildContext context) => MyLocalizations.of(context).localization['app_title'],
      supportedLocales: [Locale(constants.LANG_CODE)],
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: HomePage(),
    );
  }

}
