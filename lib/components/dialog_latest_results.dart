import 'package:flutter/material.dart';
import 'package:flutter_app_true_false/models/score.dart';
import 'package:flutter_app_true_false/services/localizations.dart';

class DialogLatestResults extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _DialogLatestResultsState();
  }

}
class _DialogLatestResultsState extends State<DialogLatestResults> {

  List<Score> latestResults = [];
  bool hasLoadScores = false;
  List<Widget> columnChildren = [];

  @override
  void initState() {
    super.initState();
    getWidgets().then((value) {
      setState(() {
        columnChildren = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
      child: Container(
        width: MediaQuery.of(context).size.width * 70 / 100,
        padding: EdgeInsets.only(
          top: Consts.padding,
          bottom: Consts.padding,
          left: Consts.padding,
          right: Consts.padding,
        ),
        decoration: new BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.rectangle,
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(Consts.padding),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: columnChildren,
            ),
          ],
        ),
      ),
      onWillPop: () {

      },
    );
  }

  Future<List<Widget>> getWidgets() async {
    latestResults = await Score.getLatestResults();
    List<Widget> widgets = [];

    widgets.add(SizedBox(height: (16.0 / 853) * MediaQuery.of(context).size.height));
    widgets.add(Text(
      MyLocalizations.of(context).localization['latest_results'],
      textAlign: TextAlign.center,
      textScaleFactor: 2.2,
      style: TextStyle(
          fontSize: (16.0 / 853) * MediaQuery.of(context).size.height,
          color: Colors.white
      ),
    ));
    widgets.add(SizedBox(height: (16.0 / 853) * MediaQuery.of(context).size.height));

    latestResults.reversed.forEach((element) {
      widgets.add(Container(
        width: MediaQuery.of(context).size.width * 70 /100,
        padding: EdgeInsets.only(top: (8.0 / 853) * MediaQuery.of(context).size.height, bottom: (8.0 / 853) * MediaQuery.of(context).size.height),
        child: Text(
          '${element.value}',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: (30.0 / 853) * MediaQuery.of(context).size.height
          ),
        ),
      ));
    });

    widgets.add(SizedBox(height: (24.0 / 853) * MediaQuery.of(context).size.height));
    widgets.add(
        Align(
          alignment: Alignment.bottomRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(); // To close the dialog
                },
                child: Text(
                  MyLocalizations.of(context).localization['close'],
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              )
            ],
          ),
        )
    );

    return widgets;
  }

}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}