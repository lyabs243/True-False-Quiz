import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_true_false/components/layout_app_logo.dart';
import 'package:flutter_app_true_false/components/main_button.dart';
import 'package:flutter_app_true_false/components/quiz_page.dart';
import 'package:flutter_app_true_false/models/user.dart';
import 'package:flutter_app_true_false/screens/home/home.dart';
import 'package:flutter_app_true_false/services/localizations.dart';
import 'package:flutter_app_true_false/services/no_animation_pageroute.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInPage extends StatefulWidget {

  @override
  _SignInPageState createState() {
    return _SignInPageState();
  }

}

class _SignInPageState extends State<SignInPage> {

  ProgressDialog _progressDialog;

  @override
  initState() {
    super.initState();
    _progressDialog = ProgressDialog(context, isDismissible: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: QuizPage.quizDecoration(),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 70.0),),
              LayoutAppLogo(),
              Padding(padding: EdgeInsets.only(bottom: 40.0),),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MainButton(
                    MyLocalizations.of(context).localization['sign_in_with_google'],
                    () {
                      _handleSignIn(context);
                    },
                    textAlign: TextAlign.center,
                    buttonColor: Theme.of(context).primaryColor,
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20.0),),
                  MainButton(
                    MyLocalizations.of(context).localization['continue_without_signing'],
                    () {
                      Navigator.pushReplacement(context, NoAnimationMaterialPageRoute(builder: (context) {
                        return HomePage();
                      }));
                    },
                    textAlign: TextAlign.center,
                    buttonColor: Theme.of(context).primaryColor,
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20.0),),
                ],
              ),
              RichText(
                textAlign: TextAlign.center,
                text: new TextSpan(
                  children: [
                    new TextSpan(
                      text: MyLocalizations.of(context).localization['term_use_text'],
                      style: new TextStyle(color: Colors.black,fontSize: 18.0),
                    ),
                    new TextSpan(
                      text: MyLocalizations.of(context).localization['term_use'],
                      style: new TextStyle(
                        color: Colors.green,
                        fontSize: 18.0,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          //launch(constants.LINK_TERMS_USE);
                        },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignIn(BuildContext _context) async {
    _progressDialog.show();
    User.handleSignIn(_context).then((value) {
      _progressDialog.hide();
      if (value) {
        Navigator.pushReplacement(context, NoAnimationMaterialPageRoute(builder: (context) {
          return HomePage();
        }));
      }
      else {
        Fluttertoast.showToast(
          msg: MyLocalizations.of(context).localization['error_occured'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    });
  }

}