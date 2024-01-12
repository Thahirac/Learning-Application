import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/evaluate_page_fragments_vla/assess_kit_quiz_fragments_vla/pdf_viewer_vla.dart';

import '../../../../constants_vla/constant_values_vla.dart';
import '../../../../main.dart';
import '../../../../models_vla/after_after_assess_kit_model_vla.dart';
import '../../../../models_vla/after_assess_kit_model_vla.dart';
import '../../../../vidwath_custom_widgets/slide_transition_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import 'assess_kit_fragment_vla.dart';

bool fromPDFPage = false;

class AfterAfterAssessKitFragmentVLA extends StatefulWidget {
  var thisSetNewScreenFunc, changeBackToAssess, changeToAfterAssess;
  AfterAssessKitModelVLA afterAssessKitModelVLA;

  AfterAfterAssessKitFragmentVLA(
      this.thisSetNewScreenFunc,
      this.changeBackToAssess,
      this.changeToAfterAssess,
      this.afterAssessKitModelVLA,
      {Key? key});

  @override
  State<AfterAfterAssessKitFragmentVLA> createState() =>
      _AfterAfterAssessKitFragmentVLAState();
}

class _AfterAfterAssessKitFragmentVLAState
    extends State<AfterAfterAssessKitFragmentVLA> {
  List<Widget> widgetLists = [];
  var rng = Random();
  double screenWidth = 0, screenHeight = 0;

  @override
  void initState() {
    super.initState();
    fromPDFPage = true;
    getTutorialVideoAPI();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: screenWidth,
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: widgetLists,
          ),
        ),
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {
    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.afterAfterAssessKitsConstant);
    http
        .post(url,
            body: jsonEncode({
              // "topic_id": "2001", "type": "4"
              ConstantValuesVLA.topic_idJsonKey: IdTopicMaster,
              ConstantValuesVLA.typeJsonKey: widget.afterAssessKitModelVLA.tool_id,
            }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      /*if (tutorialVideoListTemp.length == 1) {
        AfterAfterAssessKitModelVLA temp =
            AfterAfterAssessKitModelVLA.fromJson(tutorialVideoListTemp[0]);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return PDFViewerVLA(
                widget.thisSetNewScreenFunc,
                "https://cdn.vidwathinfra.com/Android_Online/application/" +
                    temp.ContentPath.trim() +
                    "/" +
                    temp.ContentName.trim() +
                    ".pdf",
                temp.DisplayName);
          }),
        );
      } else */
      {
        for (int i = 0; i < tutorialVideoListTemp.length; i++) {
          // https://cdn.vidwathinfra.com/Android_Online/application/Vidwath/CBSE/G10/Maths/NCERT/CG10MNC1.1.pdf
          AfterAfterAssessKitModelVLA temp =
              AfterAfterAssessKitModelVLA.fromJson(tutorialVideoListTemp[i]);
          widgetLists.add(SlideTransitionCustomVidwath(
            (i + 2),
            Offset(0.0, (1.5 * (i + 2))),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return PDFViewerVLA(
                        widget.thisSetNewScreenFunc,
                        "https://vidwathapp.b-cdn.net/Android_Online/application/" +
                            temp.ContentPath.trim() +
                            "/" +
                            temp.ContentName.trim() +
                            ".pdf",
                        temp.DisplayName);
                  }),
                );
              },
              child: Card(
                margin: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/pdf.png",
                      width: 123,
                    ),
                    TextCustomVidwath(
                      textTCV: temp.DisplayName,
                      textColorTCV: ConstantValuesVLA.splashBgColor,
                      fontSizeTCV: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          ));
        }
        setState(() {
          widgetLists;
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
