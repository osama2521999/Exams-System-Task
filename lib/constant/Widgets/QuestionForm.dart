// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../model/Answer.dart';
import '../../model/Question.dart';
import '../constant.dart';

class QuestionForm extends StatefulWidget {

  String fieldHint = "";
  double? fieldWidth = 0  ;
  double? fieldHeight = 0 ;
  Color? formColor ;
  double? fontSize ;
  double? fieldRadius ;
  // TextEditingController? controller ;
  EdgeInsetsGeometry? margin;
  TextInputType? keyboardType;
  bool? readOnly;

  double? headerWidth = 0 ;
  double? gradeWidth = 0 ;
  double? questionWidth = 0 ;

  Question questionObject = Question.none();

  bool submitQuestion = false;

  QuestionForm({
    Key? key,
    //required this.controller,
    required this.fieldHeight,
    required this.fieldWidth,
    required this.fieldHint,
    required this.formColor,
    required this.fontSize,
    this.fieldRadius,
    this.margin,
    this.keyboardType,
    this.readOnly,

    required this.questionWidth,
    required this.headerWidth,
    required this.gradeWidth,
    required this.questionObject

  }) : super(key: key);

  @override
  State<QuestionForm> createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {

  TextEditingController h1 = TextEditingController();
  TextEditingController grade = TextEditingController();

  // TextEditingController q1 = TextEditingController();
  // TextEditingController q2 = TextEditingController();
  // TextEditingController q3 = TextEditingController();

  List<TextEditingController> q = [];
  List<bool> qCorrect = [];

  List<Answer> answers = [];

  @override
  void didUpdateWidget(covariant QuestionForm oldWidget) {
    // TODO: implement didUpdateWidget

    widget.submitQuestion = oldWidget.submitQuestion;
    widget.readOnly = oldWidget.readOnly;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // TODO: implement initState

    q = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ];

    qCorrect = [
      false,
      false,
      false,
      false,
      false,
    ];

    answers = [
      Answer(id: 1, text: q[0].value.text, correctAnswer: qCorrect[0]),
      Answer(id: 2, text: q[1].value.text, correctAnswer: qCorrect[1]),
      Answer(id: 3, text: q[2].value.text, correctAnswer: qCorrect[2]),
      Answer(id: 4, text: q[2].value.text, correctAnswer: qCorrect[2]),
      Answer(id: 5, text: q[2].value.text, correctAnswer: qCorrect[2]),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: widget.fieldWidth,
      height: widget.fieldHeight,
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.formColor ?? Colors.tealAccent,
        borderRadius:  BorderRadius.circular(widget.fieldRadius ?? 10),
      ),
      child: Column(
        children: [

          ///Header
          Row(
            children: [
              Container(
                width: widget.headerWidth,
                height: 50,
                margin: widget.margin,

                child: TextField(
                  controller: h1,
                  readOnly: widget.submitQuestion,
                  decoration: InputDecoration(
                    hintStyle: fixedHeadTextStyle(
                        font: widget.fontSize,
                        weight: FontWeight.bold,
                        family: "cairo",
                        color: Colors.grey.shade500
                    ),
                    hintText: "Question Header ...",
                  ),
                ),
              ),
              const Spacer(),

              Container(
                width: widget.gradeWidth,
                height: 50,
                margin: widget.margin,

                child: TextField(
                  controller: grade,
                  readOnly: widget.submitQuestion,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintStyle: fixedHeadTextStyle(
                        font: widget.fontSize,
                        weight: FontWeight.bold,
                        family: "cairo",
                        color: Colors.grey.shade500
                    ),
                    hintText: "Grade ...",
                  ),
                ),
              ),
              const Spacer(),

              !widget.submitQuestion ?
                IconButton(
                  icon: const Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  onPressed: () {

                    //widget.questionObject.id += 1;
                    print("Done True");

                    clickSubmit();

                  },
                ):
                const SizedBox(),
            ],
          ),

          ///Answers


          Container(
            //fit: FlexFit.tight,
            width: MediaQuery.of(context).size.width,
            //width: widget.questionWidth!+20,
            height: (widget.fieldHeight)!-90,
            margin: widget.margin,

            child: ListView.builder(

              itemCount: answers.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                      width: widget.questionWidth,
                      height: 50,
                      margin: widget.margin,
                      child: TextField(
                        controller: q[index],
                        readOnly: widget.submitQuestion,

                        decoration: InputDecoration(
                          hintStyle: fixedHeadTextStyle(
                            font: widget.fontSize,
                            weight: FontWeight.bold,
                            family: "cairo",
                            color: Colors.grey.shade500
                          ),
                          hintText: "q${index+1} ...",
                        ),
                      ),
                    ),
                    const Spacer(),
                    !widget.submitQuestion ?
                    Checkbox(
                      value: qCorrect[index],
                      onChanged: (value) {
                        setState(() {
                          qCorrect[index] = value!;
                        });
                      },
                    ):
                    const SizedBox(),
                  ],
                );
              },
            ),
          )

        ],
      ),
    );
  }

  void clickSubmit(){

    if(h1.value.text.isEmpty || grade.value.text.isEmpty
        || q.any((element) => element.value.text.isEmpty || !qCorrect.contains(true))){
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "Failed",
          text: "Add Question Content First",
          confirmBtnText: "ok",
          onConfirmBtnTap: (){
            Navigator.pop(context);
          }
      );
    }
    else{
      for(int i = 0 ; i<answers.length ; i++ ){
        answers[i] = Answer(
            id: answers[i].id,
            text: q[i].value.text,
            correctAnswer: qCorrect[i]
        );
      }

      widget.questionObject.header = h1.value.text;
      widget.questionObject.questionGrade = int.parse(grade.text != "" ? grade.value.text : "1");
      widget.questionObject.answers = answers;

      setState(() {
        widget.readOnly = true;
        widget.submitQuestion = true;
      });
    }
  }

}
