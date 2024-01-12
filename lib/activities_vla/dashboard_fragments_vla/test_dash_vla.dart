import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/test_fragments_vla/after_after_test_pdf_vla.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/test_fragments_vla/after_after_test_vla.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/test_fragments_vla/after_test_vla.dart';
import 'package:vel_app_online/activities_vla/dashboard_vla.dart';
import 'package:vel_app_online/constants_vla/constant_values_vla.dart';
import 'package:vel_app_online/main.dart';
import 'package:vel_app_online/models_vla/test_model_vla.dart';
import 'package:vel_app_online/translation_vla/tr.dart';
import 'package:vel_app_online/vidwath_custom_widgets/image_custom_vidwath.dart';
import 'package:vel_app_online/vidwath_custom_widgets/slide_transition_custom_vidwath.dart';
import 'package:vel_app_online/vidwath_custom_widgets/text_custom_vidwath.dart';

class TestDashVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  TestDashVLA(this.thisSetNewScreenFunc, {Key? key});

  @override
  State<TestDashVLA> createState() => _TestDashVLAState();
}

late TestModelVLA selectedEvaluateSubject;

class _TestDashVLAState extends State<TestDashVLA> {
  List<TestModelVLA> evaluateSubjectList = [];
  var rng = Random();
  double screenWidth = 0, screenHeight = 0;
  List<Widget> testWidgetList = [];

  @override
  void initState() {
    getTutorialVideoAPI();
    currentIndexOfBottomPressed = 3;
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
                  fontWeightTCV: FontWeight.w400,
                  textTCV: TR.practice[languageIndex],
                ),
              ),
            ),
            SizedBox(
              height: screenHeight - 198,
              width: screenWidth,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: testWidgetList,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {

    print('*************** CLASS ID *******************${prefs.getString(ConstantValuesVLA.class_idJsonKey)}');

    var url = Uri.parse(
        ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.testConstant);
    http
        .post(url,
            body: jsonEncode({
              ConstantValuesVLA.class_idJsonKey: prefs.getString(ConstantValuesVLA.class_idJsonKey)
            }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        evaluateSubjectList
            .add(TestModelVLA.fromJson(tutorialVideoListTemp[i]));
      }
      for (int index = 0; index < evaluateSubjectList.length; index++) {
        testWidgetList.add(SlideTransitionCustomVidwath(
          (evaluateSubjectList.length - index).abs(),
          const Offset(-1.5, 0.0),
          GestureDetector(
            onTap: () {
              selectedEvaluateSubject = evaluateSubjectList[index];
              evaluateSubjectList[index].id=="1" || evaluateSubjectList[index].id=="2" || evaluateSubjectList[index].id=="3" || evaluateSubjectList[index].id=="4" || evaluateSubjectList[index].id=="5" || evaluateSubjectList[index].id=="6" || evaluateSubjectList[index].id=="7" || evaluateSubjectList[index].id=="8" || evaluateSubjectList[index].id=="13" || evaluateSubjectList[index].id=="14"  ? widget.thisSetNewScreenFunc(AfterTestVLA(
                  widget.thisSetNewScreenFunc,
                  evaluateSubjectList[index].class_id,
                  evaluateSubjectList[index].id,
                  evaluateSubjectList[index].sessions)):
              widget.thisSetNewScreenFunc(AfterAfterTestPDFVLA(
                  widget.thisSetNewScreenFunc,
                  evaluateSubjectList[index].class_id,
                  evaluateSubjectList[index].id));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: the5Colors[index % 5],
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(1, 1),
                        blurRadius: 1,
                        color: Color.fromRGBO(55, 71, 79, .3))
                  ]),
              height: 72,
              margin: const EdgeInsets.all(9),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(14)),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(14)),
                      child: ImageCustomVidwath(
                        imageUrlICV: evaluateSubjectList[index].thumbnails,
                        widthICV: 72,
                        heightICV: 72,
                        aboveImageICV: evaluateSubjectList[index].sessions,
                        boxFit: BoxFit.fitHeight,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: (languageIndex == 2)? Alignment.centerRight:  Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(3, 3, 27, 3),
                          child: TextCustomVidwath(
                            textTCV: evaluateSubjectList[index].sessions,
                            fontSizeTCV: 14.0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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
    //widget.thisSetNewScreenFunc(LearnDashVLA(widget.thisSetNewScreenFunc));
    listOfWidgetForBack.removeLast();
    widget.thisSetNewScreenFunc(listOfWidgetForBack.last, addToQueue: false);
    return Future.value(false);
  }
}
