import 'package:exam_system/bloCs/Admin/CreateExamBloC/states.dart';
import 'package:exam_system/constant/Widgets/QuestionForm.dart';
import 'package:exam_system/model/Exam.dart';
import 'package:exam_system/model/Question.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../constant/Dialogs.dart';
import '../../../constant/constant.dart';


class CreateExamBloc extends Cubit<CreateExamStates>{

  CreateExamBloc(this.context) : super(InitialState());

  BuildContext context;

  static CreateExamBloc get(context) => BlocProvider.of(context);

  TextEditingController examTitle = TextEditingController();
  TextEditingController examTime = TextEditingController();

  final referenceDatabase = FirebaseDatabase.instance.ref().child("exams");

  List<Question> questions = [];

  //Question question = Question.none();

  List<Widget> questionList = [];

  Widget addQues(){

    if(questions.isEmpty){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.green,
            ),
            onPressed: () {
              if(questionList.isEmpty){
                questionList.add(
                  Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.green,
                            ),
                            onPressed: () => addNewQues(),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                                "Add Question",
                                style: fixedHeadTextStyle(
                                  font: 18,
                                  weight: FontWeight.bold,family: "cairo"
                                )
                            ),
                          )
                        ],
                      ),
                    )
                );
              }
              addNewQues();
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
                "Add Question",
                style: fixedHeadTextStyle(
                  font: 18,
                  weight: FontWeight.bold,family: "cairo"
                )
            ),
          )
        ],
      );
    }
    else{
      return SingleChildScrollView(
        child: Column(
          children: questionList,
        ),
      ) ;
    }

  }


  void addNewQues(){
    int index = (questions.length);
    questions.insert(
      index,
      Question.withId(id: index)
    );

    questionList.insert(
      index,
      QuestionForm(
        // controller: controller.h1,
        margin: const EdgeInsets.all(10),
        fontSize: 14,
        fieldHeight: (MediaQuery.of(context).size.height)*.5,
        fieldWidth: (MediaQuery.of(context).size.width)-10-20,
        fieldHint: 'sasd',
        formColor: Colors.white,
        questionObject: questions[index],

        questionWidth: constFieldWidth(context,.5),
        headerWidth: constFieldWidth(context,.5),
        gradeWidth: constFieldWidth(context,.12),
      ),
    );

    emit(AddNewQuesState());
  }


  void submitExam() async{

    if(questions.isEmpty || examTitle.value.text.isEmpty|| examTime.value.text.isEmpty){
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "Failed",
          text: "Add Exam Content First",
          confirmBtnText: "ok",
          onConfirmBtnTap: (){
            Navigator.pop(context);
          }
      );
    }
    else{
      if(questions.any((element) => element.answers.isEmpty)){
        QuickAlert.show(
            context: context,
            type: QuickAlertType.warning,
            title: "Warning",
            text: "Please Sure That All Questions Submitted",
            confirmBtnText: "ok",
            onConfirmBtnTap: (){
              Navigator.pop(context);
            }
        );
      }
      else{

        MyDialog.loadingDialog(context, size: MediaQuery.of(context).size);

        var examData = await referenceDatabase.get();

        int lastExamId = examData.children.length;

        int totalExamGrade = 0;

        for(var item in questions){
          totalExamGrade += item.questionGrade;
        }

        Exam exam = Exam(
            id: lastExamId+1,
            title: examTitle.value.text,
            time: examTime.value.text,
            subject: "test",
            grade: totalExamGrade,
            questions: questions
        );



        await referenceDatabase.child("${exam.id}").set(exam.toJson()).whenComplete(() {

          Navigator.pop(context);
          QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              barrierDismissible: false,
              title: "Success",
              text: "Exam Added Successfully",
              confirmBtnText: "ok",
              onConfirmBtnTap: (){
                examTitle.clear();
                examTime.clear();
                questions.clear();
                questionList.clear();
                Navigator.pop(context);
                emit(SubmitExamState());
              }
          );
        });

      }
    }

  }

}