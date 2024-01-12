import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../../../../constants_vla/constant_values_vla.dart';
import '../../../../../main.dart';
import '../../../../../models_vla/science_lab_model_vla.dart';
import '../../../../../platform_dependent_vla/video_player_vla/andr_ios_web_vla/custom_video_player_vla.dart';
import '../../../evaluate_dash_vla.dart';

class ScienceLabVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  ScienceLabVLA(this.thisSetNewScreenFunc, {Key? key});

  @override
  State<ScienceLabVLA> createState() => _ScienceLabVLAState();
}

class _ScienceLabVLAState extends State<ScienceLabVLA> {
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
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: widgetLists,
        ),
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {
    var url = Uri.parse(
        ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.scienceLab);
    http
        .post(url,
            body: jsonEncode({
              "id_parent": selectedEvaluateSubject.subject_code,
              ConstantValuesVLA.user_idJsonKey:
                  prefs.getString(ConstantValuesVLA.user_idJsonKey),
              ConstantValuesVLA.class_idJsonKey:
                  prefs.getString(ConstantValuesVLA.class_idJsonKey),
              ConstantValuesVLA.mediumJsonKey:
                  prefs.getString(ConstantValuesVLA.boardidJsonKey)
            }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        // https://cdn.vidwathinfra.com/Android_Online/application/Vidwath/CBSE/G10/Maths/NCERT/CG10MNC1.1.pdf
        ScienceLabModelVLA scienceLabModelVLA =
            ScienceLabModelVLA.fromJson(tutorialVideoListTemp[i]);
        widgetLists.add(Container(
          height: (languageIndex == 1)? 210 :195,
          width: 170,
          margin: EdgeInsets.all(2),
          padding: EdgeInsets.all(2),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return CustomVideoPlayerVidwath(
                      widget.thisSetNewScreenFunc,
                      ConstantValuesVLA.videoPlayerBaseURL +
                          scienceLabModelVLA.contentPath.toString().trim() +
                          "/" +
                          scienceLabModelVLA.filename.toString().trim() +
                          scienceLabModelVLA.format.toString().trim());
                }),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/video_icon.png",
                      width: 110,
                      height: 120,
                    ),


                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 6,right: 6),
                      child: Text(
                        scienceLabModelVLA.conceptName.toString().trim(),
                        textAlign: TextAlign.center,style: TextStyle(fontSize: 12.0,color: Colors.blue),
                      ),
                    ),
                  ],
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
