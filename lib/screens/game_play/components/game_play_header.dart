import 'package:flutter/material.dart';
import 'package:flutter_app_true_false/components/button_circle.dart';
import 'package:flutter_app_true_false/services/localizations.dart';

class GamePlayHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: ButtonCircle(
              Icon(
                Icons.arrow_back,
                size: (25.0 / 853) * MediaQuery.of(context).size.height,
                color: Colors.white,
              ),
              () {
                //this.onExitGame();
              }
          ),
          width: (MediaQuery.of(context).size.width * 65 / 100) / 5,
        ),
        Container(
          height: (40.0 / 853) * MediaQuery.of(context).size.height,
          child: new RaisedButton(
            onPressed: () {},
            highlightColor: Colors.green[700],
            child: SizedBox(
              child: Text(
                MyLocalizations.of(context).localization['finish_game'],
                textAlign: TextAlign.center,
                style: new TextStyle(color: Colors.white, fontSize: (18.0 / 853) * MediaQuery.of(context).size.height),
              ),
              width: MediaQuery.of(context).size.width * 20 / 100,
            ),
            color: Theme.of(context).primaryColor,
            elevation: 10.0,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
                side: BorderSide(color: Theme.of(context).primaryColor, width: 2.0)
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.favorite,
                color: Colors.red,
                size: (35.0 / 853) * MediaQuery.of(context).size.height,
              ),
            ),
            Container(
              child: Icon(
                Icons.favorite,
                color: Colors.red,
                size: (35.0 / 853) * MediaQuery.of(context).size.height,
              ),
            ),
            Container(
              child: Icon(
                Icons.favorite,
                color: Colors.red,
                size: (35.0 / 853) * MediaQuery.of(context).size.height,
              ),
            ),
          ],
        )
      ],
    );
  }

}