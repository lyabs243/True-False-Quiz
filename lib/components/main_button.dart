import 'package:flutter/material.dart';

class MainButton extends StatelessWidget{

  String title;
  String textLeft;
  TextAlign textAlign;
  Function buttonAction;
  Color buttonColor;

  MainButton(this.title, this.buttonAction, {this.textAlign: TextAlign.left, this.textLeft: '',
    this.buttonColor: Colors.black});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 75 / 100,
            height: 50.0,
            child: new RaisedButton(
              onPressed: () {
                this.buttonAction();
              },
              highlightColor: Colors.green[700],
              child: //Row(
                //children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 68 / 100,
                    child: RichText(
                      textAlign: this.textAlign,
                      text: new TextSpan(
                        children: [
                          (this.textLeft.isNotEmpty)?
                          new TextSpan(
                            text: this.textLeft,
                            style: new TextStyle(color: Colors.yellow,fontSize: (20.0 / 853) * MediaQuery.of(context).size.height),
                          ): TextSpan(),
                          TextSpan(text: '    '),
                          new TextSpan(
                            text: this.title,
                            style: new TextStyle(color: Colors.white, fontSize: (18.0 / 853) * MediaQuery.of(context).size.height),
                          ),
                        ],
                      ),
                    ),
                  ),
                //],
              //),
              color: this.buttonColor,
              elevation: 10.0,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                  side: BorderSide(color: Theme.of(context).primaryColor, width: 2.0)
              ),
            ),
          ),
        ],
      ),
    );
  }

}