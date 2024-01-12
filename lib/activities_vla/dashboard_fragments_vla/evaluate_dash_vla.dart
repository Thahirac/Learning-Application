import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../constants_vla/constant_values_vla.dart';
import '../../main.dart';
import '../../models_vla/evaluate_model_vla.dart';
import '../../translation_vla/tr.dart';
import '../../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../../vidwath_custom_widgets/image_custom_vidwath.dart';
import '../../vidwath_custom_widgets/slide_transition_custom_vidwath.dart';
import '../../vidwath_custom_widgets/text_custom_vidwath.dart';
import '../dashboard_vla.dart';
import 'evaluate_page_fragments_vla/assess_kit_quiz_vla.dart';

class EvaluateDashVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  EvaluateDashVLA(this.thisSetNewScreenFunc, {Key? key});

  @override
  State<EvaluateDashVLA> createState() => _EvaluateDashVLAState();
}

late EvaluateModelVLA selectedEvaluateSubject;

class _EvaluateDashVLAState extends State<EvaluateDashVLA> {
  List<EvaluateModelVLA> evaluateSubjectList = [];
  var rng = Random();
  double screenWidth = 0, screenHeight = 0;
  List<Widget> evaluateDashList = [];

  @override
  void initState() {
    getTutorialVideoAPI();
    currentIndexOfBottomPressed = 2;
    setState(() {
      currentIndexOfBottomPressed;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: appBarHeight,
              child: Center(
                child: TextCustomVidwath(
                  textTCV: TR.you[languageIndex],
                  fontWeightTCV: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight - 198,
              width: screenWidth,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: evaluateDashList,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {
    if (kDebugMode) {
      //print('************^^^^^^^^^^^^^^^^${prefs.getString(ConstantValuesVLA.class_idJsonKey)}');
      //print('************^^^^^^^^^^^^^^^^${prefs.getString(ConstantValuesVLA.regionJsonKey)}');
    }

    var url = Uri.parse(
        ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.evaluateConstant);
    http
        .post(url,
            body: jsonEncode({
              ConstantValuesVLA.class_idJsonKey: prefs.getString(ConstantValuesVLA.class_idJsonKey),
              ConstantValuesVLA.regionJsonKey: prefs.getString(ConstantValuesVLA.regionJsonKey)
            }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        evaluateSubjectList.add(EvaluateModelVLA.fromJson(tutorialVideoListTemp[i]));
      }
      for (int index = 0; index < evaluateSubjectList.length; index++) {
        evaluateDashList.add(SlideTransitionCustomVidwath(
          // (evaluateSubjectList.length - index),
          // const Offset(1.5, 0.0),
          (evaluateSubjectList.length - index).abs(),
          const Offset(-1.5, 0.0),
          GestureDetector(
            onTap: () {
              selectedEvaluateSubject = evaluateSubjectList[index];
              widget.thisSetNewScreenFunc(
                  AssessKitQuizVLA(widget.thisSetNewScreenFunc));
            },
            child: Container(
              margin: EdgeInsets.all(9),
              child: Column(
                children: [
                  Container(
                    height: 75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: the5Colors[index % 5],
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(1, 1),
                              blurRadius: 1,
                              color: Color.fromRGBO(55, 71, 79, .3))
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: ImageCustomVidwath(
                              imageUrlICV: evaluateSubjectList[index].image,
                              widthICV: 72,
                              heightICV: 72,
                              boxFit: BoxFit.fitHeight,
                              aboveImageICV: evaluateSubjectList[index].SubjectName,
                            ),
                          ),
                          Column(
                            children: [
                              DividerCustomVidwath(
                                dividerHeight: 5,
                              ),
                              TextCustomVidwath(
                                textTCV: evaluateSubjectList[index]
                                        .notes[0]
                                        .counts
                                        .toString() +
                                    " " +
                                    TR.count_chapter[languageIndex],
                              ),
                              const Divider(
                                height: 5,
                              ),
                              getDSERTorNCERT(
                                  evaluateSubjectList[index].Class_id,
                                  evaluateSubjectList[index].SubjectName),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      TextCustomVidwath(
                        textTCV: evaluateSubjectList[index].SubjectName,
                        textAlignTCV: TextAlign.start,
                        fontSizeTCV: 14.0,
                        fontWeightTCV: FontWeight.w600,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
      }
      setState(() {
        evaluateDashList;
      });
    });
  }

  getDSERTorNCERT(String classIDStr, String subjcets) {
    int classid = int.parse(classIDStr);
    String strDSERTorNCERT = "";

    if (classid == 210 ||
        classid == 209 ||
        classid == 208 ||
        classid == 207 ||
        classid == 206 ||
        classid == 205 ||
        classid == 204 ||
        classid == 203 ||
        classid == 202 ||
        classid == 201) {
      if (subjcets.contains("English") || subjcets.contains("ಕನ್ನಡ")) {
        strDSERTorNCERT = TR.evaluate_ncert[languageIndex];
        //holder.types.setText(R.string.evaluate_ncert);
      } else {
        strDSERTorNCERT = TR.evaluate_pdfs[languageIndex];
        //holder.types.setText(R.string.evaluate_pdfs);
      }
    } else {
      if (subjcets.contains("English") ||
          subjcets.contains("ಕನ್ನಡ") ||
          subjcets.contains("اُردو  ") ||
          subjcets.contains("हिंदी 03")) {
        strDSERTorNCERT = TR.evaluate_dsert[
            languageIndex]; //holder.types.setText(R.string.evaluate_dsert);
      } else {
        strDSERTorNCERT = TR.evaluate_dsrt_pdfs[
            languageIndex]; //holder.types.setText(R.string.evaluate_dsrt_pdfs);
      }
    }
    return Row(
      children: [
        Container(
            width: MediaQuery.of(context).size.width - 117,
            margin: EdgeInsets.all(5),
            child: TextCustomVidwath(
              textTCV: strDSERTorNCERT,
              fontSizeTCV: 10,
              textColorTCV: ConstantValuesVLA.greyTextColor,
              textAlignTCV: TextAlign.center,
            )),
      ],
    );
  }

  Future<bool> onBackPressed() {
    //widget.thisSetNewScreenFunc(LearnDashVLA(widget.thisSetNewScreenFunc));
    listOfWidgetForBack.removeLast();
    widget.thisSetNewScreenFunc(listOfWidgetForBack.last, addToQueue: false);
    return Future.value(false);
  }
}
