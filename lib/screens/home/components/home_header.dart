import 'package:flutter/material.dart';
import 'package:flutter_app_true_false/components/button_circle.dart';
import 'package:flutter_app_true_false/models/user.dart';
import 'package:flutter_app_true_false/services/localizations.dart';
import '../../../services/constants.dart' as constants;

class HomeHeader extends StatelessWidget {

  User currentUser;
  Function actionSignOut, actionShare, actionRatingApp, actionSettings;

  HomeHeader(this.currentUser, this.actionSignOut, this.actionSettings, this.actionRatingApp, this.actionShare);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        (constants.USING_SERVER)?
        Container(
          height: (40.0 / 853) * MediaQuery.of(context).size.height,
          child: new RaisedButton(
            onPressed: () {
              this.actionSignOut();
            },
            highlightColor: Colors.green[700],
            child: SizedBox(
              child: Text(
                (currentUser != null && currentUser.id.length > 0)?
                MyLocalizations.of(context).localization['sign_out']:
                MyLocalizations.of(context).localization['sign_in'],
                textAlign: TextAlign.center,
                style: new TextStyle(color: Colors.white, fontSize: (18.0 / 853) * MediaQuery.of(context).size.height),
              ),
              width: MediaQuery.of(context).size.width * 25 / 100,
            ),
            color: Theme.of(context).primaryColor,
            elevation: 10.0,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
                side: BorderSide(color: Theme.of(context).primaryColor, width: 2.0)
            ),
          ),
        ): Container(),
        Container(
          child: ButtonCircle(
              Icon(
                Icons.share,
                size: (25.0 / 853) * MediaQuery.of(context).size.height,
                color: Colors.white,
              ),
              () {
                this.actionShare();
              },
            fillColor: Theme.of(context).primaryColor,
          ),
          width: (MediaQuery.of(context).size.width * 70 / 100) / 5,
        ),
        Container(
          child: ButtonCircle(
              Icon(
                Icons.star,
                size: (25.0 / 853) * MediaQuery.of(context).size.height,
                color: Colors.white,
              ),
              () {
                this.actionRatingApp();
              },
            fillColor: Theme.of(context).primaryColor,
          ),
          width: (MediaQuery.of(context).size.width * 70 / 100) / 5,
        ),
        Container(
          child: ButtonCircle(
              Icon(
                Icons.settings,
                size: (25.0 / 853) * MediaQuery.of(context).size.height,
                color: Colors.white,
              ),
              () {
                this.actionSettings();
              },
            fillColor: Theme.of(context).primaryColor,
          ),
          width: (MediaQuery.of(context).size.width * 70 / 100) / 5,
        )
      ],
    );
  }

}