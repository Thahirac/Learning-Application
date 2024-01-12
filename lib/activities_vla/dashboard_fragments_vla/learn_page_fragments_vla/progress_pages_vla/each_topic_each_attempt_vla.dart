// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:linear_progress_bar/linear_progress_bar.dart';

import '../../../../constants_vla/constant_values_vla.dart';
import '../../../../main.dart';
import '../../../../translation_vla/tr.dart';
import '../../../../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import 'each_topic_each_attempt_mcq_result_like_vla.dart';

class EachTopicEachAttemptVLA extends StatefulWidget {
  var thisSetNewScreenFunc;
  String topicName, topicId;

  EachTopicEachAttemptVLA(
      this.thisSetNewScreenFunc, this.topicName, this.topicId);

  @override
  State<EachTopicEachAttemptVLA> createState() =>
      _EachTopicEachAttemptVLAState();
}

class _EachTopicEachAttemptVLAState extends State<EachTopicEachAttemptVLA> {
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
                textTCV: widget.topicName,
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
    String urlDTA = ConstantValuesVLA.baseURLConstant +
        ConstantValuesVLA.eachTopicEachAttemptConstant;
    var dataDTA = {
      ConstantValuesVLA.user_idJsonKey:
          prefs.getString(ConstantValuesVLA.user_idJsonKey),
      ConstantValuesVLA.topic_idJsonKey: widget.topicId
      // ConstantValuesVLA.topic_idJsonKey: "4844"
    };
    // print("u4o5a4uo5e");
    // print(urlDTA);
    // print(dataDTA);
    http
        .post(Uri.parse(urlDTA), body: jsonEncode(dataDTA))
        .then((topicAnalysis) {
      // print("topicAnalysis.body.toString()");
      // print(topicAnalysis.body.toString());
      List<dynamic> listOfTopicWiseAnalysis = jsonDecode(topicAnalysis.body);
      for (int i = 0; i < listOfTopicWiseAnalysis.length; i++) {
        //print("listOfTopicWiseAnalysis[i]");
        //print(listOfTopicWiseAnalysis[i]);
        listOfEachTopicWidget.add(GestureDetector(
          onTap: () {
            widget.thisSetNewScreenFunc(EachTopicEachAttemptMCQResultLikeVLA(
                widget.thisSetNewScreenFunc, widget.topicId,i));
          },
          child: Card(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              //set border radius more than 50% of height and width to make circle
            ),
            elevation: 4,
            child: Container(
              padding: EdgeInsets.all(9),
              margin: EdgeInsets.all(9),
              height: 173,
              child: Column(
                children: [
                  TextCustomVidwath(
                    textTCV:  TR.attempted_date[languageIndex] + " : " + listOfTopicWiseAnalysis[i]["AttemptedDate"] , textColorTCV: ConstantValuesVLA.splashBgColor,
                    fontWeightTCV: FontWeight.bold,
                    fontSizeTCV: 13,
                  ),
                  DividerCustomVidwath(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextCustomVidwath(
                        textTCV: "${"${TR.progress[languageIndex]} (" +
                            listOfTopicWiseAnalysis[i]["test_percentage"]})%",
                        textColorTCV: Colors.orange,
                        fontSizeTCV: 12,
                      ),


                      Icon(Icons.arrow_forward_ios_rounded,color: ConstantValuesVLA.splashBgColor,size: 17,)

                    ],
                  ),

                  DividerCustomVidwath(),
                  LinearProgressBar(
                    maxSteps: 100,
                    progressType: LinearProgressBar.progressTypeLinear,
                    currentStep: double.parse(listOfTopicWiseAnalysis[i]["test_percentage"]).toInt(),
                    progressColor: Colors.green,
                    backgroundColor: Colors.red,
                  ),




                  DividerCustomVidwath(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextCustomVidwath(
                            textTCV: TR.latest_score[languageIndex],
                            textColorTCV: Colors.green,
                            fontSizeTCV: 12,
                          ),
                          TextCustomVidwath(
                            textTCV: "${listOfTopicWiseAnalysis[i]["correctAnswer"]}/${listOfTopicWiseAnalysis[i]["totalQuestion"]}",
                            fontSizeTCV: 12,
                            fontWeightTCV: FontWeight.w500,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextCustomVidwath(
                            textTCV: "${TR.time_taken[languageIndex]} ",
                            textColorTCV: Colors.green,
                            fontSizeTCV: 12,
                          ),
                          TextCustomVidwath(
                            textTCV: "${listOfTopicWiseAnalysis[i]
                                        ["totalTimeTaken"]} seconds",
                            fontSizeTCV: 12,
                            fontWeightTCV: FontWeight.w500,
                          ),
                        ],
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
