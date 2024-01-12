// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/learn_page_fragments_vla/progress_pages_vla/subject_wise_analysis_vla.dart';

import '../../../../constants_vla/constant_values_vla.dart';
import '../../../../main.dart';
import '../../../../translation_vla/tr.dart';
import '../../../../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import 'each_topic_each_attempt_vla.dart';

class ViewDetalisAnalysisVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  ViewDetalisAnalysisVLA(this.thisSetNewScreenFunc, {Key? key})
      : super(key: key);

  @override
  State<ViewDetalisAnalysisVLA> createState() => _ViewDetalisAnalysisVLAState();
}

class _ViewDetalisAnalysisVLAState extends State<ViewDetalisAnalysisVLA> {
  double heightIs = 0, widthIs = 0;
  List<Widget> listOfEachTopicWidget = [];

  @override
  void initState() {
    getViewDetailsTopicAnalysis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: SizedBox(
        height: heightIs,
        width: widthIs,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              TextCustomVidwath(
                textTCV: subjectWiseAnalysisModelVLA.SubjectName,
                fontSizeTCV: 18,
                fontWeightTCV: FontWeight.bold,
              ),
              DividerCustomVidwath(),
              Column(
                children: listOfEachTopicWidget,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getViewDetailsTopicAnalysis() {
    http
        .post(
            Uri.parse(ConstantValuesVLA.baseURLConstant +
                ConstantValuesVLA.topicAnalysisListAfterViewDetailsConstant),
            body: jsonEncode({
              ConstantValuesVLA.user_idJsonKey:
                  prefs.getString(ConstantValuesVLA.user_idJsonKey),
              ConstantValuesVLA.subject_idJsonKey:
                  // "473"
                  subjectWiseAnalysisModelVLA.IdSubjectMaster
            }))
        .then((topicAnalysis) {
      // print("topicAnalysis.body.toString()");
      // print(topicAnalysis.body.toString());
      List<dynamic> listOfTopicWiseAnalysis = jsonDecode(topicAnalysis.body);
      for (int i = 0; i < listOfTopicWiseAnalysis.length; i++) {
        //print("listOfTopicWiseAnalysis[i]");
        //print(listOfTopicWiseAnalysis[i]);
        listOfEachTopicWidget.add(GestureDetector(
          onTap: () {
            widget.thisSetNewScreenFunc(EachTopicEachAttemptVLA(
                widget.thisSetNewScreenFunc,
                listOfTopicWiseAnalysis[i]["topic_name"],
                listOfTopicWiseAnalysis[i]["topic_id"]));
          },
          child: Card(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              //set border radius more than 50% of height and width to make circle
            ),
            elevation: 4,
            child: Container(
              padding: const EdgeInsets.all(9),
              margin: const EdgeInsets.all(9),
              height: 190,
              child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          TextCustomVidwath(
                            textTCV: listOfTopicWiseAnalysis[i]["topic_name"],
                            textColorTCV: ConstantValuesVLA.splashBgColor,
                            fontSizeTCV: 13,
                            fontWeightTCV: FontWeight.bold,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextCustomVidwath(
                              textTCV: "${"${TR.progress[languageIndex]} (" + listOfTopicWiseAnalysis[i]["overall_progress"]})%",
                              textColorTCV: Colors.orange,
                              fontSizeTCV: 12,
                            ),
                          ),




                        ],
                      ),


                      Icon(Icons.arrow_forward_ios_rounded,color: ConstantValuesVLA.splashBgColor,size: 17,)

                    ],
                  ),

                  DividerCustomVidwath(),
                  LinearProgressBar(
                    maxSteps: 100,
                    progressType: LinearProgressBar.progressTypeLinear,
                    currentStep: double.parse(
                            listOfTopicWiseAnalysis[i]["overall_progress"])
                        .toInt(),
                    progressColor: Colors.green,
                    backgroundColor: Colors.red,
                  ),

                  DividerCustomVidwath(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: widthIs / 3.1,
                        child: Column(
                          children: [
                            TextCustomVidwath(
                              textTCV: TR.latest_score[languageIndex],
                              textColorTCV: Colors.green,
                              fontSizeTCV: 12,
                            ),
                            SizedBox(height: 8,),
                            TextCustomVidwath(
                              textTCV:
                                  listOfTopicWiseAnalysis[i]["score"].toString(),
                              fontSizeTCV: 12,
                              fontWeightTCV: FontWeight.bold,
                              textColorTCV: ConstantValuesVLA.splashBgColor,
                            ),
                            SizedBox(height: 8,),
                            LinearProgressBar(
                              maxSteps: int.parse(
                                  listOfTopicWiseAnalysis[i]["total_questions"]),
                              progressType: LinearProgressBar.progressTypeLinear,
                              currentStep: int.parse(
                                  listOfTopicWiseAnalysis[i]["lastest_score"]),
                              progressColor: Colors.green,
                              backgroundColor: Colors.red,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: widthIs / 2.16,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustomVidwath(
                              textTCV: "${TR.total_attempts[languageIndex]} : " +
                                  listOfTopicWiseAnalysis[i]["total_attemptes"],
                              fontSizeTCV: 12,
                            ),
                            TextCustomVidwath(
                              textTCV: TR.last_attempted_date[languageIndex],
                              textColorTCV: Colors.red,
                              fontWeightTCV: FontWeight.bold,
                              fontSizeTCV: 12,
                            ),
                            TextCustomVidwath(
                              textTCV: listOfTopicWiseAnalysis[i]
                                  ["last_attempted_Date"],
                              fontSizeTCV: 12,
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
        setState(() {
          listOfEachTopicWidget;
        });
      }
    });
  }

  Future<bool> onBackPressed() {
    /*widget.thisSetNewScreenFunc(AssessKitQuizVLA(widget.thisSetNewScreenFunc));
      widget.changeToAfterAssess;*/
    listOfWidgetForBack.removeLast();
    widget.thisSetNewScreenFunc(listOfWidgetForBack.last, addToQueue: false);
    return Future.value(false);
  }
}
