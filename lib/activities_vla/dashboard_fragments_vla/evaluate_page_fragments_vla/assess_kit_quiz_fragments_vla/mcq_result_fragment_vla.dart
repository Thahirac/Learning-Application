import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:http/http.dart' as http;
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/evaluate_page_fragments_vla/assess_kit_quiz_fragments_vla/quiz_fragment_vla.dart';

import '../../../../constants_vla/constant_values_vla.dart';
import '../../../../main.dart';
import '../../../../translation_vla/tr.dart';
import '../../../../vidwath_custom_widgets/button_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import '../../evaluate_dash_vla.dart';
import 'answer_key_vla.dart';
import 'assess_kit_fragment_vla.dart';
import 'mcq_fragment_vla.dart';

class MCQResultFragmentVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  MCQResultFragmentVLA(this.thisSetNewScreenFunc, {Key? key});

  @override
  State<MCQResultFragmentVLA> createState() => _MCQResultFragmentVLAState();
}

class _MCQResultFragmentVLAState extends State<MCQResultFragmentVLA> {
  // TODO COMMENT BELOW LINES
  // int correctAnswerCount = 90, wrongAnswerCount = 5, unAnsweredCount = 5;
  int correctAnswerCount = 0, wrongAnswerCount = 0, unAnsweredCount = 0;
  late Map<String, double> moduleAndTimeMap;
  late Map<String, String> moduleAndNameMap;

  String titleBasedOnPercentage = "";
  double percentageIs = 0.0;

  double heightIs = 0, widthIs = 0;

  Color greenOrRed = Colors.white;
  bool showModuleMap = false;

/*
  <string name="above_ninty">Excellent! </string>
  <string name="below_ninty">Very Good! </string>
  <string name="below_seventy_five">Good! </string>
  <string name="below_fifty">Work a little harder\nYou can do it!</string>
*/

