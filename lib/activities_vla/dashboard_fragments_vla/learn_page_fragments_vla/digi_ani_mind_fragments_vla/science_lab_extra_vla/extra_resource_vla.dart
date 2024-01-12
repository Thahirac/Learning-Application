import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../../../../constants_vla/constant_values_vla.dart';
import '../../../../../main.dart';
import '../../../../../models_vla/extra_resource_model_vla.dart';
import '../../../../../vidwath_custom_widgets/slide_transition_custom_vidwath.dart';
import '../../../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import '../../../evaluate_dash_vla.dart';
import '../../../evaluate_page_fragments_vla/assess_kit_quiz_fragments_vla/pdf_viewer_vla.dart';


class ExtraResourceVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  ExtraResourceVLA(this.thisSetNewScreenFunc, {Key? key});

  @override
  State<ExtraResourceVLA> createState() => _ExtraResourceVLAState();
}

class _ExtraResourceVLAState extends State<ExtraResourceVLA> {
  List<Widget> widgetLists = [];
  var rng = Random();
  double screenWidth = 0, screenHeight = 0;

  List<Color> the6Colors = [
    Color.fromRGBO(203, 246, 241, 1.0),
    Color.fromRGBO(252, 245, 233, 1.0),
    Color.fromRGBO(250, 237, 229, 1.0),
    Color.fromRGBO(225, 226, 252, 1.0),
    Color.fromRGBO(248, 221, 243, 1.0),
    Color.fromRGBO(249, 225, 244, 1.0),
  ];

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
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child:   SizedBox(
          height: screenHeight - 198,
          width: screenWidth,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: widgetLists,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {
    var url = Uri.parse(
        ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.extraResource);
    http
        .post(url,
            body: jsonEncode({
              "id_parent": selectedEvaluateSubject.subject_code,
              ConstantValuesVLA.user_idJsonKey: prefs.getString(ConstantValuesVLA.user_idJsonKey),
              ConstantValuesVLA.mediumJsonKey: prefs.getString(ConstantValuesVLA.boardidJsonKey)
            }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        // https://cdn.vidwathinfra.com/Android_Online/application/Vidwath/CBSE/G10/Maths/NCERT/CG10MNC1.1.pdf
        ExtraResourceModelVLA extraResourceModelVLA =
            ExtraResourceModelVLA.fromJson(tutorialVideoListTemp[i]);
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
                      "${ConstantValuesVLA.videoPlayerBaseURL}${extraResourceModelVLA.contentPath
                              .toString()
                              .trim()}/${extraResourceModelVLA.filename.toString().trim()}${extraResourceModelVLA.format.toString().trim()}",
                      extraResourceModelVLA.conceptName.toString().trim());
                }),
              );
            },
            child:
            Container(
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
                        color: the6Colors[i % 5],
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    child: Align(
                      alignment: (languageIndex == 2)? Alignment.centerRight : Alignment.centerLeft ,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8),
                        child: TextCustomVidwath(
                          textTCV:  extraResourceModelVLA.conceptName.toString(),
                          fontSizeTCV: 14.0,
                        ),
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
        widgetLists;
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
