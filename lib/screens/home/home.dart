import 'package:flutter/material.dart';
import 'package:flutter_app_true_false/components/layout_load.dart';
import 'package:flutter_app_true_false/models/user.dart';
import 'package:flutter_app_true_false/screens/sign_in/sign_in_page.dart';
import 'package:flutter_app_true_false/services/localizations.dart';
import 'package:flutter_app_true_false/services/no_animation_pageroute.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      appBar: AppBar(
        title: Text(MyLocalizations.of(context).localization['app_title']),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_back
            ),
            onPressed: () {
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
            },
          )
        ],
      ),
      body: (isLoading)?
        LayoutLoad():
        Center(
          child: Text('Hello World!')
        ),
    );
  }
}