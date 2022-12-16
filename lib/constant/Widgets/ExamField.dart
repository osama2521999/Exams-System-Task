import 'package:flutter/material.dart';

import '../constant.dart';

class ExamField extends StatelessWidget {

  String fieldHint = "";
  double? fieldWidth = 0  ;
  double? fieldHeight = 0 ;
  Color? fieldColor ;
  double? fontSize ;
  double? fieldRadius ;
  TextEditingController? controller ;
  EdgeInsetsGeometry? margin;
  TextInputType? keyboardType;
  bool? readOnly;

  ExamField({
    Key? key,
    required this.controller,
    required this.fieldHeight,
    required this.fieldWidth,
    required this.fieldHint,
    required this.fieldColor,
    required this.fontSize,
    this.fieldRadius,
    this.margin,
    this.keyboardType,
    this.readOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fieldWidth,
      height: fieldHeight,
      margin: margin,
      decoration: BoxDecoration(
        color: fieldColor ?? Colors.tealAccent,
        borderRadius:  BorderRadius.circular(fieldRadius ?? 32),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly ?? false,

        decoration: InputDecoration(
          hintStyle: fixedHeadTextStyle(
            font: fontSize,
            weight: FontWeight.bold,
            family: "cairo",
            color: Colors.grey.shade500
          ),
          hintText: fieldHint,
          //suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}
