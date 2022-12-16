import 'package:exam_system/model/Exam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloCs/Admin/ExamStudentGradeBloC/cubit.dart';
import '../../bloCs/Admin/ExamStudentGradeBloC/states.dart';
import '../../constant/constant.dart';
import '../../constant/imageAssets.dart';
import '../../constant/sharedLayout.dart';

class ExamStudentsGrade extends StatelessWidget {

  dynamic argument;

  ExamStudentsGrade({Key? key,this.argument}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double fontSize = (size.width)/25;

    Exam exam = argument['Exam'] ;

    return SharedLayout(
      appBarTitle: "Exam System",

      // resizeToAvoidBottomInset : false,

      body:Column(
        children: [
          ListTile(
            leading: Image.asset(ImageAssets.exam),
            title: Text(
                "Admin",
                style: fixedHeadTextStyle(
                    font: fontSize-1,
                    weight: FontWeight.bold,family: "cairo"
                )
            ),
            subtitle: Text(
                "Students Grade at ${exam.title} Exam...",
                style: fixedHeadTextStyle(
                    font: fontSize-1,
                    weight: FontWeight.bold,family: "cairo"
                )
            ),
          ),

          BlocProvider(
              create: (context) => ExamStudentGradeBloc(context)..initial(argument['Exam'])..getStudent(),
              child: BlocConsumer<ExamStudentGradeBloc,ExamStudentGradeStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  var controller = ExamStudentGradeBloc.get(context);

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
                        child: !controller.getData ?
                          const Center(
                            child: CircularProgressIndicator(),
                          ):
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Align(
                                alignment: Alignment.topCenter,
                                child: Stack(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Exam",
                                        style: fixedHeadTextStyle(
                                            font: fontSize-1,
                                            weight: FontWeight.bold,family: "cairo"
                                        )
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      margin: const EdgeInsets.only(right: 10),
                                      child: Text(
                                          "Exam Grade = ${controller.exam.grade}",
                                          style: fixedHeadTextStyle(
                                              font: fontSize-1,
                                              weight: FontWeight.bold,
                                              family: "cairo",
                                              color: Colors.grey
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Text("${controller.students.length}"),

                              controller.students.isNotEmpty?
                              Container(
                                margin: const EdgeInsets.only(top: 70),
                                child: controller.studentGrades(),
                              ):
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(bottom: 40),
                                  child: controller.studentGrades(),
                                ),
                              )

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

