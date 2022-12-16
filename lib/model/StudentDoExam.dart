
class StudentDoExam {

  int examId = 0;
  String examName = "";
  int examGrade = 0;
  String studentId = "";
  String studentName = "";
  int studentGrade = 0;


  StudentDoExam(
      {required this.examId,
        required this.examName,
        required this.examGrade,
        required this.studentId,
        required this.studentName,
        required this.studentGrade,
      });

  StudentDoExam.none();

  factory StudentDoExam.fromJson(Map<String, dynamic> json) => StudentDoExam(
    examId: json["examId"],
    examName: json["examName"],
    examGrade: json["examGrade"],
    studentId: json["studentId"],
    studentName: json["studentName"],
    studentGrade: json["studentGrade"],
  );

  StudentDoExam.fromJson2(Map<String, dynamic> json) {
    examId =  json["examId"] ;
    examName =  json["examName"] ?? "" ;
    examGrade =  json["examGrade"] ;
    studentId = json["studentId"];
    studentName =  json["studentName"] ;
    studentGrade =  json["studentGrade"] ;
  }

  Map<String, dynamic> toJson() => {
    "examId": examId,
    "examName": examName,
    "examGrade": examGrade,
    "studentId": studentId,
    "studentName": studentName,
    "studentGrade": studentGrade,
  };

}