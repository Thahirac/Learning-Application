import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/learn_page_fragments_vla/progress_pages_vla/sub_subject_wise_analysis_time_spent.dart';
import 'package:vel_app_online/vidwath_custom_widgets/divider_custom_vidwath.dart';

import '../../../../constants_vla/constant_values_vla.dart';
import '../../../../main.dart';
import '../../../../models_vla/subject_wise_analysis_model_vla.dart';
import '../../../../translation_vla/tr.dart';
import '../../../../vidwath_custom_widgets/image_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import 'each_subject_analysis_vla.dart';

class SubjectWiseAnalysisTimeSpendVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  SubjectWiseAnalysisTimeSpendVLA(this.thisSetNewScreenFunc, {Key? key});

  @override
  State<SubjectWiseAnalysisTimeSpendVLA> createState() => _SubjectWiseAnalysisTimeSpendVLAState();
}

late SubjectWiseAnalysisModelVLA subjectWiseAnalysisModelVLA;

class _SubjectWiseAnalysisTimeSpendVLAState extends State<SubjectWiseAnalysisTimeSpendVLA> {
  List<SubjectWiseAnalysisModelVLA> evaluateSubjectList = [];
  var rng = Random();
  double screenWidth = 0, screenHeight = 0;
  String actualtimeformate='';


  void intToTimeLeft(int value) {
    int h, m, s;

    h = value ~/ 3600;

    m = ((value - h * 3600)) ~/ 60;

    s = value - (h * 3600) - (m * 60);

    int hourLeft = int.parse(h.toString().length < 2 ? "0" + h.toString() : h.toString());

    int minuteLeft = int.parse(m.toString().length < 2 ? "0" + m.toString() : m.toString());

    int secondsLeft = int.parse(s.toString().length < 2 ? "0" + s.toString() : s.toString());

    //actualtimeformate = "$hourLeft:$minuteLeft:$secondsLeft";
    actualtimeformate = "${hourLeft>0?'$hourLeft hr':""} ${minuteLeft>0?'$minuteLeft min':""} ${secondsLeft>0?'$secondsLeft seconds':""}";

   // print('*************actualtimeformate***************${actualtimeformate.length}');
   // return result;
  }

  @override
  void initState() {
    super.initState();
    getTutorialVideoAPI();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: appBarHeight,
                child: Center(
                  child: TextCustomVidwath(
                    textTCV: TR.subject_wise_analysis[languageIndex],
                    fontSizeTCV: 18,
                    textColorTCV: ConstantValuesVLA.blackTextColor,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight - 198,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: evaluateSubjectList.length,
                    itemBuilder: (context, index) {
                      intToTimeLeft(evaluateSubjectList[index].notes[0].progress.toInt());
                      return GestureDetector(
                        onTap: () {


                          widget.thisSetNewScreenFunc(
                              SubSubjectWiseAnalysisTimeSpendVLA(widget.thisSetNewScreenFunc,evaluateSubjectList[index].IdSubjectMaster,evaluateSubjectList[index].SubjectName));

                        },
                        child: Container(
                          margin: EdgeInsets.all(12),
                          height: 97,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 5,
                                    offset: Offset(3, 3),
                                    color: Color.fromRGBO(55, 71, 79, .3))
                              ],
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(7))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ImageCustomVidwath(
                                imageUrlICV: evaluateSubjectList[index].image,
                                widthICV: 72,
                                heightICV: 72,
                                aboveImageICV:
                                evaluateSubjectList[index].SubjectName,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: screenWidth / 2,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            TextCustomVidwath(
                                              textTCV:
                                              evaluateSubjectList[index]
                                                  .SubjectName,
                                              fontSizeTCV: 12.5,
                                              fontWeightTCV: FontWeight.w600,
                                            ),
                                          ],
                                        ),


                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            TextCustomVidwath(
                                              textTCV: "Total Chapters: " + evaluateSubjectList[index].notes[0].counts.toString(),
                                              fontSizeTCV: 9.5,
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                  Divider(height: 8,color: Colors.transparent,),
                                  Container(
                                    height: 1.5,
                                    color: Colors.grey.shade300, width: screenWidth / 2,),
                                  Divider(height: 8,color: Colors.transparent,),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextCustomVidwath(
                                      textTCV: actualtimeformate=="  "? "Time Spent: " + "0 seconds":"Time Spent: " + actualtimeformate,
                                      fontSizeTCV: 10,
                                    ),
                                  ),
                                ],
                              ),

                              Icon(Icons.arrow_forward_ios_rounded,color: ConstantValuesVLA.splashBgColor,size: 17,)
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {

    print('****** CLASS ID ***********${prefs.getString(ConstantValuesVLA.class_idJsonKey)}');

    print('****** USER ID ***********${prefs.getString(ConstantValuesVLA.user_idJsonKey)}');
    print('****** BOARD ID ***********${prefs.getString(ConstantValuesVLA.boardidJsonKey)}');

    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.subjectwiseAnalysis);
    http
        .post(url,
        body: jsonEncode(
            {
          ConstantValuesVLA.class_idJsonKey: prefs.getString(ConstantValuesVLA.class_idJsonKey),
          ConstantValuesVLA.user_idJsonKey: prefs.getString(ConstantValuesVLA.user_idJsonKey),
          ConstantValuesVLA.boardidJsonKey2: prefs.getString(ConstantValuesVLA.boardidJsonKey),
        }

        ))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        evaluateSubjectList.add(
            SubjectWiseAnalysisModelVLA.fromJson(tutorialVideoListTemp[i]));
        //print(tutorialVideoListTemp[i]);
      }
      setState(() {
        evaluateSubjectList;
      });


      print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   ${evaluateSubjectList.length}');

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
