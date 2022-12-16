// ignore_for_file: file_names

class Answer {

  int id = 0;
  String text = "";
  bool correctAnswer = false;

  Answer(
      {required this.id,
        required this.text,
        required this.correctAnswer,
      });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    id: json["id"],
    text: json["text"],
    correctAnswer: json["correctAnswer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "correctAnswer": correctAnswer,
  };

}