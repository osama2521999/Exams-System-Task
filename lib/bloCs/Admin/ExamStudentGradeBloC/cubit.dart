import 'package:exam_system/bloCs/Admin/ExamStudentGradeBloC/states.dart';
import 'package:exam_system/model/Exam.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/constant.dart';
import '../../../model/StudentDoExam.dart';


class ExamStudentGradeBloc extends Cubit<ExamStudentGradeStates>{

  ExamStudentGradeBloc(this.context) : super(InitialState());

  BuildContext context;

  static ExamStudentGradeBloc get(context) => BlocProvider.of(context);

  Exam exam = Exam.none();


  final referenceDatabase = FirebaseDatabase.instance;

  List<StudentDoExam> students =[];

  bool getData = false;


  void initial(Exam exam){
    this.exam = exam;

  }

  void getStudent() async{
    var value = await referenceDatabase.ref().child("exams").child("${exam.id}").child("Students").once();

    for (var element in value.snapshot.children) {
      students.add(
        StudentDoExam.fromJson2(
            Map<String, dynamic>.from(element.value as Map<dynamic, dynamic>)
        )
      );
    }

    getData=true;
    emit(GetStudentState());
  }


  Widget studentGrades(){
    if(students.isNotEmpty){
      List<TableRow> data = [
        ///header
        TableRow(
            children: [
              Text(
                "Student",
                textAlign: TextAlign.center,
                style: fixedHeadTextStyle(
                  font: 18,
                  weight: FontWeight.bold,
                  family: "cairo",
                  color: appColor
                )
              ),
              Text(
                "Score",
                textAlign: TextAlign.center,
                style: fixedHeadTextStyle(
                  font: 18,
                  weight: FontWeight.bold,
                  family: "cairo",
                  color: appColor
                )
              ),
            ]
        ),
      ];

      for(var item in students){
        data.add(
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "- ${item.studentName}",
                  style: fixedHeadTextStyle(
                    font: 16,
                    weight: FontWeight.bold,
                    family: "cairo",
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${item.examGrade}",
                  style: fixedHeadTextStyle(
                    font: 16,
                    weight: FontWeight.bold,
                    family: "cairo",
                    color: appFontColor
                  )
                ),
              ),
            ]
          ),
        );
      }

      return SizedBox(
        width: (MediaQuery.of(context).size.width)-80,
        child: Table(
          border: TableBorder.all(
            color: Colors.black,
            borderRadius: BorderRadius.circular(4)
          ),
          children: data,
        ),
      );
    }
    else{
      return Text(
        "No Student Submitted This Exam yet !!",
          style: fixedHeadTextStyle(
            font: 18,
            weight: FontWeight.bold,
            family: "cairo",
            color: appFontColor
          )
      );
    }
  }



}