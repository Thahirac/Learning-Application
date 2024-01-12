import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/evaluate_dash_vla.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/evaluate_page_fragments_vla/assess_kit_quiz_fragments_vla/assess_kit_fragment_vla.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/evaluate_page_fragments_vla/assess_kit_quiz_fragments_vla/mcq_fragment_vla.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/evaluate_page_fragments_vla/assess_kit_quiz_vla.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/learn_page_fragments_vla/beyond_text_learn_vla.dart';
import 'package:vel_app_online/constants_vla/constant_values_vla.dart';
import 'package:vel_app_online/main.dart';
import 'package:vel_app_online/models_vla/assess_kit_model_vla.dart';
import 'package:vel_app_online/models_vla/evaluate_model_vla.dart';
import 'package:vel_app_online/models_vla/puc_each_exercise_model_vla.dart';
import 'package:vel_app_online/puc_vla/after_puc_exercise_vla.dart';
import 'package:vel_app_online/puc_vla/puc_show_subjects_vla.dart';
import 'package:vel_app_online/vidwath_custom_widgets/text_custom_vidwath.dart';

class PUCExerciseTabVLA extends StatefulWidget {
  var thisSetNewScreenFunc;
  String s_id,class_id;

  PUCExerciseTabVLA(this.thisSetNewScreenFunc,this.s_id,this.class_id, {Key? key});

  @override
  State<PUCExerciseTabVLA> createState() => _PUCExerciseTabVLAState();
}

String tid = "";

class _PUCExerciseTabVLAState extends State<PUCExerciseTabVLA> {
  List<PUCEachExerciseModelVLA> assessKitsList = [];
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
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SizedBox  (
        height: screenHeight - 234,
        width: screenWidth,
        child: ListView.builder(
            itemCount: assessKitsList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                child: GestureDetector(
                  onTap: () {
                    tid = assessKitsList[index].tid;
                    widget.thisSetNewScreenFunc(
                        AfterPUCExerciseVLA(widget.thisSetNewScreenFunc));
                  },
                  child: Container(

                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: the5Colors[index % 5],
                         boxShadow: [
                           BoxShadow(
                             offset: Offset(2, 2),
                             blurRadius: 5,
                             color: Color.fromRGBO(0, 0, 0, 0.16),
                           )
                         ]

                     ),
                    padding: const EdgeInsets.all(9),
                    child: TextCustomVidwath(
                      textTCV: assessKitsList[index].topicname,
                      textAlignTCV: TextAlign.left,
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {
    var url = Uri.parse(ConstantValuesVLA.baseURLConstant +
        ConstantValuesVLA.pucExerciseConstant);
    http
        .post(url,
            body: jsonEncode({
              ConstantValuesVLA.user_idJsonKey: prefs.getString(ConstantValuesVLA.user_idJsonKey),
              "pid": widget.class_id,
              "sid": widget.s_id,
            }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        assessKitsList
            .add(PUCEachExerciseModelVLA.fromJson(tutorialVideoListTemp[i]));
      }
      setState(() {
        assessKitsList;
      });
    });
  }
}
