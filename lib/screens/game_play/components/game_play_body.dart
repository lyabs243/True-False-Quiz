import 'package:flutter/material.dart';
import 'package:flutter_app_true_false/components/countdown_timer.dart';
import 'package:flutter_app_true_false/models/question.dart';
import 'package:admob_flutter/admob_flutter.dart';
import '../../../services/constants.dart' as constants;
import '../../../services/config.dart' as config;

class GamePlayBody extends StatelessWidget {

  AnimationController controller;
  Question currentQuestion;
  int points = 0;
  Function onAnswerClicked;
  AdmobBanner admobBanner;

  GamePlayBody(this.controller, this.currentQuestion, this.onAnswerClicked, this.points, this.admobBanner);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: (600 / 853) * MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              '$points',
              textScaleFactor: 2.0,
              style: TextStyle(
                  color: Colors.red
              ),
            ),
          ),
          //Padding(padding: EdgeInsets.only(bottom: (30.0 / 853) * MediaQuery.of(context).size.height),),
          Container(
            height: MediaQuery.of(context).size.width / 5,
            width: MediaQuery.of(context).size.width / 5,
            child: CountDownTimer(this.controller),
          ),
          (constants.SHOW_ADMOB)?
          Container(
            child: admobBanner,
          ): Container(),
          //Padding(padding: EdgeInsets.only(bottom: (40.0 / 853) * MediaQuery.of(context).size.height),),
          Container(
            child: Text(
              currentQuestion.description,
              textScaleFactor: 1.8,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black
              ),
            ),
          ),
          //Padding(padding: EdgeInsets.only(bottom: (40.0 / 853) * MediaQuery.of(context).size.height),),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width/2.3,
                    child: Image.asset(
                        'assets/icons/icon_check.png'
                    ),
                  ),
                  onTap: () {
                    this.onAnswerClicked(true);
                  },
                ),
                InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width/2.3,
                    child: Image.asset(
                        'assets/icons/icon_cancel.png'
                    ),
                  ),
                  onTap: () {
                    this.onAnswerClicked(false);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}