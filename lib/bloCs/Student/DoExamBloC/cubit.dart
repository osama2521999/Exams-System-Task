import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:exam_system/bloCs/Student/DoExamBloC/states.dart';
import 'package:exam_system/model/Answer.dart';
import 'package:exam_system/model/Exam.dart';
import 'package:exam_system/model/LoginedUser.dart';
import 'package:exam_system/model/Question.dart';
import 'package:exam_system/model/StudentDoExam.dart';
import 'package:exam_system/router/RoutePaths.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../constant/Dialogs.dart';
import '../../../constant/constant.dart';


class DoExamBloc extends Cubit<DoExamStates>{

  DoExamBloc(this.context) : super(InitialState());

  BuildContext context;

  static DoExamBloc get(context) => BlocProvider.of(context);

  Exam exam = Exam.none();
  List<bool?> rightQusAnswer = [];
  List<List<bool>> qus_Ans_rightAnswer = [];

  CountDownController timerController = CountDownController();

  final referenceDatabase = FirebaseDatabase.instance;

  int userGrade = 0;

  void initial(Exam exam){
    this.exam = exam;
    rightQusAnswer = List.filled(exam.questions.length, null);

    ///
    for(var item in exam.questions){
      List<bool> ans = List.filled(item.answers.length, false);
      qus_Ans_rightAnswer.add(ans);
    }
  }

  Widget getQuestions(){

    int qIndex = 0 ;

    Column column = Column(children: [],);
    for(var item in exam.questions){
      column.children.add(
        answer(item,qIndex),
      );
      qIndex++;
    }
    return column;
  }

  void submitExam() async{


    if(rightQusAnswer.contains(null)){

      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        title: "Warning",
        text: "Please Answer All Question",
        confirmBtnText: "ok",
        onConfirmBtnTap: (){
          Navigator.pop(context);
        }
      );

    }else{

      MyDialog.loadingDialog(context, size: MediaQuery.of(context).size);MyDialog.loadingDialog(context, size: MediaQuery.of(context).size);

      calcUserGrade();

      await submitUser().whenComplete(() {
        Navigator.pop(context);
        Navigator.of(context).pushNamedAndRemoveUntil(
          RoutePaths.mainScreen,
          arguments: {"Screen index":1},
          (route) => false
        );
      });

      print("done");
    }

  }


  Widget answer(Question question,int qIndex){

    return Container(
      width: (MediaQuery.of(context).size.width)-10-20,
      height: (MediaQuery.of(context).size.height)*.5,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white ,
        borderRadius:  BorderRadius.circular( 10),
      ),
      child: Column(
        children: [

          ///Header
          Row(
            children: [
              Container(
                width: constFieldWidth(context,.5),
                height: 50,
                margin: const EdgeInsets.all(10),
                child: TextField(
                  //textAlign: TextAlign.center,
                  controller: TextEditingController(
                      text: "q : ${question.header}  ?"
                  ),
                  style: fixedHeadTextStyle(
                    font: 18,
                    weight: FontWeight.bold,
                    family: "cairo",
                    color: Colors.red
                  ),
                  readOnly: true,
                ),
              ),
              const Spacer()
            ],
          ),

          ///Answers

          Container(
            width: MediaQuery.of(context).size.width,
            height: ((MediaQuery.of(context).size.height)*.5)-90,
            margin: const EdgeInsets.all(10),

            child: ListView.builder(
              itemCount: question.answers.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                      width: constFieldWidth(context,.5),
                      height: 50,
                      margin: const EdgeInsets.all(10),
                      child: TextField(
                        controller: TextEditingController(
                            text: "${index+1} . ${question.answers[index].text}"
                        ),
                        readOnly: true,
                        style: fixedHeadTextStyle(
                          font: 16,
                          weight: FontWeight.bold,
                          family: "cairo",
                          color: Colors.black
                        ),

                        decoration: InputDecoration(
                          hintStyle: fixedHeadTextStyle(
                              font: 16,
                              weight: FontWeight.bold,
                              family: "cairo",
                              color: Colors.grey.shade500
                          ),
                          hintText: "q${index+1} ...",
                        ),
                      ),
                    ),
                    const Spacer(),

                    Checkbox(
                      //value: answerChoice[index],
                      shape: const CircleBorder(),
                      value: qus_Ans_rightAnswer[qIndex][index],
                      onChanged: (value) {
                        choice(value!, index, qIndex,question.answers[index]);
                      },
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );

  }

  void choice(bool value,int index,int qIndex,Answer answer){
    qus_Ans_rightAnswer[qIndex] = List.filled(qus_Ans_rightAnswer[qIndex].length, false);
    qus_Ans_rightAnswer[qIndex][index] = value;

    if(qus_Ans_rightAnswer[qIndex][index]){
      rightQusAnswer[qIndex]=answer.correctAnswer;
    }else{
      rightQusAnswer[qIndex] = null;
    }

    print("rightQusAnswer[$qIndex] = ${rightQusAnswer[qIndex]}");

    emit(ChoiceAnswerState());
  }

  void calcUserGrade(){
    userGrade =0;
    for(int i = 0 ; i<rightQusAnswer.length ; i++){
      if(rightQusAnswer[i] != null && rightQusAnswer[i]!){
        userGrade += exam.questions[i].questionGrade;
      }
    }
  }

  Future<void> submitUser() async{

    StudentDoExam studentExam = StudentDoExam(
        examId: exam.id,
        examName: exam.title,
        examGrade: exam.grade,
        studentId: LoginedUser.uId,
        studentName: LoginedUser.name,
        studentGrade: userGrade
    );

    final refUser = referenceDatabase.ref();

    await refUser.child("Students").child(LoginedUser.uId).child("${exam.id}").set(
        studentExam.toJson()
    );

    await refUser.child("exams").child("${exam.id}").child("Students").child(LoginedUser.uId).set(
        studentExam.toJson()
    );

  }


  void timeEnded() async{

    calcUserGrade();

    await submitUser().whenComplete(() {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.info,
          title: "Unfortunately",
          text: "Exam Time was Ended",
          confirmBtnText: "ok",
          onConfirmBtnTap: (){
            Navigator.pop(context);
            Navigator.of(context).pushNamedAndRemoveUntil(
                RoutePaths.mainScreen,
                arguments: {"Screen index":1},
                    (route) => false
            );
          }
      );
    });


  }

}