import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/evaluate_page_fragments_vla/assess_kit_quiz_fragments_vla/after_after_assess_kit_fragment_vla.dart';

import '../../../../constants_vla/constant_values_vla.dart';
import '../../../../main.dart';
import '../../../../models_vla/after_assess_kit_model_vla.dart';
import '../../../../vidwath_custom_widgets/slide_transition_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import '../../evaluate_dash_vla.dart';


class AfterAssessKitFragmentVLA extends StatefulWidget {
  var thisSetNewScreenFunc, changeBackToAssess, changeToAfterAssess;

  AfterAssessKitFragmentVLA(this.thisSetNewScreenFunc, this.changeBackToAssess,
      this.changeToAfterAssess,
      {Key? key});

  @override
  State<AfterAssessKitFragmentVLA> createState() =>
      _AfterAssessKitFragmentVLAState();
}

bool fromAfterAssess = false;

class _AfterAssessKitFragmentVLAState extends State<AfterAssessKitFragmentVLA>
     {
  List<AfterAssessKitModelVLA> assessKitsList = [];
  var rng = Random();
  double screenWidth = 0, screenHeight = 0;
  List<Widget> afterAssessListWidgets = [];

  @override
  void initState() {
    super.initState();
    fromAfterAssess = true;
    getTutorialVideoAPI();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SizedBox(
          height: screenHeight - 234,
          width: screenWidth,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: afterAssessListWidgets,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {
    var url = Uri.parse(ConstantValuesVLA.baseURLConstant +
        ConstantValuesVLA.afterAssessKitsConstant);
    http
        .post(url,
            body: jsonEncode({
              // "subject": "291", "class_id": 210
              ConstantValuesVLA.subjectJsonKey: selectedEvaluateSubject.IdSubjectMaster,
              ConstantValuesVLA.class_idJsonKey: selectedEvaluateSubject.Class_id,
            }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        assessKitsList
            .add(AfterAssessKitModelVLA.fromJson(tutorialVideoListTemp[i]));
      }
      for (int index = 0; index < assessKitsList.length; index++) {
        afterAssessListWidgets.add(SlideTransitionCustomVidwath(
          (index + 2),
          Offset(0.0, (1.5 * index)),
          GestureDetector(
            onTap: () {
              widget.thisSetNewScreenFunc(AfterAfterAssessKitFragmentVLA(
                  widget.thisSetNewScreenFunc,
                  widget.changeBackToAssess,
                  widget.changeToAfterAssess,
                  assessKitsList[index]));
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
                textTCV: assessKitsList[index].tool,
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

  Future<bool> onBackPressed() {
    widget.changeBackToAssess;
    return Future.value(false);
  }
}
