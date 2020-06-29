import 'package:flutter/material.dart';
import 'package:flutter_app_true_false/components/layout_app_logo.dart';
import 'package:flutter_app_true_false/components/layout_load.dart';
import 'package:flutter_app_true_false/components/main_button.dart';
import 'package:flutter_app_true_false/components/quiz_page.dart';
import 'package:flutter_app_true_false/models/user.dart';
import 'package:flutter_app_true_false/screens/home/components/home_header.dart';
import 'package:flutter_app_true_false/screens/sign_in/sign_in_page.dart';
import 'package:flutter_app_true_false/services/localizations.dart';
import 'package:flutter_app_true_false/services/no_animation_pageroute.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/constants.dart' as constants;

class HomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<HomePage> {

  User currentUser;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    User.getCurrentUser().then((_user) {
      setState(() {
        currentUser = _user;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (isLoading)?
        LayoutLoad():
        SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(left: 4.0, right: 4.0),
            decoration: QuizPage.quizDecoration(),
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 40.0),),
                HomeHeader(currentUser, actionSignOut, actionSettings, actionRatingApp, actionShare),
                Padding(padding: EdgeInsets.only(bottom: 20.0),),
                LayoutAppLogo(),
                Padding(padding: EdgeInsets.only(bottom: 20.0),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    MainButton(
                      MyLocalizations.of(context).localization['play'],
                      () {
                      },
                      textAlign: TextAlign.center,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 20.0),),
                    MainButton(
                      MyLocalizations.of(context).localization['leaderboard'],
                      () {
                      },
                      textAlign: TextAlign.center,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 20.0),),
                    MainButton(
                      MyLocalizations.of(context).localization['latest_results'],
                      () {
                      },
                      textAlign: TextAlign.center,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 20.0),),
                    MainButton(
                      MyLocalizations.of(context).localization['about'],
                      () {
                      },
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
    );
  }

  void actionSignOut() {
    if (currentUser != null && currentUser.id.length > 0) { //logout
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );
      _googleSignIn.signOut();
      currentUser.fullName = '';
      currentUser.id = '';
      currentUser.urlProfilPic = '';
      User.setUser(currentUser);
      Navigator.pushReplacement(context, NoAnimationMaterialPageRoute(builder: (context) {
        return SignInPage();
      }));
    }
    else {
      Navigator.pushReplacement(context, NoAnimationMaterialPageRoute(builder: (context) {
        return SignInPage();
      }));
    }
  }

  void actionShare() {
    Share.share(MyLocalizations.instanceLocalization['text_share_app'] +
        'https://play.google.com/store/apps/details?id=${constants.APP_PACKAGE}');
  }

  void actionRatingApp() {
    launch('https://play.google.com/store/apps/details?id=${constants.APP_PACKAGE}');
  }

  void actionSettings() {

  }
}