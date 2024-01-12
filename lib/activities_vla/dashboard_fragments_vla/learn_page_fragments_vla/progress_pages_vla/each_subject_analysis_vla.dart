import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:http/http.dart' as http;
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/learn_page_fragments_vla/progress_pages_vla/subject_wise_analysis_vla.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/learn_page_fragments_vla/progress_pages_vla/view_details_analysis_vla.dart';

import '../../../../constants_vla/constant_values_vla.dart';
import '../../../../main.dart';
import '../../../../translation_vla/tr.dart';
import '../../../../vidwath_custom_widgets/button_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/text_custom_vidwath.dart';

class EachSubjectAnalysisVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  EachSubjectAnalysisVLA(this.thisSetNewScreenFunc, {Key? key})
      : super(key: key);

  @override
  State<EachSubjectAnalysisVLA> createState() => _EachSubjectAnalysisVLAState();
}

class _EachSubjectAnalysisVLAState extends State<EachSubjectAnalysisVLA> {
  double heightIs = 0, widthIs = 0;
  int testTaken = 0;
  double correctAnswerCount = 0, wrongAnswerCount = 0, unAnsweredCount = 0;
  String totalTimeTaken = "", totalQuestions = "", totalCorrect = "", totalIncorrect = "";
  double percentageIs = 0.0;
  dynamic accuracy = 0.0;
  int avarageTestDuration = 0;
  String? actualTestDuration="";
  Color greenOrRed = Colors.white;

  @override
  void initState() {
    getTutorialVideoAPI();
    if (correctAnswerCount > wrongAnswerCount) {
      greenOrRed = Colors.green;
    } else {
      greenOrRed = Colors.redAccent;
    }
    percentageIs = correctAnswerCount / (correctAnswerCount + wrongAnswerCount + unAnsweredCount);

    super.initState();
  }

