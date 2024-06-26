import 'package:flutter/material.dart';
import 'package:flutter_app_true_false/components/layout_load.dart';
import 'package:flutter_app_true_false/screens/home/home.dart';
import 'package:flutter_app_true_false/screens/sign_in/sign_in_page.dart';
import 'package:flutter_app_true_false/styles/style.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'models/user.dart';
import 'services/constants.dart' as constants;
import 'services/config.dart' as config;
import 'package:admob_flutter/admob_flutter.dart';
import 'services/localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() {
    return _MyAppState();
  }

}

class _MyAppState extends State<MyApp> {

  bool isLoading = true;
  User currentUser;

  @override
  void initState() {
    super.initState();
    User.getInstance().then((value) {
      setState(() {
        currentUser = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Admob.initialize(config.ADMOB_APP_ID);
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
      home: (isLoading)?
        LayoutLoad():
      ((constants.USING_SERVER && currentUser.id.length == 0)?
      SignInPage():
      HomePage()),
    );
  }

}
