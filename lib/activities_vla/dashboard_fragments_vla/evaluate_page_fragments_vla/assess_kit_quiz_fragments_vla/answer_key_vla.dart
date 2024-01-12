import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/evaluate_page_fragments_vla/assess_kit_quiz_fragments_vla/assess_kit_fragment_vla.dart';

import '../../../../constants_vla/constant_values_vla.dart';
import '../../../../main.dart';
import '../../../../translation_vla/tr.dart';
import '../../../../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import 'mcq_fragment_vla.dart';

class AnswerKeyVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  AnswerKeyVLA(this.thisSetNewScreenFunc, {Key? key}) : super(key: key);

  @override
  State<AnswerKeyVLA> createState() => _AnswerKeyVLAState();
}

class _AnswerKeyVLAState extends State<AnswerKeyVLA> {
  double heighIs = 0, widthIs = 0;
  List<Widget> listOfRightAnswers = [];


  @override
  void initState() {
    for (int i = 0; i < assessKitsListMCQFragment.length; i++) {
      Color borderColor = ConstantValuesVLA.splashBgColor;
      int rightAnswer = int.parse(assessKitsListMCQFragment[i].RightAnswer);
      int userAnswer = int.parse(assessKitsListMCQFragment[i].userAnswer);
      //print(assessKitsListMCQFragment[i].RightAnswer);
      //print(assessKitsListMCQFragment[i].userAnswer);
      List<String> optionsList = [
        "",
        assessKitsListMCQFragment[i].Option1,
        assessKitsListMCQFragment[i].Option2,
        assessKitsListMCQFragment[i].Option3,
        assessKitsListMCQFragment[i].Option4,
      ];
      Widget yourAnswerRightAnswerWidget = Container();
      String wrongRightSkippedImage = "";
      if (userAnswer == 0) {
        // SKIPPED ANSWER SKIPPED ANSWER SKIPPED ANSWER SKIPPED ANSWER
        // SKIPPED ANSWER SKIPPED ANSWER SKIPPED ANSWER SKIPPED ANSWER
        // SKIPPED ANSWER SKIPPED ANSWER SKIPPED ANSWER SKIPPED ANSWER
        borderColor = Colors.orangeAccent;
        wrongRightSkippedImage = "assets/skipped_question.png";
        yourAnswerRightAnswerWidget = Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.5),borderRadius: BorderRadius.circular(6),),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*Text(
                TR.youSkippedThisQuestion[languageIndex],
                style: const TextStyle(
                  color: Colors.orangeAccent,
                ),
              ),*/

              Row(

                children: [
                  TextCustomVidwath(
                    textTCV: TR.correct_answer[languageIndex],
                    textColorTCV: Colors.green,
                    fontSizeTCV: 12,
                  ),
                  TextCustomVidwath(
                    textTCV: " :  ",
                    textColorTCV: Colors.green,
                    fontSizeTCV: 12,
                  ),
                  Flexible(
                    child: HtmlWidget(
                      optionsList[rightAnswer],
                      textStyle: TextStyle(
                          fontSize: 12, color: ConstantValuesVLA.blackTextColor,),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8,),
              Row(
                children: [
                  TextCustomVidwath(
                    textTCV: TR.your_answer[languageIndex],
                    textColorTCV: Colors.orangeAccent,
                    fontSizeTCV: 12,
                  ),
                  TextCustomVidwath(
                    textTCV: " :  ",
                    textColorTCV: Colors.orangeAccent,
                    fontSizeTCV: 12,
                  ),
                  Flexible(
                    child: HtmlWidget(
                      "------",
                      textStyle: TextStyle(
                          fontSize: 12, color: ConstantValuesVLA.blackTextColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      } else if (userAnswer == rightAnswer) {
        // CORRECT ANSWER CORRECT ANSWER CORRECT ANSWER CORRECT ANSWER
        // CORRECT ANSWER CORRECT ANSWER CORRECT ANSWER CORRECT ANSWER
        // CORRECT ANSWER CORRECT ANSWER CORRECT ANSWER CORRECT ANSWER
        borderColor = Colors.green;
        wrongRightSkippedImage = "assets/answered_right.png";
        yourAnswerRightAnswerWidget = Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.5),borderRadius: BorderRadius.circular(6),),
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*TextCustomVidwath(
                textTCV: TR.youAnsweredThisCorrectly[languageIndex],
                textColorTCV: Colors.lightGreen,
              ),*/
              Row(
                children: [
                  TextCustomVidwath(
                    textTCV: TR.your_answer[languageIndex],
                    textColorTCV: Colors.green,
                    fontSizeTCV: 12,
                  ),
                  TextCustomVidwath(
                    textTCV: " :  ",
                    textColorTCV: Colors.green,
                  ),
                  Flexible(
                    child: HtmlWidget(
                      optionsList[rightAnswer],
                      textStyle: TextStyle(
                          fontSize: 12, color: ConstantValuesVLA.blackTextColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      } else if (userAnswer != rightAnswer) {
        // WRONG ANSWER WRONG ANSWER WRONG ANSWER WRONG ANSWER WRONG ANSWER
        // WRONG ANSWER WRONG ANSWER WRONG ANSWER WRONG ANSWER WRONG ANSWER
        // WRONG ANSWER WRONG ANSWER WRONG ANSWER WRONG ANSWER WRONG ANSWER
        borderColor = Colors.redAccent;
        wrongRightSkippedImage = "assets/answered_wrong.png";
        yourAnswerRightAnswerWidget = Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.5),borderRadius: BorderRadius.circular(6),),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*TextCustomVidwath(
                textTCV: TR.answerWasIncorrect[languageIndex],
                textColorTCV: Colors.redAccent,
              ),*/
              Row(

                children: [
                  TextCustomVidwath(
                    textTCV: TR.correct_answer[languageIndex],
                    textColorTCV: Colors.green,
                    fontSizeTCV: 12,
                  ),
                  TextCustomVidwath(
                    textTCV: " :  ",
                    textColorTCV: Colors.green,
                    fontSizeTCV: 12,
                  ),
                  Flexible(
                    child: HtmlWidget(
                      optionsList[rightAnswer],
                      textStyle: TextStyle(
                          fontSize: 12, color: ConstantValuesVLA.blackTextColor),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8,),
              Row(
                children: [
                  TextCustomVidwath(
                    textTCV: TR.your_answer[languageIndex],
                    textColorTCV: Colors.red,
                    fontSizeTCV: 12,
                  ),
                  TextCustomVidwath(
                    textTCV: " :  ",
                    textColorTCV: Colors.red,
                    fontSizeTCV: 12,
                  ),
                  Flexible(
                    child: HtmlWidget(
                      optionsList[userAnswer],
                      textStyle: TextStyle(
                          fontSize: 12, color: ConstantValuesVLA.blackTextColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
      listOfRightAnswers.add(Container(
        margin: const EdgeInsets.all(18),
        padding: const EdgeInsets.all(18),
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(blurRadius: 5, color: Colors.grey, offset: Offset(3, 3))
            ],
            borderRadius: BorderRadius.all(Radius.circular(6))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DividerCustomVidwath(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextCustomVidwath(
                  textTCV: TR.question_no_1[languageIndex] +
                      " " +
                      (i + 1).toString(),
                  textColorTCV: Colors.blue,
                  fontSizeTCV: 14,
                  fontWeightTCV: FontWeight.bold,
                ),
                Image.asset(
                  wrongRightSkippedImage,
                  width: 27,
                  height: 27,
                ),
              ],
            ),
            DividerCustomVidwath(),
            Align(
              alignment: Alignment.centerLeft,
              child: HtmlWidget(
                assessKitsListMCQFragment[i].Question,
                textStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500),
              ),
            ),
            DividerCustomVidwath(),
            yourAnswerRightAnswerWidget,
            DividerCustomVidwath(),
          ],
        ),
      ));
      setState(() {
        listOfRightAnswers;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    heighIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Image.asset(
          "assets/app_bg_main.png",
          height: heighIs,
          width: widthIs,
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: TextCustomVidwath(
              textTCV: topicName,
            ),
            backgroundColor: Color.fromRGBO(255, 255, 255, .8),
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: 36,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SafeArea(
              child: SizedBox(
            width: widthIs,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: listOfRightAnswers,
              ),
            ),
          )),
        ),
      ],
    );
  }
}
