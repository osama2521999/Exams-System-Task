import 'package:exam_system/bloCs/Admin/ViewExamBloC/states.dart';
import 'package:exam_system/model/Exam.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class ViewExamBloc extends Cubit<ViewExamStates>{

  ViewExamBloc(this.context) : super(InitialState());

  BuildContext context;

  static ViewExamBloc get(context) => BlocProvider.of(context);

  final referenceDatabase = FirebaseDatabase.instance;

  List<Exam> exams =[];

  bool getData = false;

  int currentIndex =0;


  void changeIndex(int index) {
    debugPrint(index.toString());
    currentIndex=index;
    emit(ChangeIndexState());
  }

  Future<void> getExams() async {

    var value = await referenceDatabase.ref().child("exams").once();

    for (var element in value.snapshot.children) {
      exams.add(
        Exam.fromJson2(
          Map<String, dynamic>.from(element.value as Map<dynamic, dynamic>)
        )
      );
    }

    getData=true;
    emit(GetExamsState());

    debugPrint('Exams : ${exams.first.title}');
    debugPrint('Exams : ${exams.length}');

  }


}