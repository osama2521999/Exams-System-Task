// ignore_for_file: file_names
import 'package:badges/badges.dart';
import 'package:exam_system/constant/constant.dart';
import 'package:flutter/material.dart';

class CustomExamCard extends StatelessWidget {

  bool haveBadge = false;
  String badgePass = "";
  double badgeSize = 0;
  String title = "";
  String description = "";
  String content = "";
  String endRightHint = "";
  double cardSpace = 0;
  double cardRadius = 0;
  double shadowTic = 0;
  Color? cardColor ;
  Color? shadowColor ;
  Widget? icon ;

  void Function()? removeCard;


  CustomExamCard(
      {
        Key? key,
        required this.title,
        required this.description,
        required this.content,
        required this.endRightHint,
        required this.haveBadge,
        required this.badgePass,
        required this.badgeSize,
        required this.cardSpace,
        required this.cardRadius,
        required this.shadowTic,
        this.cardColor,
        this.shadowColor,
        this.icon,

        this.removeCard,
      }
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(bottom: cardSpace),
      child: Badge(
        showBadge: haveBadge,
        badgeColor: Colors.transparent,
        elevation: 0,
        // padding: const EdgeInsets.only(right: 25),
        badgeContent: Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.only(),
          child: GestureDetector(
            onTap: removeCard,
            child: Image.asset(
              badgePass,
              width: badgeSize,
              height: badgeSize,
            ),
          ),
        ),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cardRadius),
            ),
            color: cardColor,
            shadowColor: shadowColor,
            elevation: shadowTic,
            child: SizedBox(
              width: (size.width)-20,
              height: 100,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: fixedHeadTextStyle(
                          color: Color(lightGrey),
                          font: 14,
                          family: "Lemonada",
                          weight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        description,
                        style: fixedHeadTextStyle(
                          color: Color(lightGrey),
                          font: 14,
                          family: "Cairo",
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      alignment: Alignment.center,
                      height: 120,
                      width: size.width-120,
                      child: Text(
                        ///"Click to Start Your Exam ...",
                        content,
                        style: fixedHeadTextStyle(
                          font: 16,
                          family: "Cairo",
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        //"Time : $time mm",
                        endRightHint,
                        style: fixedHeadTextStyle(
                            color: Color(lightGrey),
                            font: 16,
                            family: "Cairo",
                            weight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: icon,
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
