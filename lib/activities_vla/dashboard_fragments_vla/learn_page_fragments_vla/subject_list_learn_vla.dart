// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:deep_pick/deep_pick.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/learn_page_fragments_vla/digi_ani_mind_fragments_vla/science_lab_extra_vla/science_lab_vla.dart';

import '../../../constants_vla/constant_values_vla.dart';
import '../../../main.dart';
import '../../../models_vla/evaluate_model_vla.dart';
import '../../../models_vla/subject_names_model_vla.dart';
import '../../../vidwath_custom_widgets/image_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/show_less_vla.dart';
import '../../../vidwath_custom_widgets/show_more_vla.dart';
import '../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import '../evaluate_dash_vla.dart';
import 'digi_ani_mind_fragments_vla/digi_ani_mind_tabs_vla.dart';
import 'digi_ani_mind_fragments_vla/science_lab_extra_vla/extra_resource_vla.dart';

class SubjectListLearnVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  SubjectListLearnVLA(this.thisSetNewScreenFunc, {Key? key}) : super(key: key);

  @override
  State<SubjectListLearnVLA> createState() => _SubjectListLearnVLAState();
}

class _SubjectListLearnVLAState extends State<SubjectListLearnVLA> {
  List<Widget> subjectsList = [];
  bool showFull = false;
  double heightOfSubjects = 36;
  int subjectLimit = 0;

  double widthIs = 0;

  @override
  void initState() {
    super.initState();
    getSubjectNamesAPI();
  }

  @override
  Widget build(BuildContext context) {
    widthIs = MediaQuery.of(context).size.width;
    return Container(
      width: widthIs,
      child: showFull
          ? Column(
              children: [
                SizedBox(
                  width: widthIs,
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    children: subjectsList,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    doTheFlip();
                  },
                  child: const ShowLessVLA(),
                ),
              ],
            )
          : Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 36.0,
                    maxHeight: heightOfSubjects,
                  ),
                  child: SizedBox(
                    width: widthIs,
                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      children: subjectsList.sublist(0, subjectLimit),
                    ),
                  ),
                ),
                (subjectsList.length > 8)
                    ? GestureDetector(
                        onTap: () {
                          doTheFlip();
                        },
                        child: ShowMoreVLA(),
                      )
                    : Container(),
              ],
            ),
    );
  }

  Future<void> getSubjectNamesAPI() async {

  // print('************* CLASS ID******************${prefs.getString(ConstantValuesVLA.class_idJsonKey)}');
 //  print('************* REGION ******************${prefs.getString(ConstantValuesVLA.regionJsonKey)}');




    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.subjectNamesConstant);
    //print("print(jsonEncod");
    /*print(jsonEncode({
      ConstantValuesVLA.class_idJsonKey:
      prefs.getString(ConstantValuesVLA.class_idJsonKey),
      ConstantValuesVLA.regionJsonKey:
      prefs.getString(ConstantValuesVLA.regionJsonKey)
    }).toString());*/
    http
        .post(url,
            body: jsonEncode({
              ConstantValuesVLA.class_idJsonKey: prefs.getString(ConstantValuesVLA.class_idJsonKey),
              ConstantValuesVLA.regionJsonKey: prefs.getString(ConstantValuesVLA.regionJsonKey)
            }))
        .then((value) {
      List<dynamic> subjectListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < subjectListTemp.length; i++) {
        SubjectNamesModelVLA subjectNamesModelVLA =
            SubjectNamesModelVLA.fromJson(subjectListTemp[i]);
        subjectsList.add(GestureDetector(
          onTap: () {
            singleSubjectSubscriptionIdIs = subjectNamesModelVLA.IdSubjectMaster;
            selectedEvaluateSubject = EvaluateModelVLA(subjectNamesModelVLA.Class_id, subjectNamesModelVLA.image, [],
                subjectNamesModelVLA.SubjectName,
                subjectNamesModelVLA.subject_code,
                subjectNamesModelVLA.IdSubjectMaster);
            if (subjectNamesModelVLA.SubjectName.contains("Science Lab") ||  subjectNamesModelVLA.SubjectName.contains("سائنسی تجربہ گاہ ") ||  subjectNamesModelVLA.SubjectName.contains("ವಿಜ್ಞಾನ ಪ್ರಯೋಗಾಲಯ")){
              widget.thisSetNewScreenFunc(
                  ScienceLabVLA(widget.thisSetNewScreenFunc));
            } else if (subjectNamesModelVLA.SubjectName.contains(
                "Extra Resources") ||  subjectNamesModelVLA.SubjectName.contains("اضافی ذرائع ") || subjectNamesModelVLA.SubjectName.contains("ಹೆಚ್ಚುವರಿ ಸಂಪನ್ಮೂಲಗಳು")) {
              widget.thisSetNewScreenFunc(
                  ExtraResourceVLA(widget.thisSetNewScreenFunc));
            } else {
              widget.thisSetNewScreenFunc(
                  DigiAniMindTabsVLA(widget.thisSetNewScreenFunc));
            }
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
            width: 72,
            child: Column(
              children: [
                ImageCustomVidwath(
                  imageUrlICV: subjectNamesModelVLA.image,
                  heightICV: 80,
                  widthICV: 100,
                  aboveImageICV: subjectNamesModelVLA.SubjectName,
                ),
                TextCustomVidwath(
                  textTCV: subjectNamesModelVLA.SubjectName,
                  fontSizeTCV: 9.9,
                  fontWeightTCV: FontWeight.w400,
                )
              ],
            ),
          ),
        ));
        subjectLimit = subjectsList.length;
        if (subjectsList.length < 5) {
          heightOfSubjects = 153;
        } else if (subjectsList.length < 9) {
          heightOfSubjects = 252;
        } else {
          subjectLimit = 8;
        }
        setState(() {
          subjectsList;
        });
      }
    });
  }

  void doTheFlip() {
    showFull = !showFull;
    setState(() {
      showFull;
    });
  }
}
