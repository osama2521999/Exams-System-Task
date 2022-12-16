// ignore_for_file: file_names
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:exam_system/router/RoutePaths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloCs/Student/DoExamBloC/cubit.dart';
import '../../bloCs/Student/DoExamBloC/states.dart';
import '../../constant/Dialogs.dart';
import '../../constant/Widgets/ExamField.dart';
import '../../constant/constant.dart';
import '../../constant/imageAssets.dart';
import '../../constant/sharedLayout.dart';

class DoExam extends StatelessWidget {

  dynamic argument;

  DoExam({Key? key,this.argument}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double fontSize = (size.width)/25;


    return WillPopScope(
      onWillPop: () async{
        final eDialog= await MyDialog.specificDialog(
            context,
            "Sure, You want to End Exam ?!",
            (){
              Navigator.pop(context);
              Navigator.pop(context);
            }
        );
        return eDialog??false;
      },

      child: SharedLayout(
        appBarTitle: "Exam System",

        // resizeToAvoidBottomInset : false,

        body:Column(
          children: [
            ListTile(
              leading: Image.asset(ImageAssets.exam),
              title: Text(
                "Exams",
                style: fixedHeadTextStyle(
                  font: fontSize-1,
                  weight: FontWeight.bold,family: "cairo"
                )
              ),
              subtitle: Text(
                "Try to End Exam Before Exam Time ...",
                style: fixedHeadTextStyle(
                  font: fontSize-1,
                  weight: FontWeight.bold,family: "cairo"
                )
              ),
            ),

            BlocProvider(
                create: (context) => DoExamBloc(context)..initial(argument['Exam']),
                child: BlocConsumer<DoExamBloc,DoExamStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    var controller = DoExamBloc.get(context);

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

                              Stack(
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
                                      "G= ${controller.exam.grade}",
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

                              Row(
                                children: [

                                  ExamField(
                                    controller: TextEditingController(text: controller.exam.title),
                                    readOnly: true,
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

                                  ///this will be timer

                                  CircularCountDownTimer(

                                    duration: int.parse(controller.exam.time)* 60,

                                    initialDuration: 0,

                                    controller: controller.timerController,
                                    width: constFieldWidth(context, .4),
                                    height: 50,
                                    ringColor: Colors.grey[300]!,
                                    ringGradient: null,
                                    //fillColor: Colors.purpleAccent[100]!,
                                    fillColor: appColor,
                                    fillGradient: null,
                                    //backgroundColor: Colors.purple[500],
                                    backgroundColor: appColor2,
                                    backgroundGradient: null,
                                    strokeWidth: 10.0,
                                    strokeCap: StrokeCap.round,
                                    textStyle: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textFormat: CountdownTextFormat.MM_SS,
                                    //isReverse: false,
                                    isReverse: true,
                                    isReverseAnimation: false,
                                    isTimerTextShown: true,
                                    autoStart: true,
                                    onStart: () {
                                      debugPrint('Countdown Started');
                                    },
                                    onComplete: () {
                                      controller.timeEnded();
                                      debugPrint('Countdown Ended');
                                    },
                                    onChange: (String timeStamp) {
                                      debugPrint('Countdown Changed $timeStamp');
                                    },

                                    timeFormatterFunction: (defaultFormatterFunction, duration) {
                                      if (duration.inSeconds == 0) {
                                        return "End";
                                      }
                                      else {
                                        return Function.apply(defaultFormatterFunction, [duration]);
                                      }
                                    },
                                  ),

                                ],
                              ),

                              /// this will be questions

                              Expanded(
                                child: Center(
                                  child: SingleChildScrollView(
                                    child: controller.getQuestions(),
                                  ),
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

      ),
    );
  }

}