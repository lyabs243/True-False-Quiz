import 'package:flutter/material.dart';
import 'package:flutter_app_true_false/services/localizations.dart';

class DialogWantExit extends StatelessWidget {

  BuildContext _context;

  DialogWantExit();


  @override
  Widget build(BuildContext context) {
    _context = context;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return WillPopScope(
      child: Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                MyLocalizations.of(context).localization['exit_game'],
                style: TextStyle(
                  fontSize: (24.0 / 853) * MediaQuery.of(context).size.height,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
                ),
              ),
              SizedBox(height: (30.0 / 853) * MediaQuery.of(context).size.height),
              Text(
                '${MyLocalizations.of(context).localization['progress_will_loss']}',
                textAlign: TextAlign.center,
                textScaleFactor: 1.2,
                style: TextStyle(
                  fontSize: (16.0 / 853) * MediaQuery.of(context).size.height,
                  color: Colors.white
                ),
              ),
              SizedBox(height: (24.0 / 853) * MediaQuery.of(context).size.height),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(_context).pop(false);
                      },
                      child: Text(
                        MyLocalizations.of(context).localization['continue_playing'],
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(_context).pop(true);
                      },
                      child: Text(
                        MyLocalizations.of(context).localization['exit'],
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),//...top circlular image part,
      ],
    ),
      onWillPop: () {

      },
    );
  }

}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}