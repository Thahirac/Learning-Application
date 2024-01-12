import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/learn_page_fragments_vla/progress_pages_vla/subject_wise_analysis_time_spent.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/learn_page_fragments_vla/progress_pages_vla/subject_wise_analysis_vla.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/more_fragments_vla/my_plans_vla.dart';

import '../../../constants_vla/constant_values_vla.dart';
import '../../../main.dart';
import '../../../translation_vla/tr.dart';
import '../../../vidwath_custom_widgets/text_custom_vidwath.dart';

class ProgressAnalysisCardInHomeDashboardVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  ProgressAnalysisCardInHomeDashboardVLA(this.thisSetNewScreenFunc, {Key? key})
      : super(key: key);

  @override
  State<ProgressAnalysisCardInHomeDashboardVLA> createState() =>
      _ProgressAnalysisCardInHomeDashboardVLAState();
}

class _ProgressAnalysisCardInHomeDashboardVLAState
    extends State<ProgressAnalysisCardInHomeDashboardVLA> {
  double heightIs = 0, widthIs = 0;
  int testTaken = 0;
  double correctAnswer = 0, incorrectAnswer = 0, unAttemptedAnswer = 0;

  @override
  void initState() {
    getTutorialVideoAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return (testTaken > 0)
        ? Stack(
          children: [
            GestureDetector(
              onTap: (){
                widget.thisSetNewScreenFunc(
                    SubjectWiseAnalysisVLA(widget.thisSetNewScreenFunc));
              },
              child: Container(
                height: heightIs * 0.25,
                width: widthIs * .9,
                margin: const EdgeInsets.fromLTRB(9, 27, 9, 9),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextCustomVidwath(
                        textTCV: TR.my_progress[languageIndex],
                        textColorTCV: ConstantValuesVLA.splashBgColor,
                        textAlignTCV: TextAlign.left,
                        fontWeightTCV: FontWeight.bold,
                        fontSizeTCV: 12,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "assets/home_analysis_progress_analysis.gif",
                          height: 108,
                          width: 108,
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(18, 2, 2, 2),
                          width: widthIs * .45,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCustomVidwath(
                                textTCV: testTaken.toString() +
                                    " " +
                                    TR.test_taken[languageIndex],
                                textColorTCV: Colors.orangeAccent,
                                fontSizeTCV: 11,
                                fontWeightTCV: FontWeight.bold,
                              ),
                              Row(
                                children: [

                                  Container(
                                    height: 7,
                                    width: 7,
                                    color: Colors.green,
                                  ),



                                  TextCustomVidwath(
                                    textTCV: "  " + correctAnswer.toStringAsFixed(0) +
                                        "% " +
                                        TR.correct_answer_[languageIndex],
                                    textColorTCV: Colors.green,
                                    fontSizeTCV: 11,
                                    fontWeightTCV: FontWeight.bold,
                                  ),
                                ],
                              ),
                              Row(
                                children: [

                                  Container(
                                    height: 7,
                                    width: 7,
                                    color: Colors.redAccent,
                                  ),


                                  TextCustomVidwath(
                                    textTCV: "  " + incorrectAnswer.toStringAsFixed(0) +
                                        "% " +
                                        TR.incorrect_answer[languageIndex],
                                    textColorTCV: Colors.redAccent,
                                    fontSizeTCV: 11,
                                    fontWeightTCV: FontWeight.bold,
                                  ),
                                ],
                              ),
                              Row(
                                children: [

                                  Container(
                                    height: 7,
                                    width: 7,
                                    color: Colors.orangeAccent,
                                  ),


                                  TextCustomVidwath(
                                    textTCV:
                                       "  " + unAttemptedAnswer.toStringAsFixed(0) +
                                            "% " +
                                            TR.un_attempted_answer[languageIndex],
                                    textColorTCV: Colors.orangeAccent,
                                    fontSizeTCV: 11,
                                    fontWeightTCV: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: (){
                    widget.thisSetNewScreenFunc(
                       SubjectWiseAnalysisTimeSpendVLA(widget.thisSetNewScreenFunc));
                  },
                  child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2,
                                color: Colors.grey,
                                offset: Offset(3, 3))
                          ]),
                      height: 63,
                      width: 63,
                      margin: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                      child: Image.asset(
                        "assets/ic_analytics_home.png",
                        height: 63,
                        width: 63,
                      )),
                )),
          ],
        )
        : Container();
  }

  Future<void> getTutorialVideoAPI() async {


    print('****** CLASS ID ***********${prefs.getString(ConstantValuesVLA.class_idJsonKey)}');

    print('****** USER ID ***********${prefs.getString(ConstantValuesVLA.user_idJsonKey)}');

    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.dashboardAnalyticsConstant);
    http.post(url,
        body: jsonEncode({
              ConstantValuesVLA.class_idJsonKey:
                  prefs.getString(ConstantValuesVLA.class_idJsonKey),
              ConstantValuesVLA.user_idJsonKey:
                  prefs.getString(ConstantValuesVLA.user_idJsonKey)
            }))
        .then((value) {
      //print("value.body");
      //print(value.body);
      //print(value.body);
      var decodedJson = jsonDecode(value.body);
      testTaken = (decodedJson["total_tests"]);
      correctAnswer =
          double.parse(decodedJson["correct_percenatge"].toString());
      incorrectAnswer =
          double.parse(decodedJson["incorrect_percenatge"].toString());
      unAttemptedAnswer =
          double.parse(decodedJson["skipped_percenatge"].toString());
      setState(() {
        testTaken;
        correctAnswer;
        incorrectAnswer;
        unAttemptedAnswer;
      });



    });
  }
}
