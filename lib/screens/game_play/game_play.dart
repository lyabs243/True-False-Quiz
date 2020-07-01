import 'package:flutter/material.dart';
import 'package:flutter_app_true_false/components/layout_load.dart';
import 'package:flutter_app_true_false/components/quiz_page.dart';
import 'package:flutter_app_true_false/models/leaderboard.dart';
import 'package:flutter_app_true_false/models/question.dart';
import 'package:flutter_app_true_false/models/score.dart';
import 'package:flutter_app_true_false/models/settings.dart';
import 'package:flutter_app_true_false/models/user.dart';
import 'package:flutter_app_true_false/screens/game_play/components/dialog/dialog_answer_transition.dart';
import 'package:flutter_app_true_false/screens/game_play/components/dialog/dialog_finish_game.dart';
import 'package:flutter_app_true_false/screens/game_play/components/dialog/dialog_game_finished.dart';
import '../../services/constants.dart' as constants;
import 'components/dialog/dialog_want_exit.dart';
import 'components/game_play_body.dart';
import 'components/game_play_header.dart';
import 'components/layout_question_load_failed.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

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
  int level = 0, currentQuestionIndex = 0, lifes = constants.TOTAL_LIFES, points = 0;
  BuildContext _context;
  Question currentQuestion;
  AudioCache audioPlayer;
  AudioPlayer player;
  Settings _settings;

  @override
  void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if(player != null) {
      player.dispose();
    }
  }

  play() async {
    setState(() {
      level = 0;
      lifes = constants.TOTAL_LIFES;
      points = 0;
    });
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
    Settings.getInstance().then((value) {
      setState(() {
        _settings = value;
      });
    });
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: constants.QUESTION_TIME),
    );
    controller.addStatusListener((status) {
      if(status == AnimationStatus.dismissed) {
        setState(() {
          lifes--;
        });
        if (lifes > 0) {
          loadQuestion(false);
        }
        else {
          finishGame();
        }
      }
    });
    audioPlayer = AudioCache();
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
                      child: GamePlayHeader(this.exitGame, this.forceGameFinish, lifes: lifes,),
                      width: MediaQuery.of(context).size.width,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: (30.0 / 853) * MediaQuery.of(context).size.height),),
                    Container(
                      child: GamePlayBody(controller, currentQuestion, this.onAnswerClicked, this.points),
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
      if(_settings != null && _settings.audioEnable) {
        player = await audioPlayer.play('audio/correct-choice.wav');
      }
      setState(() {
        points += constants.QUESTION_POINTS[level];
      });
      //load another question
      loadQuestion(true);
    }
    else {
      if(_settings != null && _settings.audioEnable) {
        player = await audioPlayer.play('audio/wrong-choice.wav');
      }
      setState(() {
        lifes--;
      });
      if (lifes > 0) {
        loadQuestion(false);
      }
      else {
        finishGame();
      }
    }
  }

  void loadQuestion(bool isCorrect) {
    if(currentQuestionIndex < questions.length) {
      setState(() {
        currentQuestion = questions[currentQuestionIndex++];
      });
      showTransition(isCorrect).then((value) {
        controller.reverse(from: double.parse(constants.QUESTION_TIME.toString()));
      });
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

  Future showTransition(bool isCorrect) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => DialogAnswerTransition(isCorrect: isCorrect,),
    );
  }

  Future finishGame() async {
    //save result
    Score.addLastResult(new Score(points));
    //add score to leaderboard manager
    User.getInstance().then((_user) {
      if (_user.id.length > 0) {
        LeaderBoard.addGameResult(context, _user.id, points);
      }
    });
    if(_settings != null && _settings.audioEnable) {
      player = await audioPlayer.play('audio/game-over.wav');
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => DialogGameFinished(this.points),
    ).then((value) {
      if (value) { //try again
        play();
      }
      else { //go home
        Navigator.pop(context);
      }
    });
  }

  Future forceGameFinish() async {
    controller.stop();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => DialogFinishGame(this.points),
    ).then((value) {
      if (value) { //try again
        finishGame();
      }
      else { //go home
        controller.reverse(from: controller.value);
      }
    });
  }

  Future exitGame() async {
    controller.stop();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => DialogWantExit(),
    ).then((value) {
      if (value) { //try again
        Navigator.pop(context);
      }
      else { //go home
        controller.reverse(from: controller.value);
      }
    });
  }

}