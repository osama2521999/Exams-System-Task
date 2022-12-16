// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloCs/loginBloC/cubit.dart';
import '../../bloCs/loginBloC/states.dart';
import '../../constant/constant.dart';
import '../../constant/imageAssets.dart';
import '../../constant/sharedLayout.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double fontSize = (size.width)/25;


    return SharedLayout(
      appBarTitle: "Exam System",
      body:SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: Image.asset(ImageAssets.examAd),
              title: Text(
                  "Admin",
                  style: fixedHeadTextStyle(
                      font: fontSize-1,
                      weight: FontWeight.bold,family: "cairo"
                  )
              ),
              subtitle: Text(
                  "Welcome Admin , You can Change Your Password.",
                  style: fixedHeadTextStyle(
                      font: fontSize-1,
                      weight: FontWeight.bold,family: "cairo"
                  )
              ),
            ),

            BlocProvider(
              create: (context) => LoginBloc(context)..getSavedLogin(),
              child: BlocConsumer<LoginBloc,LoginStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  var controller = LoginBloc.get(context);

                  return Form(
                    key: controller.formKey ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Padding(
                          padding: EdgeInsets.all((size.width)*.1),
                        ),
                        
                        Container(
                          width: constFieldWidth(context,.7),
                          margin: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                          child:  TextFormField(
                            controller: controller.oldPass,
                            obscureText: controller.passOldPassMode,
                            decoration: fixedInputDecoration(
                                "Old Password",
                                15.0,
                                controller.seeSettingPass(0)
                            ),
                          ),
                        ),
                        Container(
                          width: constFieldWidth(context,.7),
                          margin: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                          child:  TextFormField(
                            controller: controller.newPass,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: controller.passNewPassMode,
                            decoration: fixedInputDecoration(
                              "New Password",
                              15.0,
                              controller.seeSettingPass(1)
                            ),
                          ),
                        ),
                        Container(
                          width: constFieldWidth(context,.7),
                          margin: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                          child:  TextFormField(
                            controller: controller.confirmNewPass,
                            obscureText: controller.passConfirmNewPassMode,
                            decoration: fixedInputDecoration(
                                "Confirm New Password",
                                15.0,
                                controller.seeSettingPass(2)
                            ),
                          ),
                        ),



                        Container(
                          padding:const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          width: buttonsHeightWidth(context, 0, .7)[0],
                          height: buttonsHeightWidth(context, .08, 0)[1] ,
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
                                controller.changePass();
                              },
                              style: fixedButtonStyle(12,buttonColor: Colors.transparent,elevation: 0),
                              child: Text(
                                "Change Password",
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
                  );

                },
              ),
            ),
          ],
        ),
      ),
    );
  }



}