import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/learn_page_fragments_vla/digi_ani_mind_fragments_vla/animations_digi_ani_mind_vla.dart';
import 'package:vel_app_online/constants_vla/constant_values_vla.dart';
import 'package:http/http.dart' as http;
import 'package:vel_app_online/main.dart';
import 'package:vel_app_online/models_vla/puc_each_subject_model_vla.dart';
import 'package:vel_app_online/puc_vla/puc_digibooks_and_excercise_vla.dart';
import 'package:vel_app_online/vidwath_custom_widgets/image_custom_vidwath.dart';
import 'package:vel_app_online/vidwath_custom_widgets/text_custom_vidwath.dart';

class PUCShowSubjectsVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  PUCShowSubjectsVLA(this.thisSetNewScreenFunc, {Key? key}) : super(key: key);

  @override
  State<PUCShowSubjectsVLA> createState() => _PUCShowSubjectsVLAState();
}

List<String> listOfPucDataToBePassed = [];

class _PUCShowSubjectsVLAState extends State<PUCShowSubjectsVLA> {
  List<Widget> subjectListWidgets = [];
  double screenWidth = 0, screenHeight = 0;

  @override
  void initState() {
    getSubjectsList();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(backgroundColor: Colors.transparent,
      body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: screenWidth,
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: subjectListWidgets,
          ),
        ),
      )),
    );
  }

  void getSubjectsList() {

    print('**************** CLASS ID *********************${prefs.getString(ConstantValuesVLA.user_idJsonKey)}');
    print('**************** CLASS ID *********************${prefs.getString(ConstantValuesVLA.class_idJsonKey)}');


    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.pucShowSubjectsListConstant);
    http
        .post(url,
            body: jsonEncode(
            {
              ConstantValuesVLA.user_idJsonKey:prefs.getString(ConstantValuesVLA.user_idJsonKey),
              ConstantValuesVLA.class_idJsonKey:prefs.getString(ConstantValuesVLA.class_idJsonKey)
            }

            ))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        PUCEachSubjectModelVLA pucEachSubjectModelVLA = PUCEachSubjectModelVLA.fromJson(tutorialVideoListTemp[i]);
        listOfPucDataToBePassed.add(pucEachSubjectModelVLA.thumbnail);
        listOfPucDataToBePassed.add(pucEachSubjectModelVLA.subjectname);
        listOfPucDataToBePassed.add(pucEachSubjectModelVLA.sid);
        listOfPucDataToBePassed.add(pucEachSubjectModelVLA.classid);
        subjectListWidgets.add(GestureDetector(
          onTap: () {
            widget.thisSetNewScreenFunc(
                PUCDigibooksAndExcerciseVLA(widget.thisSetNewScreenFunc,pucEachSubjectModelVLA.sid,pucEachSubjectModelVLA.classid,pucEachSubjectModelVLA.subjectname));
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(3, 18, 3, 3),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(27),
                  ),
                  child: ImageCustomVidwath(
                    imageUrlICV: pucEachSubjectModelVLA.thumbnail,
                    widthICV: screenWidth / 2.34,
                    heightICV: screenWidth / 2.34 * 294 / 601,
                  ),
                ),
              ],
            ),
          ),
        ));
      }
      setState(() {
        subjectListWidgets;
      });
    });
  }
}