  void intToTimeLeft(int value) {
    int h, m, s;

    h = value ~/ 3600;

    m = ((value - h * 3600)) ~/ 60;

    s = value - (h * 3600) - (m * 60);

    String hourLeft = h.toString().length < 2 ? "0" + h.toString() : h.toString();

    String minuteLeft =
    m.toString().length < 2 ? "0" + m.toString() : m.toString();

    String secondsLeft =
    s.toString().length < 2 ? "0" + s.toString() : s.toString();

   actualTestDuration = "$minuteLeft:$secondsLeft";

    // return actualTestDuration;
  }

  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 126,
              width: widthIs * .9,
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                  color: ConstantValuesVLA.whiteColor,
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 15.0,
                        color: Colors.grey,
                        offset: Offset(5, 5)),
                  ],
                  borderRadius:
                      const BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: [
                  Image.asset(
                    "assets/home_analysis_progress_analysis.gif",
                    width: widthIs * .234,
                    height: widthIs * .234,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(18, 2, 2, 2),
                    width: widthIs * .45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /*TextCustomVidwath(
                          textTCV:
                              "$testTaken ${TR.test_taken[languageIndex]}",
                          textColorTCV: Colors.orangeAccent,
                          fontSizeTCV: 10,
                          fontWeightTCV: FontWeight.bold,
                        ),
                        TextCustomVidwath(
                          textTCV:
                              "${correctAnswerCount.toStringAsFixed(2)}% ${TR.correct_answer[languageIndex]}",
                          textColorTCV: Colors.green,
                          fontSizeTCV: 10,
                          fontWeightTCV: FontWeight.bold,
                        ),
                        TextCustomVidwath(
                          textTCV:
                              "${wrongAnswerCount.toStringAsFixed(2)}% ${TR.incorrect_answer[languageIndex]}",
                          textColorTCV: Colors.redAccent,
                          fontSizeTCV: 10,
                          fontWeightTCV: FontWeight.bold,
                        ),
                        TextCustomVidwath(
                          textTCV:
                              "${unAnsweredCount.toStringAsFixed(2)}% ${TR.un_attempted_answer[languageIndex]}",
                          textColorTCV: Colors.orangeAccent,
                          fontSizeTCV: 10,
                          fontWeightTCV: FontWeight.bold,
                        ),*/
                        TextCustomVidwath(
                          textTCV: testTaken.toString() +
                              " " +
                              TR.test_taken[languageIndex],
                          textColorTCV: Colors.orangeAccent,
                          fontSizeTCV: 11,
                          fontWeightTCV: FontWeight.bold,
                        ),
                        TextCustomVidwath(
                          textTCV: correctAnswerCount.toStringAsFixed(0) +
                              "% " +
                              TR.correct_answer_[languageIndex],
                          textColorTCV: Colors.green,
                          fontSizeTCV: 11,
                          fontWeightTCV: FontWeight.bold,
                        ),
                        TextCustomVidwath(
                          textTCV: wrongAnswerCount.toStringAsFixed(0) +
                              "% " +
                              TR.incorrect_answer[languageIndex],
                          textColorTCV: Colors.redAccent,
                          fontSizeTCV: 11,
                          fontWeightTCV: FontWeight.bold,
                        ),
                        TextCustomVidwath(
                          textTCV:
                          unAnsweredCount.toStringAsFixed(0) +
                              "% " +
                              TR.un_attempted_answer[languageIndex],
                          textColorTCV: Colors.orangeAccent,
                          fontSizeTCV: 11,
                          fontWeightTCV: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                //set border radius more than 50% of height and width to make circle
              ),
              elevation: 4,
              child: Column(
                children: [
                  DividerCustomVidwath(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                              textTCV: "${(percentageIs * 100).toStringAsFixed(0)}%",
                              fontSizeTCV: 10,
                              fontWeightTCV: FontWeight.bold,
                              textColorTCV: greenOrRed,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(9),
                        width: widthIs / 3,
                        height: widthIs / 3,
                        padding: const EdgeInsets.all(9),
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
                              textTCV: "${actualTestDuration}" + "${TR.minuesPertest[languageIndex]}",
                              fontSizeTCV: 8,
                              fontWeightTCV: FontWeight.bold,
                              textColorTCV: greenOrRed,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  DividerCustomVidwath(),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                //set border radius more than 50% of height and width to make circle
              ),
              elevation: 4,
              child: Container(
                  margin: const EdgeInsets.all(9),
                  padding: const EdgeInsets.all(9),
                  child: Column(
                    children: [
                      DividerCustomVidwath(),
                      TextCustomVidwath(
                        textTCV:
                            "${TR.accuracy_in_attempted_question[languageIndex]}${(((correctAnswerCount) / (correctAnswerCount + wrongAnswerCount)) * 100).toStringAsFixed(0).replaceAll("NaN", "0")}%",
                        textColorTCV: ConstantValuesVLA.splashBgColor,
                        fontWeightTCV: FontWeight.bold,
                        fontSizeTCV: 14,
                      ),
                      DividerCustomVidwath(),
                      ((correctAnswerCount + wrongAnswerCount) > 0)
                          ? LinearProgressBar(
                              maxSteps:
                                  (correctAnswerCount + wrongAnswerCount).toInt(),
                              progressType: LinearProgressBar.progressTypeLinear,
                              currentStep: correctAnswerCount.toInt(),
                              progressColor: Colors.green,
                              backgroundColor: Colors.red,
                            )
                          : Container(
                              child: TextCustomVidwath(
                                textTCV: "Consider answering some questions.",
                              ),
                            ),
                      DividerCustomVidwath(),
                      TextCustomVidwath(
                        textTCV:
                            "${correctAnswerCount.toStringAsFixed(0)} Correct Answers out of ${(correctAnswerCount + wrongAnswerCount).toStringAsFixed(0)} Attempted",
                        textColorTCV: ConstantValuesVLA.splashBgColor,
                        fontWeightTCV: FontWeight.bold,
                        fontSizeTCV: 14,
                      ),
                      DividerCustomVidwath(),
                    ],
                  )),
            ),
            DividerCustomVidwath(),
            ButtonCustomVidwath(
              onPressedBCV: () {
                widget.thisSetNewScreenFunc(
                    ViewDetalisAnalysisVLA(widget.thisSetNewScreenFunc));
              },
              textBCV: "View Details",
              enabledBgColorBCV: ConstantValuesVLA.splashBgColor,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {
    print("****************** user_idJsonKey ********** ${prefs.getString(ConstantValuesVLA.user_idJsonKey)}");
    print("****************** IdSubjectMaster ********** ${subjectWiseAnalysisModelVLA.IdSubjectMaster}");

  //  print(prefs.getString(ConstantValuesVLA.user_idJsonKey));

    //print(subjectWiseAnalysisModelVLA.IdSubjectMaster);
    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.eachSingleSubjectdAnalyticsConstant);
    http
        .post(url,
            body: jsonEncode({
              ConstantValuesVLA.user_idJsonKey: prefs.getString(ConstantValuesVLA.user_idJsonKey),
              ConstantValuesVLA.subject_idJsonKey: subjectWiseAnalysisModelVLA.IdSubjectMaster
            }))
        .then((value) {
      /*print("value.body each_subject_analysis_vla.dart");
      print(value.body.toString());
      print(value.body.toString());*/
      var decodedJson = jsonDecode(value.body);
      testTaken = (decodedJson["total_tests"]);
      correctAnswerCount = double.parse(decodedJson["correct_percenatge"].toString());
      wrongAnswerCount = double.parse(decodedJson["incorrect_percenatge"].toString());
      unAnsweredCount = double.parse(decodedJson["skipped_percenatge"].toString());
      totalTimeTaken = (decodedJson["total_time_taken"]);
      totalQuestions = (decodedJson["total_Questions"]);
      totalCorrect = (decodedJson["total_correct"]);
      totalIncorrect = (decodedJson["total_incorrect"]);
      accuracy = (decodedJson["accuracy"]);
      avarageTestDuration = double.parse(decodedJson["avarage_test_duration"].toString()).toInt();

      percentageIs = correctAnswerCount /
          (correctAnswerCount + wrongAnswerCount + unAnsweredCount);
      setState(() {
        testTaken;
        correctAnswerCount;
        wrongAnswerCount;
        unAnsweredCount;
        print("*****************testTaken*****************${testTaken}");
        print("*****************correctAnswerCount*****************${correctAnswerCount}");
        print("*****************wrongAnswerCount*****************${wrongAnswerCount}");
        print("*****************unAnsweredCount*****************${unAnsweredCount}");
      });
      intToTimeLeft(avarageTestDuration);
    });
  }

  Future<bool> onBackPressed() {
    //print("Future<bool> onBackPressed() {");
    /*widget.thisSetNewScreenFunc(AssessKitQuizVLA(widget.thisSetNewScreenFunc));
    widget.changeToAfterAssess;*/
    listOfWidgetForBack.removeLast();
    widget.thisSetNewScreenFunc(listOfWidgetForBack.last, addToQueue: false);
    return Future.value(false);
  }





}
