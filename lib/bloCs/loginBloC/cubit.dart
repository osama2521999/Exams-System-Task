import 'package:bloc/bloc.dart';
import 'package:exam_system/bloCs/loginBloC/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/Dialogs.dart';
import '../../constant/constant.dart';
import '../../model/LoginedUser.dart';
import '../../router/RoutePaths.dart';

class LoginBloc extends Cubit<LoginStates>{

  LoginBloc(this.context) : super(InitialState());

  var context;

  static LoginBloc get(context) => BlocProvider.of(context);

  TextEditingController email = TextEditingController() ;
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;

  bool passMode = true;

  bool savedPass = false;


  Future<bool> login() async{


    try {

      UserCredential loginTest = await auth.signInWithEmailAndPassword(
          email: email.value.text, password: password.value.text
      );

      LoginedUser.uId=loginTest.user!.uid;
      LoginedUser.name=loginTest.user!.displayName ?? "admin";
      LoginedUser.email=email.value.text;
      LoginedUser.password=password.value.text;

      LoginedUser.photoUrl=loginTest.user!.photoURL ?? '' ;
      LoginedUser.user = auth.currentUser;

      return true;


    } on Exception catch (error) {

      debugPrint(error.toString());

      return false;

    }

  }


  Future<void> loading() async{

    MyDialog.loadingDialog(context, size: MediaQuery.of(context).size);

    bool loginTest = await login();

    if(loginTest){

      if(savedPass){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('UserName', email.value.text);
        prefs.setString('Password', password.value.text);
      }

      if(email.value.text == "admin@exam.com" || email.value.text == "admin@Exam.com"){

        Future.delayed( const Duration(seconds: 3), () {
          Navigator.pop(context); //popup dialog
          Navigator.of(context).pushNamed(
            RoutePaths.mainAdminScreen,
          );
        });

      }else{

        Future.delayed( const Duration(seconds: 3), () {
          Navigator.pop(context); //popup dialog
          Navigator.of(context).pushNamed(
              RoutePaths.mainScreen,
              arguments: {"userName":email.value.text}
          );
        });

      }

    }else{

      Future.delayed( const Duration(seconds: 3), () {
        Navigator.pop(context); //popup dialog

        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            barrierDismissible: false,
            title: "Failed Login",
            text: "Sure from Email or Password",
            confirmBtnText: "ok",
            onConfirmBtnTap: (){
              Navigator.pop(context);
            }
        );

      });

    }


  }


  Widget seePass(){
    if(!passMode){
      return IconButton(
        icon: const Icon(Icons.visibility,color: appThemColor),
        onPressed: () {
          passMode=!passMode;
          emit(SeenHidePassState());
        },
      );
    }else{
      return IconButton(
        icon: const Icon(Icons.visibility_off,color: appThemColor),
        onPressed: () {
          passMode=!passMode;
          emit(SeenHidePassState());
        },
      );
    }
  }

  Future<void> getSavedLogin() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("UserName")&&prefs.containsKey("Password")){
      email.text=prefs.getString('UserName')!;
      password.text=prefs.getString('Password')!;

      savedPass=true;
      emit(GetSavedPassState());
    }
  }

  void changeCheckbox(value) {
    savedPass=value!;
    emit(ChangeSavePassState());
  }

  ///this for setting //////////////

  TextEditingController oldPass = TextEditingController() ;
  TextEditingController newPass = TextEditingController();
  TextEditingController confirmNewPass = TextEditingController();

  bool passOldPassMode = true;
  bool passNewPassMode = true;
  bool passConfirmNewPassMode = true;

  Widget seeSettingPass(int index){

    if(index == 0){
      if(!passOldPassMode){
        return IconButton(
          icon: const Icon(Icons.visibility,color: appThemColor),
          onPressed: () {
            passOldPassMode=!passOldPassMode;
            emit(SeenHidePassState());
          },
        );
      }
      else{
        return IconButton(
          icon: const Icon(Icons.visibility_off,color: appThemColor),
          onPressed: () {
            passOldPassMode=!passOldPassMode;
            emit(SeenHidePassState());
          },
        );
      }
    }

    if(index == 1){
      if(!passNewPassMode){
        return IconButton(
          icon: const Icon(Icons.visibility,color: appThemColor),
          onPressed: () {
            passNewPassMode=!passNewPassMode;
            emit(SeenHidePassState());
          },
        );
      }
      else{
        return IconButton(
          icon: const Icon(Icons.visibility_off,color: appThemColor),
          onPressed: () {
            passNewPassMode=!passNewPassMode;
            emit(SeenHidePassState());
          },
        );
      }
    }

    if(index == 2){
      if(!passConfirmNewPassMode){
        return IconButton(
          icon: const Icon(Icons.visibility,color: appThemColor),
          onPressed: () {
            passConfirmNewPassMode=!passConfirmNewPassMode;
            emit(SeenHidePassState());
          },
        );
      }
      else{
        return IconButton(
          icon: const Icon(Icons.visibility_off,color: appThemColor),
          onPressed: () {
            passConfirmNewPassMode=!passConfirmNewPassMode;
            emit(SeenHidePassState());
          },
        );
      }
    }

    return Container();
  }

  void changePass() async{

    MyDialog.loadingDialog(context, size: MediaQuery.of(context).size);

    if(oldPass.value.text != LoginedUser.password){

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            barrierDismissible: false,
            title: "Failed",
            text: "Old Password is wrong",
            confirmBtnText: "ok",
            onConfirmBtnTap: (){
              Navigator.pop(context);
            }
        );

      });
    }else{

      if(newPass.value.text != confirmNewPass.value.text){
        Navigator.pop(context);
        QuickAlert.show(
            context: context,
            type: QuickAlertType.warning,
            barrierDismissible: false,
            title: "Warning",
            text: "Sure that new password and confirm is identical.",
            confirmBtnText: "ok",
            onConfirmBtnTap: (){
              Navigator.pop(context);
            }
        );
      }
      else{

        email.text = LoginedUser.email;
        password.text = oldPass.value.text;

        bool check = await login();

        if(check){
          await LoginedUser.user?.updatePassword(newPass.value.text);
          Navigator.pop(context);
          QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              barrierDismissible: false,
              title: "Success",
              text: "Password Change Successfully.",
              confirmBtnText: "ok",
              onConfirmBtnTap: (){
                oldPass.clear();
                newPass.clear();
                confirmNewPass.clear();
                Navigator.pop(context);
              }
          );
        }else{
          Navigator.pop(context);
          QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              barrierDismissible: false,
              title: "Error",
              text: "Failed to Change Password.",
              confirmBtnText: "ok",
              onConfirmBtnTap: (){
                Navigator.pop(context);
              }
          );
        }



      }

    }

  }

}