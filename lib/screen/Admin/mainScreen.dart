// ignore_for_file: file_names

import 'package:exam_system/constant/imageAssets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloCs/Admin/MainAdScreenBloC/cubit.dart';
import '../../bloCs/Admin/MainAdScreenBloC/states.dart';
import '../../constant/Dialogs.dart';
import '../../constant/constant.dart';
import '../../constant/sharedLayout.dart';
import '../../router/RoutePaths.dart';


class MainAdScreen extends StatelessWidget {
  const MainAdScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double fontSize = (size.width)/25;


    return WillPopScope(
      onWillPop: () async{
        final eDialog= await MyDialog.backToLoginDialog(context,"Do You Want to LogOut", RoutePaths.start);
        return eDialog??false;
      },
      child: SharedLayout(
        appBarTitle: "Exam System",
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
                  "Welcome Admin , You can Create New Test And View Student Grades.",
                  style: fixedHeadTextStyle(
                      font: fontSize-1,
                      weight: FontWeight.bold,family: "cairo"
                  )
              ),
            ),

            BlocProvider(
                create: (context) => MainAdScreenBloc(context),
                child: BlocConsumer<MainAdScreenBloc,MainAdScreenStates>(
                    listener: (context, state) {},
                    builder:  (context, state) {
                      var controller = MainAdScreenBloc.get(context);
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: (size.height)*.13
                          ),
                          width: buttonsHeightWidth(context, 0, .7)[0],

                          child: ListView.builder(
                            itemCount: controller.adminService.length,

                            itemBuilder: (context, index) {
                              return Container(
                                //alignment: Alignment.center,
                                margin:const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                width: buttonsHeightWidth(context, 0, .6)[0],
                                height: buttonsHeightWidth(context, .085, 0)[1] ,
                                child: DecoratedBox(
                                  decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: LinearGradient(
                                        colors: [
                                          ///Colors.yellowAccent,
                                          index != controller.adminService.length-1 ?
                                          appColor : Colors.grey,
                                          index != controller.adminService.length-1 ?
                                          appColor2 : Colors.grey.shade300,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )
                                  ),
                                  child: ElevatedButton(
                                    onPressed:() {
                                      controller.onClickService(index);
                                    },
                                    style: fixedButtonStyle(12,buttonColor: Colors.transparent,elevation: 0),
                                    child: Text(
                                      controller.adminService[index],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:  fontSize ,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Amiri'
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                )
            )
          ],
        ),
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