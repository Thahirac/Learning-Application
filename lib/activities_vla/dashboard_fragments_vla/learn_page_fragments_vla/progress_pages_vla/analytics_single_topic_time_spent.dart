import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vel_app_online/vidwath_custom_widgets/divider_custom_vidwath.dart';

import '../../../../constants_vla/constant_values_vla.dart';
import '../../../../main.dart';
import '../../../../models_vla/analyticsgetsingletopic_model_vla.dart';
import '../../../../models_vla/sub_subject_wise_analysis_model_vla.dart';
import '../../../../models_vla/subject_wise_analysis_model_vla.dart';
import '../../../../translation_vla/tr.dart';
import '../../../../vidwath_custom_widgets/image_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import 'each_subject_analysis_vla.dart';

class AnalyticsSingleTopicTimeSpendVLA extends StatefulWidget {
  var thisSetNewScreenFunc;
  final String subjectId,topicId,topicName;

  AnalyticsSingleTopicTimeSpendVLA(this.thisSetNewScreenFunc,this.subjectId,this.topicId,this.topicName, {Key? key});

  @override
  State<AnalyticsSingleTopicTimeSpendVLA> createState() => _AnalyticsSingleTopicTimeSpendVLAState();
}

late SubjectWiseAnalysisModelVLA subjectWiseAnalysisModelVLA;

class _AnalyticsSingleTopicTimeSpendVLAState extends State<AnalyticsSingleTopicTimeSpendVLA> {

  Widget noDataImage = Container();
  List<AnalyticsgetsingletopicModal> analyticssingleTopic = [];

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

    Future.delayed(const Duration(seconds: 0), () {
      appBarTitle = widget.topicName;
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
                child: (analyticssingleTopic.isNotEmpty) ?
                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: analyticssingleTopic.length,
                    itemBuilder: (context, index) {
                      intToTimeLeft(analyticssingleTopic[index].type![index].duration.toInt());
                      return Container(
                        margin: EdgeInsets.all(12),
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
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(left: 15,top: 20,bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      TextCustomVidwath(
                                        textTCV: '${analyticssingleTopic[index].type?[index].typeName}',
                                        fontSizeTCV: 16,
                                        fontWeightTCV: FontWeight.w600,
                                        textColorTCV: Colors.teal,
                                      ),
                                    ],
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
                          ],
                        ),
                      );
                    }):
                Container(
                  child: noDataImage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {

    print('****** USER ID ***********${prefs.getString(ConstantValuesVLA.user_idJsonKey)}');
    print('****** BOARD ID ***********${prefs.getString(ConstantValuesVLA.boardidJsonKey)}');
    print('****** SUBJECT ID ***********${widget.subjectId}');
    print('****** TOPIC ID ***********${widget.topicId}');

    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.singleaftersubjectwiseAnalysis);
   http.post(url,
        body: jsonEncode({
          ConstantValuesVLA.user_idJsonKey: prefs.getString(ConstantValuesVLA.user_idJsonKey),
          ConstantValuesVLA.boardidJsonKey: prefs.getString(ConstantValuesVLA.boardidJsonKey),
          "subject_id": widget.subjectId,
          "topic_id":widget.topicId,
        }))
        .then((value) {

     List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();

      print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^$tutorialVideoListTemp');

      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        analyticssingleTopic.add(AnalyticsgetsingletopicModal.fromJson(tutorialVideoListTemp[i]));
        //print(tutorialVideoListTemp[i]);
      }
     if (analyticssingleTopic.isEmpty) {
       noDataImage = Image.asset("assets/ic_no_record_found.png",);
     }
      setState(() {
        analyticssingleTopic;
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
