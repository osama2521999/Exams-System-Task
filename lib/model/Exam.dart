// ignore_for_file: file_names

import 'package:exam_system/model/Answer.dart';

import 'Question.dart';

class Exam {

  int id = 0;
  String title = "";
  String subject = "";
  String time = "";
  int grade = 0;
  List<Question> questions = [];

  Exam(
    {required this.id,
      required this.title,
      required this.subject,
      required this.time,
      required this.grade,
      required this.questions,
    });

  Exam.none();

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
    id: json["id"],
    title: json["title"],
    subject: json["subject"],
    time: json["time"],
    grade: json["grade"],
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
  );

  Exam.fromJson2(Map<String, dynamic> json) {
    id = json["id"];
    title =  json["title"] ;
    subject =  json["subject"] ;
    time =  json["time"] ;
    grade =  json["grade"] ;
    //questions = json["questions"] as List<Question> ;
    for(var item in json["questions"]){

      print(item);

      List<Answer> ans = [];

      for(var item2 in item['answers']){
        Answer answer = Answer(
          id: item2['id'],
          text: item2['text'],
          correctAnswer: item2['correctAnswer']
        );
        ans.add(answer);
      }
      Question question = Question(
        id: item['id'],
        header: item['header'],
        questionGrade: item['questionGrade'] ?? 1,
        answers: ans
      );
      questions.add(question);
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "subject": subject,
    "time": time,
    "grade": grade,
    //"questions": questions,
    "questions": questions.map((item) => item.toJson()).toList(),
  };

}