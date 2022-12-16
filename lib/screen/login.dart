import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloCs/loginBloC/cubit.dart';
import '../bloCs/loginBloC/states.dart';
import '../constant/CustomTools.dart';
import '../constant/constant.dart';
import '../constant/imageAssets.dart';
import '../router/RoutePaths.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);


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
                  //color: Colors.orange,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ImageAssets.background),
                          fit: BoxFit.fill
                      )
                  ),
                ),
              ),

              const Padding(padding: EdgeInsets.only(top: 10)),

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

                          Container(
                            width: constFieldWidth(context,.6),
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child:  TextFormField(
                              controller: controller.email,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Input Valid Text';
                                }
                                RegExp regexp = RegExp(emailFormat);
                                if(regexp.hasMatch(value)){
                                  return null;
                                }
                                return "This is not valid Email";
                              },
                              decoration: fixedInputDecoration("Email",15.0,null),
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
                              decoration: fixedInputDecoration("Password",15.0,controller.seePass()),
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.fromLTRB((size.width)*.2, 5, 0, 0),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Save Password",
                                  style: fixedHeadTextStyle(font: fontSize-1,weight: FontWeight.bold,family: "cairo"),
                                ),
                                Checkbox(
                                  value: controller.savedPass,
                                  onChanged: (value) =>controller.changeCheckbox(value),
                                  activeColor: appThemColor,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(RoutePaths.signUp);
                                    },
                                    child: Text(
                                      "Sign up",
                                      style:  TextStyle(
                                        fontFamily: "cairo",
                                        color: appThemColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize-1,
                                      ),
                                    )
                                ),
                                Text(
                                  "If You not have account ",
                                  style: fixedHeadTextStyle(font: fontSize,weight: FontWeight.bold,family: 'cairo'),
                                ),
                              ],
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
                                      appColor,
                                      appColor2,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                              ),
                              child: ElevatedButton(
                                onPressed:() {
                                  if(controller.formKey.currentState!.validate()){
                                    controller.loading();
                                  }
                                },
                                style: fixedButtonStyle(12,buttonColor: Colors.transparent,elevation: 0),
                                child: Text(
                                  "login",
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
