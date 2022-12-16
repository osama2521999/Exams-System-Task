import 'package:exam_system/bloCs/Admin/MainAdScreenBloC/states.dart';
import 'package:exam_system/router/RoutePaths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/Dialogs.dart';


class MainAdScreenBloc extends Cubit<MainAdScreenStates>{

  MainAdScreenBloc(this.context) : super(InitialState());

  BuildContext context;

  static MainAdScreenBloc get(context) => BlocProvider.of(context);

  List<String> adminService = [
    RoutePaths.createExam,
    RoutePaths.viewExams,
    RoutePaths.settings,
    "Log Out",
  ];

  void onClickService(int index){
    if(index == adminService.length-1){
      MyDialog.backToLoginDialog(context,"Do You Want to LogOut", RoutePaths.start);
    }else{
      Navigator.of(context).pushNamed(
          adminService[index]
      );
    }
  }




}