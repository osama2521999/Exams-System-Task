import 'package:exam_system/model/LoginedUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloCs/Student/MyExamsBloC/cubit.dart';
import '../../bloCs/Student/MyExamsBloC/states.dart';
import '../../constant/constant.dart';
import '../../constant/imageAssets.dart';
import '../../constant/sharedLayout.dart';

class MyExams extends StatelessWidget {


  MyExams({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double fontSize = (size.width)/25;

    return BlocProvider(
        create: (context) => MyExamsBloC(context)..getMyExams(),
        child: BlocConsumer<MyExamsBloC,MyExamsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var controller = MyExamsBloC.get(context);

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
                                "Exams",
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
                                  "Exams Number= ${controller.myExams.length}",
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

                      controller.myExams.isNotEmpty?
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
    );
  }

}

