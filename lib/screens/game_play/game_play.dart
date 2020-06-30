import 'package:flutter/material.dart';
import 'package:flutter_app_true_false/components/layout_load.dart';
import 'package:flutter_app_true_false/components/quiz_page.dart';
import 'package:flutter_app_true_false/models/question.dart';
import '../../services/constants.dart' as constants;
import 'components/game_play_body.dart';
import 'components/game_play_header.dart';
import 'components/layout_question_load_failed.dart';

class GamePlay extends StatefulWidget {

  @override
  _GamePlayState createState() {
    return _GamePlayState();
  }

}

class _GamePlayState extends State<GamePlay>  with TickerProviderStateMixin, WidgetsBindingObserver {

  List<Question> questions = [];
  bool isLoading = false;
  AnimationController controller;
  int level = 0, currentQuestionIndex = 0;
  BuildContext _context;
  Question currentQuestion;

  @override
  void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  play() async {
    level = 0;
    initData();
  }

  initData() async {
    await Future.delayed(Duration.zero);
    _context = context;
    initQuestions();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: constants.QUESTION_TIME),
    );
    controller.addStatusListener((status) {
      if(status == AnimationStatus.dismissed) {

      }
    });
    play();
  }

  Future initQuestions({transition: false}) async {
    currentQuestionIndex = 0;
    setState(() {
      isLoading = true;
    });
    Question.getQuestions(_context, level).then((value) {
      questions = value;
      setState(() {
        isLoading = false;
      });
      if (questions.length > 0) {
        setState(() {
          currentQuestion = questions[currentQuestionIndex++];
        });
        controller.reverse(from: double.parse(constants.QUESTION_TIME.toString()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              decoration: QuizPage.quizDecoration(),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: (isLoading)?
              LayoutLoad():
              ((questions.length > 0)?
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 40.0),),
                    Container(
                      child: GamePlayHeader(),
                      width: MediaQuery.of(context).size.width,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: (30.0 / 853) * MediaQuery.of(context).size.height),),
                    Container(
                      child: GamePlayBody(controller, currentQuestion, this.onAnswerClicked),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 80 / 100,
                    )
                  ],
                ),
              ):
              LoadFailed(() {
                setState(() {
                  isLoading = true;
                });
                initQuestions();
              })),
            ),
          ),
        ),
        onWillPop: () {

        });
  }

  void onAnswerClicked(bool answer) async {
    controller.stop();
    if (currentQuestion.answer == answer && controller.value > 0) {
      //load another question
      if(currentQuestionIndex < questions.length) {
        setState(() {
          currentQuestion = questions[currentQuestionIndex++];
        });
        controller.reverse(from: double.parse(constants.QUESTION_TIME.toString()));
      }
      else {
        if(level < 2) {
          setState(() {
            level += 1;
            initQuestions(transition: true);
          });
        }
        else {
          //return to level 0 and continue iteration
          setState(() {
            level = 0;
            initQuestions(transition: true);
          });
        }
      }
    }
  }

}