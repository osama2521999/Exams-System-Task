// ignore_for_file: file_names
import 'package:flutter/material.dart';

import 'CustomTools.dart';
import 'constant.dart';

// import 'DrawerMenu.dart';


class SharedLayout extends StatelessWidget {

  SharedLayout({
    Key? key,
    /*required*/ this.body,
    this.appBarTitle,
    this.floatingActionButton,
    this.extendBodyBehindAppBar,
    this.resizeToAvoidBottomInset,
    this.bottomNavigationBar
  }) : super(key: key);

  Widget? body;
  bool? extendBodyBehindAppBar = false;
  bool? resizeToAvoidBottomInset = true;
  //AppBar? appBar;
  String? appBarTitle;
  Widget? floatingActionButton;
  BottomNavigationBar? bottomNavigationBar;

  ///final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        //FocusScope.of(context).unfocus();
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(

        resizeToAvoidBottomInset: resizeToAvoidBottomInset,

        extendBodyBehindAppBar: extendBodyBehindAppBar ?? false,
        ///key: _scaffoldKey,
        //drawer: const DrawerMenu(),
        //appBar: appBar,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 105,
          title: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(appBarTitle ?? "Exam System",style: fixedHeadTextStyle(font: 24,family: 'cairo')),
          ),
          flexibleSpace: ClipPath(
            clipper: CustomCurveClip(),
            child: Container(
                decoration: const BoxDecoration(
                    gradient:  LinearGradient(
                      colors: [
                        appColor,
                        appColor2,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                )
            ),
          ),
        ),
        floatingActionButton: floatingActionButton,
        body: body,
        bottomNavigationBar: bottomNavigationBar,

      ),
    );
  }
}
