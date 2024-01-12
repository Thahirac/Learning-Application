import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vel_app_online/vidwath_custom_widgets/divider_custom_vidwath.dart';

import '../../../../constants_vla/constant_values_vla.dart';
import '../../../../main.dart';
import '../../../../models_vla/sub_subject_wise_analysis_model_vla.dart';
import '../../../../models_vla/subject_wise_analysis_model_vla.dart';
import '../../../../translation_vla/tr.dart';
import '../../../../vidwath_custom_widgets/image_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import 'analytics_single_topic_time_spent.dart';
import 'each_subject_analysis_vla.dart';

class SubSubjectWiseAnalysisTimeSpendVLA extends StatefulWidget {
  var thisSetNewScreenFunc;
  final String subjectId,subjectName;

  SubSubjectWiseAnalysisTimeSpendVLA(this.thisSetNewScreenFunc,this.subjectId,this.subjectName, {Key? key});

  @override
  State<SubSubjectWiseAnalysisTimeSpendVLA> createState() => _SubSubjectWiseAnalysisTimeSpendVLAState();
}

late SubjectWiseAnalysisModelVLA subjectWiseAnalysisModelVLA;

class _SubSubjectWiseAnalysisTimeSpendVLAState extends State<SubSubjectWiseAnalysisTimeSpendVLA> {
  List<SubSubjectWiseAnalysisModelVLA> evaluateSubSubjectList = [];
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

    actualtimeformate = "${hourLeft>0?'$hourLeft hr':""} ${minuteLeft>0?'$minuteLeft min':""} ${secondsLeft>0?'$secondsLeft seconds':""}";

  }

  @override
  void initState() {
    super.initState();
    getTutorialVideoAPI();

    Future.delayed(const Duration(seconds: 0), () {
      appBarTitle = widget.subjectName;
      widget.thisSetNewScreenFunc(Container(),
          addToQueue: false, changeAppBar: true);
    });

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
                height: screenHeight - 198,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: evaluateSubSubjectList.length,
                    itemBuilder: (context, index) {
                      intToTimeLeft(evaluateSubSubjectList[index].totaltime[0].totalduration.toInt());
                      return GestureDetector(
                        onTap: () {
                          widget.thisSetNewScreenFunc(
                              AnalyticsSingleTopicTimeSpendVLA(widget.thisSetNewScreenFunc,widget.subjectId,evaluateSubSubjectList[index].topicId,evaluateSubSubjectList[index].topicName));

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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [


                                    Container(
                                      constraints: BoxConstraints(maxWidth: 250),
                                      child: Text(
                                        evaluateSubSubjectList[index].topicName,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        softWrap: false,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.teal,
                                        ),
                                      ),
                                    ),

                                   SizedBox(height: 10,),

                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextCustomVidwath(
                                        textTCV: actualtimeformate=="  "? "Total Time Spent: " + "0 seconds":"Total Time Spent: " + actualtimeformate,
                                        fontSizeTCV: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),


                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Icon(Icons.arrow_forward_ios_rounded,color: ConstantValuesVLA.splashBgColor,size: 22,),
                              )
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

    print('****** SUBJECT ID ***********${widget.subjectId}');

    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.subsubjectwiseAnalysis);
    http
        .post(url,
        body: jsonEncode(
            {
          ConstantValuesVLA.class_idJsonKey: prefs.getString(ConstantValuesVLA.class_idJsonKey),
          ConstantValuesVLA.user_idJsonKey: prefs.getString(ConstantValuesVLA.user_idJsonKey),
          ConstantValuesVLA.boardidJsonKey2: prefs.getString(ConstantValuesVLA.boardidJsonKey),
          "subject_id": widget.subjectId,
        }
     /*       {
              "class_id": prefs.getString(ConstantValuesVLA.class_idJsonKey),
              "subject_id": widget.subjectId,
              "user_id": prefs.getString(ConstantValuesVLA.user_idJsonKey),
              "board_id": prefs.getString(ConstantValuesVLA.boardidJsonKey),
            }*/
        ))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        evaluateSubSubjectList.add(SubSubjectWiseAnalysisModelVLA.fromJson(tutorialVideoListTemp[i]));
        //print(tutorialVideoListTemp[i]);
      }
      setState(() {
        evaluateSubSubjectList;
      });

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
