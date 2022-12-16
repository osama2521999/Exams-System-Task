// ignore_for_file: file_names

import 'package:exam_system/model/Answer.dart';

class Question {

  int id = 0;
  String header = "";
  int questionGrade = 0;
  List<Answer> answers = [];

  Question(
    {required this.id,
      required this.header,
      required this.questionGrade,
      required this.answers,
    });

  Question.none();
  Question.withId({
    required this.id,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    header: json["header"],
    questionGrade: json["questionGrade"],
    answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
  );

  Question.fromJson2(Map<String, dynamic> json) {
    id = json["id"];
    header =  json["header"] ;
    questionGrade =  json["questionGrade"] ;
    for(var item in json["answers"]){
      answers.add(Answer.fromJson(item));
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "header": header,
    "questionGrade": questionGrade,
    //"answers": answers,
    "answers": answers.map((item) => item.toJson()).toList(),
  };

}