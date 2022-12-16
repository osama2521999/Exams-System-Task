// ignore_for_file: file_names
import 'package:exam_system/bloCs/Student/MainScreenBloC/states.dart';
import 'package:exam_system/constant/Widgets/customExamCard.dart';
import 'package:exam_system/constant/imageAssets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloCs/Student/MainScreenBloC/cubit.dart';
import '../../constant/Dialogs.dart';
import '../../constant/constant.dart';
import '../../constant/sharedLayout.dart';
import '../../model/LoginedUser.dart';
import '../../router/RoutePaths.dart';
import 'myExams.dart';

class MainScreen extends StatelessWidget {

  dynamic argument;

  MainScreen({Key? key,this.argument}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double fontSize = (size.width)/25;

    return WillPopScope(
      onWillPop: () async{
        final eDialog= await MyDialog.backToLoginDialog(context,"Do You Want to LogOut", RoutePaths.start);
        return eDialog??false;
      },
      child: BlocProvider(
        create: (context) => MainScreenBloc(context)..initial(argument['Screen index'])..getExams(),
        child: BlocConsumer<MainScreenBloc,MainScreenStates>(
          listener: (context, state) {},
          builder: (context, state) {

            var controller = MainScreenBloc.get(context);

            return SharedLayout(
              appBarTitle: "Exam System",
              body:Column(
                children: [
                  ListTile(
                    leading: Image.asset(ImageAssets.exam),
                    title: Text(
                      "Exams",
                      style: fixedHeadTextStyle(
                          font: fontSize-1,
                          weight: FontWeight.bold,
                          family: "cairo"
                      )
                    ),
                    subtitle: controller.currentIndex == 0?
                    Text(
                        "Welcome Our Student , You can test your self by get your Test.",
                        style: fixedHeadTextStyle(
                            font: fontSize-1,
                            weight: FontWeight.bold,family: "cairo"
                        )
                    ):
                    Text(
                        "${LoginedUser.name} ,this is your submitted Exams...",
                        style: fixedHeadTextStyle(
                            font: fontSize-1,
                            weight: FontWeight.bold,family: "cairo"
                        )
                    ),
                  ),

                  controller.currentIndex !=0 ? MyExams() :
                  controller.getData==false ?spinner(size) :
                  Expanded(
                    child: controller.exams.isNotEmpty?
                    ListView.builder(
                      itemCount: controller.exams.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            print(controller.exams[index]);
                            Navigator.of(context).pushNamed(
                                RoutePaths.doExam,
                                arguments:{'Exam':controller.exams[index]}
                            );
                          },
                          child: CustomExamCard(
                              content: "Click to Start Your Exam ...",
                              cardColor: appColor2,
                              title: controller.exams[index].title ,
                              description: controller.exams[index].subject,
                              // content: "content",
                              //time: controller.exams[index].time,
                              endRightHint: "Time : ${controller.exams[index].time} mm",
                              haveBadge: true,
                              badgePass: ImageAssets.exam,
                              badgeSize: 20,
                              cardSpace: 10,
                              cardRadius: 10,
                              shadowTic: 2
                          ),
                        );
                      },
                    ):
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(bottom: 40),
                      child: Text(
                          "No Exams Found yet !!",
                          style: fixedHeadTextStyle(
                              font: 16,
                              weight: FontWeight.bold,
                              family: "cairo",
                              color: appFontColor
                          )
                      ),
                    ),
                  )


                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: controller.currentIndex,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Exams',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.save),
                    label: 'Submitted Exams',
                  ),
                ],

                onTap: (index){
                  controller.changeIndex(index);
                },
              ),
            );
          },
        )
      ),
    );
  }

  Widget spinner(Size size){
    return SizedBox(
      width: size.width,
      height: (size.height)/1.8,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

}