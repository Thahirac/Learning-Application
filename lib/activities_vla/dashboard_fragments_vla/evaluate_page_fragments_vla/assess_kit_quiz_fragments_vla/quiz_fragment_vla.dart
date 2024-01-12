import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/evaluate_page_fragments_vla/assess_kit_quiz_fragments_vla/mcq_fragment_vla.dart';

import '../../../../constants_vla/constant_values_vla.dart';
import '../../../../main.dart';
import '../../../../models_vla/assess_kit_model_vla.dart';
import '../../../../vidwath_custom_widgets/slide_transition_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import '../../evaluate_dash_vla.dart';
import 'assess_kit_fragment_vla.dart';


class QuizFragmentVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  QuizFragmentVLA(this.thisSetNewScreenFunc, {Key? key});

  @override
  State<QuizFragmentVLA> createState() => _QuizFragmentVLAState();
}

String selectedTopic = "";

class _QuizFragmentVLAState extends State<QuizFragmentVLA>
     {
  List<AssessKitModelVLA> assessKitsList = [];
  var rng = Random();
  double screenWidth = 0, screenHeight = 0;

  List<Widget> quizWidgetLit = [];

  @override
  void initState() {
    super.initState();
    getTutorialVideoAPI();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SizedBox(
        height: screenHeight - 234,
        width: screenWidth,
        child: SingleChildScrollView(
          physics:  BouncingScrollPhysics(),
          child: Column(
            children: quizWidgetLit,
          ),
        ),
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {
    var url = Uri.parse(ConstantValuesVLA.baseURLConstant +
        ConstantValuesVLA.assessKitsConstant);
    http
        .post(url,
            body: jsonEncode({
              // "subject_id": "191"
              ConstantValuesVLA.subject_idJsonKey:
                  selectedEvaluateSubject.IdSubjectMaster
            }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        assessKitsList
            .add(AssessKitModelVLA.fromJson(tutorialVideoListTemp[i]));
      }
      for (int index = 0; index < assessKitsList.length; index++) {
        quizWidgetLit.add(SlideTransitionCustomVidwath(
          (index + 1),
          Offset(0.0, (1.5 * (index + 2))),
          GestureDetector(
            onTap: () {
              selectedTopic = assessKitsList[index].TopicName;
              IdTopicMaster = assessKitsList[index].IdTopicMaster;
              assessKitsListMCQFragment = [];
              /*widget.thisSetNewScreenFunc(
                  MCQFragmentVLA(widget.thisSetNewScreenFunc));*/
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MCQFragmentVLA(widget.thisSetNewScreenFunc)),
              );
            },
            child: Container(
              width: screenWidth,
              margin: ConstantValuesVLA.assessKitQuizMargin,
              padding: const EdgeInsets.all(9),
              decoration:
                  BoxDecoration(color: the5Colors[index % 5], boxShadow: [
                BoxShadow(
                  blurRadius: .5,
                  offset: Offset(.25, .6),
                  color: Colors.blueGrey,
                )
              ]),
              child: TextCustomVidwath(
                textTCV: assessKitsList[index].TopicName,
                textAlignTCV: (languageIndex == 2)? TextAlign.right : TextAlign.left,
                fontSizeTCV: 14.0,
              ),
            ),
          ),
        ));
      }
      setState(() {
        assessKitsList;
      });
    });
  }
}
