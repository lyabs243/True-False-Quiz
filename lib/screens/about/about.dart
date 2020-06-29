import 'package:flutter/material.dart';
import 'package:flutter_app_true_false/components/button_circle.dart';
import 'package:flutter_app_true_false/components/quiz_page.dart';
import 'package:flutter_app_true_false/services/localizations.dart';
import '../../services/constants.dart' as constants;

class About extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: QuizPage.quizDecoration(),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 40.0),),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: ButtonCircle(
                        Icon(
                          Icons.arrow_back,
                          size: (25.0 / 853) * MediaQuery.of(context).size.height,
                          color: Colors.white,
                        ),
                        () {
                          Navigator.pop(context);
                        }
                    ),
                    width: (MediaQuery.of(context).size.width * 70 / 100) / 5,
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(bottom: 20.0),),
              Container(
                child: Text(
                  MyLocalizations.of(context).localization['about'],
                  textScaleFactor: 3.0,
                  style: TextStyle(
                    color: Colors.black
                  ),
                ),
              ),
              Container(
                child: Text(
                  '${constants.APP_NAME}',
                  textScaleFactor: 1.4,
                  style: TextStyle(
                    color: Colors.green
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 4.0, bottom: 4.0),),
              Container(
                child: Text(
                  '${MyLocalizations.of(context).localization['version']} ${constants.APP_VERSION}',
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 50.0, bottom: 4.0),),
              Container(
                child: Text(
                  "${constants.APP_NAME} ${MyLocalizations.of(context).localization['about_the_app']}",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.0,height: 1.2,wordSpacing: 1.2
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 50.0, bottom: 4.0),),
              Container(
                child: Text(
                  '© ${constants.APP_COMPANY_NAME} ${constants.APP_DATE}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

}