  @override
  void initState() {
    moduleAndTimeMap = {
      TR.correct_answer[languageIndex]: 1,
      TR.incorrect_answer[languageIndex]: 1,
      TR.skipped_answer[languageIndex]: 1,
    };
    //print("assessKitsListMCQFragment");
    //print(assessKitsListMCQFragment);
    for (int i = 0; i < assessKitsListMCQFragment.length; i++) {
      if (assessKitsListMCQFragment[i].userAnswer == "0") {
        unAnsweredCount = unAnsweredCount + 1;
      } else if (assessKitsListMCQFragment[i]
          .userAnswer
          .contains(assessKitsListMCQFragment[i].RightAnswer)) {
        correctAnswerCount = correctAnswerCount + 1;
      } else {
        wrongAnswerCount = wrongAnswerCount + 1;
      }
    }

    moduleAndTimeMap = {
      TR.correct_answer[languageIndex]: correctAnswerCount.toDouble(),
      TR.incorrect_answer[languageIndex]: wrongAnswerCount.toDouble(),
      TR.skipped_answer[languageIndex]: unAnsweredCount.toDouble(),
    };
    showModuleMap = true;
    setState(() {
      moduleAndTimeMap;
      showModuleMap;
    });
    percentageIs = correctAnswerCount /
        (correctAnswerCount + wrongAnswerCount + unAnsweredCount);

    if (percentageIs < .5) {
      titleBasedOnPercentage = TR.below_fifty[languageIndex];
    } else if (percentageIs < .75) {
      titleBasedOnPercentage = TR.below_seventy_five[languageIndex];
    } else if (percentageIs < .9) {
      titleBasedOnPercentage = TR.below_ninty[languageIndex];
    } else {
      titleBasedOnPercentage = TR.above_ninty[languageIndex];
    }

    if (correctAnswerCount > wrongAnswerCount) {
      greenOrRed = Colors.green;
    } else {
      greenOrRed = Colors.redAccent;
    }

    setState(() {
      percentageIs;
      titleBasedOnPercentage;
      greenOrRed;
    });
    sendMCQdataBackToDatabase();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: TextCustomVidwath(
          textTCV: topicName,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 36,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // DividerCustomVidwath(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                ),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: EdgeInsets.all(9),
                  child: Column(
                    children: [
                      DividerCustomVidwath(dividerHeight: 4,),
                      AnimatedContainer(
                        height: 160,
                        duration: const Duration(seconds: 2),
                        padding: const EdgeInsets.fromLTRB(12, 3, 3, 3),
                        child: showModuleMap
                            ? PieChart(
                          chartType: ChartType.ring,
                          ringStrokeWidth: 25,
                          dataMap: moduleAndTimeMap,
                          colorList: const [
                            Color.fromRGBO(76, 176, 80, 1),
                            Color.fromRGBO(244, 66, 54, 1),
                            Color.fromRGBO(255, 151, 0, 1)
                          ],
                          animationDuration: const Duration(seconds: 3),

                          chartLegendSpacing: 50,
                          //chartRadius: 250,
                          initialAngleInDegree: 0,

                          centerText: "Test \nScore \n" + (percentageIs * 100).toStringAsFixed(0) + "%",
                          centerTextStyle: TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.w400),
                          legendOptions: LegendOptions(
                            showLegendsInRow: false,
                            legendPosition: LegendPosition.right,
                            showLegends: true,
                            legendShape: BoxShape.rectangle,
                            legendTextStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10
                            ),
                          ),


                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: false,
                            showChartValuesOutside: true,
                            showChartValueBackground: true,
                            showChartValues: true,
                            chartValueBackgroundColor: Colors.transparent,
                            decimalPlaces: 0,
                            chartValueStyle: TextStyle(
                              color: ConstantValuesVLA.splashBgColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),

                          ),
                        )
                            : Container(
                          height: 151,
                        ),
                      ),
                      DividerCustomVidwath(),
                      ButtonCustomVidwath(
                        textBCV: TR.answer_key[languageIndex],
                        onPressedBCV: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AnswerKeyVLA(widget.thisSetNewScreenFunc)),
                          );
                        },
                      ),
                      DividerCustomVidwath(dividerHeight: 4,),
                    ],
                  ),
                ),
              ),
            ),
            // DividerCustomVidwath(),
            Container(
              width: widthIs,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(9),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5,
                      offset: Offset(3, 3),
                      color: Color.fromRGBO(55, 71, 79, .3))
                ],
              ),
              child: Column(
                children: [
                  DividerCustomVidwath(dividerHeight: 8,),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(9, 0, 0, 0),
                          child: TextCustomVidwath(
                            textTCV: TR.evaluation[languageIndex],
                            fontSizeTCV: 15,
                            fontWeightTCV: FontWeight.bold,
                          ))),
                  DividerCustomVidwath(dividerHeight: 5,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(9, 0, 0, 0),
                      child: TextCustomVidwath(
                        textTCV: TR.total_time_spent[languageIndex] +
                            " " +
                            DateTime.now()
                                .difference(totalTimeSpentStartTime)
                                .inSeconds
                                .toString() +
                            " Seconds.",
                        fontSizeTCV: 12,
                        textColorTCV: ConstantValuesVLA.splashBgColor,
                        fontWeightTCV: FontWeight.bold,
                      ),
                    ),
                  ),
                  DividerCustomVidwath(dividerHeight: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: widthIs / 3,
                        height: widthIs / 3,
                        padding: const EdgeInsets.all(9),
                        margin: const EdgeInsets.all(9),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffe8eeed)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/test.png",
                              width: widthIs / 8.5,
                              color: greenOrRed,
                            ),
                            TextCustomVidwath(
                              textTCV: TR.accuracy_level[languageIndex],
                              fontSizeTCV: 12,
                              fontWeightTCV: FontWeight.bold,
                              textColorTCV: greenOrRed,
                            ),
                            TextCustomVidwath(
                              textTCV:
                                  (percentageIs * 100).toStringAsFixed(0) + "%",
                              fontSizeTCV: 12,
                              fontWeightTCV: FontWeight.bold,
                              textColorTCV: greenOrRed,
                            ),
                          ],
                        ),
                      ),
                      Container(             width: widthIs / 3,
                        height: widthIs / 3,
                        padding: const EdgeInsets.all(9),
                        margin: const EdgeInsets.all(9),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffe8eeed)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/mcq_time.png",
                              width: widthIs / 8.5,
                              color: greenOrRed,
                            ),
                            TextCustomVidwath(
                              textTCV: TR.answer_speed[languageIndex],
                              fontSizeTCV: 12,
                              fontWeightTCV: FontWeight.bold,
                              textColorTCV: greenOrRed,
                            ),
                            TextCustomVidwath(
                              textTCV: ((DateTime.now().difference(totalTimeSpentStartTime).inSeconds) / (correctAnswerCount + wrongAnswerCount + unAnsweredCount)).toStringAsFixed(1).toString() + "${TR.secondPerquestion[languageIndex]}",
                              fontSizeTCV: 8,
                              fontWeightTCV: FontWeight.bold,
                              textColorTCV: greenOrRed,
                            ),

                          ],
                        ),

                      ),
                    ],
                  ),
                  DividerCustomVidwath(dividerHeight: 8,),
                ],
              ),
            ),
            // DividerCustomVidwath(),
            Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(9),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        offset: Offset(3, 3),
                        color: Color.fromRGBO(55, 71, 79, .3))
                  ],
                ),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(9, 0, 0, 0),
                            child: TextCustomVidwath(
                              textTCV: TR.accuracy[languageIndex],
                              fontWeightTCV: FontWeight.bold,
                              fontSizeTCV: 15,
                            ))),
                    DividerCustomVidwath(),
                    TextCustomVidwath(
                      textTCV:
                      "${TR.accuracy_in_attempted_question[languageIndex]}${(((correctAnswerCount) / (correctAnswerCount + wrongAnswerCount)) * 100).toStringAsFixed(0).replaceAll("NaN", "0")}%",
                      textColorTCV: ConstantValuesVLA.splashBgColor,
                      fontWeightTCV: FontWeight.w600,
                      fontSizeTCV: 12,
                    ),

                    TextCustomVidwath(
                      textTCV: "$correctAnswerCount Correct Answers out of ${correctAnswerCount + wrongAnswerCount} Attempted",
                      textColorTCV: ConstantValuesVLA.splashBgColor,
                      fontWeightTCV: FontWeight.w700,
                      fontSizeTCV: 14,
                    ),
                    DividerCustomVidwath(),
                    ((correctAnswerCount + wrongAnswerCount) > 0)
                        ? LinearProgressBar(
                      maxSteps: (correctAnswerCount + wrongAnswerCount),
                      progressType:
                      LinearProgressBar.progressTypeLinear,
                      currentStep: correctAnswerCount,
                      progressColor: Colors.green,
                      backgroundColor: Colors.red,
                    )
                        : Container(
                      child: TextCustomVidwath(
                        textTCV: "Consider answering some questions.",
                      ),
                    ),
                    DividerCustomVidwath(),
                  ],
                )),
          ],
        ),
      )),
    );
  }

  void sendMCQdataBackToDatabase() {
    /*print(jsonEncode({

        "subject_id": selectedEvaluateSubject.IdSubjectMaster,//"291",
        "attempted_date":
        DateFormat("dd-MMM-yyyy hh:mm:ss").format(DateTime.now()),
        //"16-Jul-2022 12:09:22",
        "class_id": prefs.getString(ConstantValuesVLA.class_idJsonKey),
        //"210",
        "total_incorrect": wrongAnswerCount.toString(),
        //"14",
        "board_name": prefs.getString(ConstantValuesVLA.BoardNameJsonKey),//"CBSE",
        "test_percentage": (((correctAnswerCount) /
            (correctAnswerCount +
                wrongAnswerCount)) *
            100)
            .toStringAsFixed(2),
        "user_id": prefs.getString(ConstantValuesVLA.user_idJsonKey),
        //"125003",
        "board_id": prefs.getString(ConstantValuesVLA.boardidJsonKey),
        //"3",
        "subject_name": selectedEvaluateSubject.SubjectName,//"Mathematics",
        "topic_name": selectedTopic,//"Real Numbers  ",
        "total_correct": correctAnswerCount.toString(),
        //"3",
        "total_question":
        (correctAnswerCount + wrongAnswerCount + unAnsweredCount)
            .toString(),
        //"20",
        "assesment_type": "0",
        "topic_id": IdTopicMaster,//"2001",
        "total_time_taken": DateTime.now()
            .difference(totalTimeSpentStartTime)
            .inSeconds
            .toString(),
        //"65",
        "class_name": prefs.getString(ConstantValuesVLA.classnameJsonKey),//"10",
        "total_skipped": unAnsweredCount.toString(),
        "answer_accuracy": (percentageIs * 100).toStringAsFixed(2)
        //"17.65"

    }).toString());*/
    http.post(
        Uri.parse(ConstantValuesVLA.baseURLConstant +
            ConstantValuesVLA.sendMCQcorrecWrongToDatabaseConstant),
        body: jsonEncode({
          "subject_id": selectedEvaluateSubject.IdSubjectMaster,
          //"291",
          "attempted_date":
              DateFormat("dd-MMM-yyyy hh:mm:ss").format(DateTime.now()),
          //"16-Jul-2022 12:09:22",
          "class_id": prefs.getString(ConstantValuesVLA.class_idJsonKey),
          //"210",
          "total_incorrect": wrongAnswerCount.toString(),
          //"14",
          "board_name": prefs.getString(ConstantValuesVLA.BoardNameJsonKey),
          //"CBSE",
          "test_percentage": (((correctAnswerCount) /
                      (correctAnswerCount + wrongAnswerCount)) *
                  100)
              .toStringAsFixed(2),
          "user_id": prefs.getString(ConstantValuesVLA.user_idJsonKey),
          //"125003",
          "board_id": prefs.getString(ConstantValuesVLA.boardidJsonKey),
          //"3",
          "subject_name": selectedEvaluateSubject.SubjectName,
          //"Mathematics",
          "topic_name": selectedTopic,
          //"Real Numbers  ",
          "total_correct": correctAnswerCount.toString(),
          //"3",
          "total_question":
              (correctAnswerCount + wrongAnswerCount + unAnsweredCount)
                  .toString(),
          //"20",
          "assesment_type": "0",
          "topic_id": IdTopicMaster,
          //"2001",
          "total_time_taken": DateTime.now()
              .difference(totalTimeSpentStartTime)
              .inSeconds
              .toString(),
          //"65",
          "class_name": prefs.getString(ConstantValuesVLA.classnameJsonKey),
          //"10",
          "total_skipped": unAnsweredCount.toString(),
          "answer_accuracy": (percentageIs * 100).toStringAsFixed(0)
          //"17.65"
        }));
  }
}
