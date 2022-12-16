// ignore_for_file: file_names

import 'package:exam_system/constant/imageAssets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloCs/Admin/ViewExamBloC/cubit.dart';
import '../../bloCs/Admin/ViewExamBloC/states.dart';
import '../../constant/Widgets/customExamCard.dart';
import '../../constant/constant.dart';
import '../../constant/sharedLayout.dart';
import '../../router/RoutePaths.dart';

class ViewExam extends StatelessWidget {
  const ViewExam({Key? key}) : super(key: key);


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
                "Choice Exam to See Student Grades.",
                style: fixedHeadTextStyle(
                    font: fontSize-1,
                    weight: FontWeight.bold,family: "cairo"
                )
            ),
          ),

          BlocProvider(
              create: (context) => ViewExamBloc(context)..getExams(),
              child: BlocConsumer<ViewExamBloc,ViewExamStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  var controller = ViewExamBloc.get(context);

                  return controller.currentIndex !=0 ? Container() :
                  controller.getData==false ?spinner(size) :
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.exams.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            print(controller.exams[index]);
                            Navigator.of(context).pushNamed(
                                RoutePaths.examStudentsGrade,
                                arguments:{'Exam':controller.exams[index]}
                            );
                          },
                          child: CustomExamCard(
                              content: "Click to See Students Grades ...",
                              cardColor: appColor2,
                              title: controller.exams[index].title ,
                              description: controller.exams[index].subject,
                              // content: "content",
                              endRightHint: "Total Grade : ${controller.exams[index].grade}",
                              haveBadge: true,
                              badgePass: ImageAssets.exam,
                              badgeSize: 20,
                              cardSpace: 10,
                              cardRadius: 10,
                              shadowTic: 2
                          ),
                        );
                      },
                    ),
                  );
                },
              )
          ),
        ],
      ),

    );
  }

  Widget spinner(Size size){
    return SizedBox(
      width: size.width,
      height: (size.height)/1.5,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }


}