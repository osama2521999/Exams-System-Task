
import 'package:exam_system/constant/imageAssets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloCs/signUpBloc/cubit.dart';
import '../bloCs/signUpBloc/states.dart';
import '../constant/CustomTools.dart';
import '../constant/constant.dart';


class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double fontSize = (size.width)/25;

    return Scaffold(
      //appBar: AppBar(title: const Text("Login")),


      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: CustomWaveClip(),
                child: Container(
                  width: size.width,
                  //height: 300,
                  height: (size.height)*.44,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ImageAssets.background3),
                          fit: BoxFit.fill
                      )
                  ),
                ),
              ),

              BlocProvider(
                create: (context) => SingUpBloc(context),
                child: BlocConsumer<SingUpBloc,SignUpStates>(
                  listener: (context, state) {},
                  builder: (context, state) {

                    var controller = SingUpBloc.get(context);

                    return Form(
                      key: controller.formKey ,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: (constFieldWidth(context,.6)/2)-5,
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child:  TextFormField(
                                  controller: controller.firstName,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Input First Name';
                                    }
                                    return null;
                                  },
                                  decoration: fixedInputDecoration("First Name",15.0,null),
                                ),
                              ),

                              const Padding(padding: EdgeInsets.only(right: 10)),

                              Container(
                                width: (constFieldWidth(context,.6)/2)-5,
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child:  TextFormField(
                                  controller: controller.lastName,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Input Last Name';
                                    }
                                    return null;
                                  },
                                  decoration: fixedInputDecoration("Last Name",15.0,null),
                                ),
                              ),
                            ],
                          ),

                          Container(
                            width: constFieldWidth(context,.6),
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child:  TextFormField(
                              controller: controller.userName,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Input Valid Text';
                                }
                                String p ="[a-zA-Z0-9\+\.\%\-\+]{1,256}"+"\\@"+"[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}"+"("+"\\."+"[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}"+")+";
                                RegExp regexp = RegExp(p);
                                if(regexp.hasMatch(value)){
                                  return null;
                                }
                                return "This is not valid Email";
                              },
                              decoration: fixedInputDecoration("Email",15.0,const Icon(Icons.email_outlined)),
                            ),
                          ),
                          Container(
                            width: constFieldWidth(context,.6),
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child:  TextFormField(
                              controller: controller.password,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Input Valid Text';
                                }
                                return null;
                              },
                              obscureText: controller.passMode,
                              decoration: fixedInputDecoration("Password",15.0,controller.seePass(controller.passMode,1)),
                            ),
                          ),
                          Container(
                            width: constFieldWidth(context,.6),
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child:  TextFormField(
                              controller: controller.confirmPassword,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Input Valid Text';
                                }
                                return null;
                              },
                              obscureText: controller.confirmPassMode,
                              decoration: fixedInputDecoration("Confirm Password",15.0,controller.seePass(controller.confirmPassMode,2)),
                            ),
                          ),

                          Container(
                            padding:const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            width: buttonsHeightWidth(context, 0, .6)[0],
                            height: buttonsHeightWidth(context, .08, 0)[1] ,
                            child: DecoratedBox(
                              decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: const LinearGradient(
                                    colors: [
                                      ///Colors.yellowAccent,
                                      Colors.blue,
                                      Color.fromRGBO(143, 148, 251, .6),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                              ),
                              child: ElevatedButton(
                                onPressed:() {

                                  if(controller.formKey.currentState!.validate()){
                                    controller.loading();
                                    //controller.singUp(controller.userName.value.text, controller.password.value.text);
                                  }

                                },
                                style: fixedButtonStyle(12,buttonColor: Colors.transparent,elevation: 0),
                                child: Text(
                                  "Sign Up",
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
      ),

    );
  }


}