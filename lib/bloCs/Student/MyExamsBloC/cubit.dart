import 'package:exam_system/bloCs/Student/MyExamsBloC/states.dart';
import 'package:exam_system/model/LoginedUser.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/constant.dart';
import '../../../model/StudentDoExam.dart';


class MyExamsBloC extends Cubit<MyExamsStates>{

  MyExamsBloC(this.context) : super(InitialState());

  BuildContext context;

  static MyExamsBloC get(context) => BlocProvider.of(context);


  final referenceDatabase = FirebaseDatabase.instance;

  List<StudentDoExam> myExams =[];

  bool getData = false;


  void getMyExams() async{
    var value = await referenceDatabase.ref().child("Students").child(LoginedUser.uId).once();

    for (var element in value.snapshot.children) {
      myExams.add(
        StudentDoExam.fromJson2(
            Map<String, dynamic>.from(element.value as Map<dynamic, dynamic>)
        )
      );
    }

    getData=true;
    emit(GetStudentState());
  }


  Widget studentGrades(){
    if(myExams.isNotEmpty){
      List<TableRow> data = [
        ///header
        TableRow(
            children: [
              Text(
                "Exam Name",
                textAlign: TextAlign.center,
                style: fixedHeadTextStyle(
                  font: 18,
                  weight: FontWeight.bold,
                  family: "cairo",
                  color: appColor
                )
              ),
              Text(
                "My Score",
                textAlign: TextAlign.center,
                style: fixedHeadTextStyle(
                  font: 18,
                  weight: FontWeight.bold,
                  family: "cairo",
                  color: appColor
                )
              ),
              Text(
                "Total Score",
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

      for(var item in myExams){
        data.add(
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "- ${item.examName}",
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
                  "${item.studentGrade}",
                  style: fixedHeadTextStyle(
                    font: 16,
                    weight: FontWeight.bold,
                    family: "cairo",
                    color: appFontColor
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
        "${LoginedUser.name}, You don't submitted Exams yet !!",
          style: fixedHeadTextStyle(
            font: 16,
            weight: FontWeight.bold,
            family: "cairo",
            color: appFontColor
          )
      );
    }
  }



}