import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../../constants_vla/constant_values_vla.dart';
import '../../../main.dart';
import '../../../models_vla/after_test_model_vla.dart';
import '../../../translation_vla/tr.dart';
import '../../../vidwath_custom_widgets/slide_transition_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import 'after_after_test_vla.dart';

class AfterTestVLA extends StatefulWidget {
  var thisSetNewScreenFunc;
  String class_idSelected = "", session_idSelected = "", sessions_Selected = "";

  AfterTestVLA(this.thisSetNewScreenFunc, this.class_idSelected,
      this.session_idSelected, this.sessions_Selected,
      {Key? key});

  @override
  State<AfterTestVLA> createState() => _AfterTestVLAState();
}

class _AfterTestVLAState extends State<AfterTestVLA> {
  List<AfterTestModelVLA> evaluateSubjectList = [];
  var rng = Random();
  double screenWidth = 0, screenHeight = 0;

  List<Widget> afterTestWidgetList = [];

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
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: appBarHeight,
              child: Center(
                child: TextCustomVidwath(
                  textTCV: widget.sessions_Selected,
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
                  children: afterTestWidgetList,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {

    print('**************CLASS ID***************${widget.class_idSelected}');

    print('**************SESSION ID***************${widget.session_idSelected}');



    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.afterTestConstant);
    http
        .post(url,
            body: jsonEncode({
              ConstantValuesVLA.class_idJsonKey: widget.class_idSelected,
              ConstantValuesVLA.session_idJsonKey: widget.session_idSelected
            }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        evaluateSubjectList
            .add(AfterTestModelVLA.fromJson(tutorialVideoListTemp[i]));
      }
      for (int index = 0; index < evaluateSubjectList.length; index++) {
        afterTestWidgetList.add(SlideTransitionCustomVidwath(
          (index + 1),
          Offset(0.0, (-1.5 * (index + 2))),
          GestureDetector(
            onTap: () {
              widget.thisSetNewScreenFunc(AfterAfterTestVLA(
                  widget.thisSetNewScreenFunc,
                  evaluateSubjectList[index].id,
                  evaluateSubjectList[index].session_id,
                  evaluateSubjectList[index].SubjectName));
            },
            child: Container(
              decoration: BoxDecoration(),
              margin: EdgeInsets.all(12),
              child: Column(
                children: [
                  Container(
                    height: 42,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 1.5,
                            offset: Offset(1, 1),
                            color: Color.fromRGBO(55, 71, 79, .3),
                          )
                        ],
                        color: the5Colors[index % 5],
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    child: Align(
                      child: TextCustomVidwath(
                        textTCV: evaluateSubjectList[index].SubjectName,
                        fontSizeTCV: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
      }
      setState(() {
        evaluateSubjectList;
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
    /*widget.thisSetNewScreenFunc(AssessKitQuizVLA(widget.thisSetNewScreenFunc));
    widget.changeToAfterAssess;*/
    listOfWidgetForBack.removeLast();
    widget.thisSetNewScreenFunc(listOfWidgetForBack.last, addToQueue: false);
    return Future.value(false);
  }
}
