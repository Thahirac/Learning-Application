import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/evaluate_page_fragments_vla/assess_kit_quiz_fragments_vla/pdf_viewer_vla.dart';
import 'package:vel_app_online/constants_vla/constant_values_vla.dart';
import 'package:vel_app_online/main.dart';
import 'package:vel_app_online/models_vla/after_exercise_tab_model_vla.dart';
import 'package:vel_app_online/puc_vla/puc_exercise_tab_vla.dart';
import 'package:vel_app_online/vidwath_custom_widgets/slide_transition_custom_vidwath.dart';
import 'package:vel_app_online/vidwath_custom_widgets/text_custom_vidwath.dart';

class AfterPUCExerciseVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  AfterPUCExerciseVLA(this.thisSetNewScreenFunc, {Key? key});

  @override
  State<AfterPUCExerciseVLA> createState() => _AfterPUCExerciseVLAState();
}

class _AfterPUCExerciseVLAState extends State<AfterPUCExerciseVLA> {
  List<Widget> widgetLists = [];
  var rng = Random();
  double screenWidth = 0, screenHeight = 0;

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
    var url = Uri.parse(ConstantValuesVLA.baseURLConstant +
        ConstantValuesVLA.pucAfterExerciseConstant);
    http
        .post(url,
            body: jsonEncode({
              ConstantValuesVLA.user_idJsonKey: prefs.getString(ConstantValuesVLA.user_idJsonKey),
              "tid": tid,
            }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        // https://cdn.vidwathinfra.com/Android_Online/application/Vidwath/CBSE/G10/Maths/NCERT/CG10MNC1.1.pdf
        AfterExerciseTabModelVLA temp =
            AfterExerciseTabModelVLA.fromJson(tutorialVideoListTemp[i]);
        widgetLists.add(SlideTransitionCustomVidwath(
          (i + 2),
          Offset(0.0, (1.5 * (i + 2))),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return  PDFViewerVLA(
                      widget.thisSetNewScreenFunc,
                      "https://vidwathapp.b-cdn.net/Android_Online/application/" +
                          temp.contentpath.trim() +
                          "/" +
                          temp.filename.trim() +
                          ".pdf",
                      temp.displayname);
                }),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
              child: SizedBox(
                width: 160,
                height: 180,
                child: Card(
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/pdf.png",
                          width: 123,
                        ),
                        TextCustomVidwath(
                          textTCV: temp.displayname,
                          textColorTCV: ConstantValuesVLA.splashBgColor,
                          fontSizeTCV: 14,
                        ),
                      ],
                    ),
                  ),
                ),
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
