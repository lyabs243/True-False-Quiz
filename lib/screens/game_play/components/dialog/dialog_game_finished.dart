import 'package:flutter/material.dart';
import 'package:flutter_app_true_false/services/localizations.dart';
import '../../../../services/constants.dart' as constants;
import 'package:admob_flutter/admob_flutter.dart';
import '../../../../services/config.dart' as config;

class DialogGameFinished extends StatelessWidget {

  int points = 0;
  BuildContext _context;
  AdmobBanner admobBanner;
  AdmobInterstitial interstitialAd;
  bool playAgain = true;

  DialogGameFinished(this.points) {
    if(constants.SHOW_ADMOB) {
      interstitialAd = AdmobInterstitial(
        adUnitId: config.ADMOB_INTERSTITIAL_ID,
        listener: (AdmobAdEvent event, Map<String, dynamic> args) async {
          if (event == AdmobAdEvent.closed ||
              event == AdmobAdEvent.failedToLoad) {
            Navigator.of(_context).pop(playAgain);
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    if(constants.SHOW_ADMOB) {
      interstitialAd.isLoaded.then((value) {
        if (!value) {
          interstitialAd.load();
        }
      });
      admobBanner = AdmobBanner(
        adUnitId: config.ADMOB_BANNER_ID,
        adSize: AdmobBannerSize.LARGE_BANNER,
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {},
      );
    }
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
                MyLocalizations.of(context).localization['game_over'],
                style: TextStyle(
                  fontSize: (24.0 / 853) * MediaQuery.of(context).size.height,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
                ),
              ),
              SizedBox(height: (30.0 / 853) * MediaQuery.of(context).size.height),
              (constants.SHOW_ADMOB)?
              Container(
                child: admobBanner,
              ): Container(),
              SizedBox(height: (30.0 / 853) * MediaQuery.of(context).size.height),
              Container(
                height: MediaQuery.of(context).size.height / 6,
                child: Image.asset(
                  'assets/ic_achieve.png'
                ),
              ),
              SizedBox(height: (30.0 / 853) * MediaQuery.of(context).size.height),
              Text(
                '${MyLocalizations.of(context).localization['finish_you_got']}'
                    ' $points ${MyLocalizations.of(context).localization['points']} !',
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
                        playAgain = false;
                        if(constants.SHOW_ADMOB) {
                          interstitialAd.show();
                        }
                        else {
                          Navigator.of(_context).pop(playAgain);
                        }
                      },
                      child: Text(
                        MyLocalizations.of(context).localization['go_home'],
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        playAgain = true;
                        if(constants.SHOW_ADMOB) {
                          interstitialAd.show();
                        }
                        else {
                          Navigator.of(_context).pop(playAgain);
                        }
                      },
                      child: Text(
                        MyLocalizations.of(context).localization['play_again'],
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