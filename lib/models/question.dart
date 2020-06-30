import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_true_false/services/api.dart';
import '../services/constants.dart' as constants;
import 'package:html_unescape/html_unescape.dart';

class Question {

  int id;
  String description;
  int level;
  bool answer;

  static final String URL_GET_QUESTIONS = constants.BASE_URL + 'index.php/api/get_questions/';

  Question(this.id, this.description, this.level, this.answer);

  static Future getQuestions(BuildContext context, int level) async {
    List<Question> questions = [];
    questions = await _getQuestionFromServer(context, level);
    return questions;
  }

  static Future _getQuestionFromServer(BuildContext context, int level) async {
    List<Question> questions = [];
    await Api(context).getJsonFromServer(
        URL_GET_QUESTIONS + level.toString() + '/' + constants.QUESTION_NUMBER.toString()
        , null).then((map) {
      if (map != null) {
        if(map['data'] != null) {
          for (int i = 0; i < map['data'].length; i++) {
            Question question = Question.getFromMap(map['data'][i]);
            questions.add(question);
          }
        }
      }
    });
    return questions;
  }

  static Question getFromMap(Map item) {
    int id = int.parse(item['id']);
    String description = item['description'];
    int level = int.parse(item['level']);
    int answerValue = int.parse(item['answer']);
    bool answer = (answerValue > 0);

    Question question = Question(id, _parseHtmlString(description), level, answer);

    return question;
  }

  static String _parseHtmlString(String htmlString) {
    HtmlUnescape unescape = new HtmlUnescape();
    var text =  unescape.convert(htmlString);
    return text;
  }
}