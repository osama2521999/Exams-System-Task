import 'package:exam_system/screen/Admin/ExamStudentGrade.dart';
import 'package:exam_system/screen/Admin/createExame.dart';
import 'package:exam_system/screen/Admin/mainScreen.dart';
import 'package:exam_system/screen/Admin/settings.dart';
import 'package:exam_system/screen/Admin/viewExam.dart';
import 'package:exam_system/screen/Student/examScreen.dart';
import 'package:flutter/material.dart';
import '../screen/login.dart';
import '../screen/Student/mainScreen.dart';
import '../screen/singup.dart';
import 'RoutePaths.dart';

class AppRouter{

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {

      case RoutePaths.start:
        return MaterialPageRoute(builder: (_) =>  const Login());

      case RoutePaths.signUp:
        return MaterialPageRoute(builder: (_) =>  const SignUp());

      case RoutePaths.mainScreen:
        return MaterialPageRoute(builder: (_) =>   MainScreen(argument: settings.arguments));

      case RoutePaths.mainAdminScreen:
        return MaterialPageRoute(builder: (_) =>   const MainAdScreen());

      case RoutePaths.settings:
        return MaterialPageRoute(builder: (_) =>  const Settings());

      case RoutePaths.createExam:
        return MaterialPageRoute(builder: (_) =>   const CreateExam());

      case RoutePaths.viewExams:
        return MaterialPageRoute(builder: (_) =>   const ViewExam());

      case RoutePaths.examStudentsGrade:
        return MaterialPageRoute(builder: (_) =>   ExamStudentsGrade(argument: settings.arguments));

      case RoutePaths.doExam:
        return MaterialPageRoute(builder: (_) =>   DoExam(argument: settings.arguments));


      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('${settings.name} still under developed'),
              ),
            )
        );
    }
  }

}