import 'dart:developer';

import 'package:exam_system/bloCs/Student/MainScreenBloC/states.dart';
import 'package:exam_system/model/Exam.dart';
import 'package:exam_system/model/LoginedUser.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MainScreenBloc extends Cubit<MainScreenStates>{

  MainScreenBloc(this.context) : super(InitialState());

  BuildContext context;

  static MainScreenBloc get(context) => BlocProvider.of(context);

  final referenceDatabase = FirebaseDatabase.instance;

  List<Exam> exams =[];

  bool getData = false;

  int currentIndex =0;

  void initial(int? screenIndex){
    currentIndex = screenIndex ?? 0;
  }


  void changeIndex(int index) {
    debugPrint(index.toString());
    currentIndex=index;
    emit(ChangeIndexState());
  }

  Future<void> getExams() async {

    var value = await referenceDatabase.ref().child("exams").once();

    for (var element in value.snapshot.children) {

      Map<dynamic, dynamic> data = element.value as Map<dynamic, dynamic>;


      bool checkUserSubmittedBefore =
          value.snapshot.child("${data["id"]}").child("Students").
          child(LoginedUser.uId).exists;

      if(!checkUserSubmittedBefore){
        exams.add(
            Exam.fromJson2(
                Map<String, dynamic>.from(data)
            )
        );
      }
    }

    getData=true;
    emit(GetExamsState());

    debugPrint('Exams : ${exams.length}');

  }


}