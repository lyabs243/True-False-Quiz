import 'package:flutter/material.dart';
import 'package:flutter_app_true_false/components/main_button.dart';
import 'package:flutter_app_true_false/services/localizations.dart';

class LoadFailed extends StatelessWidget {

  Function tryAgain;

  LoadFailed(this.tryAgain);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(bottom: 40.0),),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 2,
              child: Image.asset(
                  'assets/logo.png'
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 6),),
            Container(
              child: Text(
                MyLocalizations.of(context).localization['failed_load_question'],
                textScaleFactor: 1.8,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10.0),),
            MainButton(
              MyLocalizations.of(context).localization['try_again'],
              this.tryAgain,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

}