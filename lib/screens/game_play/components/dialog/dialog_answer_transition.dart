import 'package:flutter/material.dart';

class DialogAnswerTransition extends StatelessWidget {

  bool isCorrect;

  DialogAnswerTransition({this.isCorrect: true});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    //wait some times before close the dialog
    dialogWait(context);
    return WillPopScope(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width/2.3,
          child: Image.asset(
            (this.isCorrect)?
            'assets/icons/icon_check.png':
            'assets/icons/icon_cancel.png'
          ),
        ),
      ),
      onWillPop: () {},
    );
  }

  Future dialogWait(BuildContext context) async {
    await new Future.delayed(Duration(milliseconds: 600));
    Navigator.pop(context);
  }

}