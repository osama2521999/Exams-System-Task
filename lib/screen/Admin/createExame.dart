// ignore_for_file: file_names
import 'package:exam_system/bloCs/Admin/CreateExamBloC/cubit.dart';
import 'package:exam_system/bloCs/Admin/CreateExamBloC/states.dart';
import 'package:exam_system/constant/Widgets/ExamField.dart';
import 'package:exam_system/constant/imageAssets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constant/constant.dart';
import '../../constant/sharedLayout.dart';

class CreateExam extends StatelessWidget {
  const CreateExam({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double fontSize = (size.width)/25;


    return SharedLayout(
      appBarTitle: "Exam System",

      // resizeToAvoidBottomInset : false,

      body:Column(
        children: [
          ListTile(
            leading: Image.asset(ImageAssets.examAd),
            title: Text(
                "Exams",
                style: fixedHeadTextStyle(
                    font: fontSize-1,
                    weight: FontWeight.bold,family: "cairo"
                )
            ),
            subtitle: Text(
                "Create New Exam.",
                style: fixedHeadTextStyle(
                    font: fontSize-1,
                    weight: FontWeight.bold,family: "cairo"
                )
            ),
          ),

          BlocProvider(
              create: (context) => CreateExamBloc(context),
              child: BlocConsumer<CreateExamBloc,CreateExamStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  var controller = CreateExamBloc.get(context);

                  return Expanded(
                    child: SizedBox(
                      width: (size.width)-10,
                      child: Card(
                        elevation: 100,
                        color: const Color.fromRGBO(248, 236, 234, 1.0),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Text(
                              "Create Exam",
                              style: fixedHeadTextStyle(
                                font: fontSize-1,
                                weight: FontWeight.bold,family: "cairo"
                              )
                            ),

                            Row(
                              children: [

                                ExamField(
                                  controller: controller.examTitle,
                                  fieldWidth: constFieldWidth(context, .4),
                                  fieldHeight: 50,
                                  fieldHint: "Exam Title",
                                  fieldColor: Colors.white,
                                  fontSize: 16,
                                  fieldRadius: 10,
                                  margin: const EdgeInsets.only(
                                    top: 25,
                                    left: 10
                                  ),
                                ),

                                const Spacer(),

                                ExamField(
                                  controller: controller.examTime,
                                  keyboardType: TextInputType.number,
                                  fieldWidth: constFieldWidth(context, .4),
                                  fieldHeight: 50,
                                  fieldHint: "Exam Time : mm",
                                  fieldColor: Colors.white,
                                  fontSize: 16,
                                  fieldRadius: 10,
                                  margin: const EdgeInsets.only(
                                    top: 25,
                                    right: 10
                                  ),
                                ),


                              ],
                            ),

                            /// this for add Questions
                            // Expanded(
                            //   child: Center(
                            //     child: SingleChildScrollView(
                            //       child: Column(
                            //         children: [
                            //           QuestionForm(
                            //             // controller: controller.h1,
                            //             margin: const EdgeInsets.all(10),
                            //             fontSize: 14,
                            //             fieldHeight: 300,
                            //             fieldWidth: (size.width)-10-20,
                            //             fieldHint: 'sasd',
                            //             formColor: Colors.white,
                            //             questionObject: controller.question,
                            //
                            //             questionWidth: constFieldWidth(context,.5),
                            //             headerWidth: constFieldWidth(context,.5),
                            //             gradeWidth: constFieldWidth(context,.12),
                            //
                            //
                            //           ),
                            //           QuestionForm(
                            //             // controller: controller.examTitle,
                            //             margin: const EdgeInsets.all(10),
                            //             fontSize: 14,
                            //             fieldHeight: 300,
                            //             fieldWidth: (size.width)-10-20,
                            //             fieldHint: 'sasd',
                            //             formColor: Colors.white,
                            //             questionObject: controller.question,
                            //
                            //             questionWidth: constFieldWidth(context,.5),
                            //             headerWidth: constFieldWidth(context,.5),
                            //             gradeWidth: constFieldWidth(context,.12),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Expanded(
                              child: Center(
                                child: controller.addQues(),
                              ),
                            ),

                            Container(
                              //alignment: Alignment.center,
                              margin:const EdgeInsets.fromLTRB(0, 12, 0, 15),
                              width: buttonsHeightWidth(context, 0, .6)[0],
                              height: buttonsHeightWidth(context, .05, 0)[1] ,
                              child: DecoratedBox(
                                decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: const LinearGradient(
                                    colors: [
                                      ///Colors.yellowAccent,
                                      appColor,
                                      appColor2,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                ),
                                child: ElevatedButton(
                                  onPressed:() {
                                    controller.submitExam();
                                  },
                                  style: fixedButtonStyle(12,buttonColor: Colors.transparent,elevation: 0),
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:  fontSize ,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Amiri'
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
          )
        ],
      ),

    );
  }

}