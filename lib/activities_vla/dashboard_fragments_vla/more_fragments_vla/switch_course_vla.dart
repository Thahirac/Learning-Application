import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/more_fragments_vla/switch_grade_vla.dart';

import '../../../constants_vla/constant_values_vla.dart';
import '../../../main.dart';
import '../../../models_vla/board_model_vla.dart';
import '../../../translation_vla/tr.dart';
import '../../../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/image_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/slide_transition_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/text_custom_vidwath.dart';

class SwitchCourseVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  SwitchCourseVLA(this.thisSetNewScreenFunc, {Key? key});

  @override
  State<SwitchCourseVLA> createState() => _SwitchCourseVLAState();
}

class _SwitchCourseVLAState extends State<SwitchCourseVLA> {
  List<BoardModelVLA> assessKitsList = [];
  var rng = Random();
  double screenWidth = 0, screenHeight = 0;
  List<Widget> gradeWidgetList = [];

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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                DividerCustomVidwath(),
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                      color: ConstantValuesVLA.splashBgColor,
                      borderRadius: BorderRadius.all(const Radius.circular(9))),
                  child: TextCustomVidwath(
                    textTCV: TR.course[languageIndex],
                    fontSizeTCV: 18,
                    textColorTCV: ConstantValuesVLA.whiteColor,
                    fontWeightTCV: FontWeight.bold,
                  ),
                ),
                DividerCustomVidwath(),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: gradeWidgetList,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {

    print('************ REGION *************${prefs.getString(ConstantValuesVLA.regionJsonKey)}');

    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.switchCourseConstant);
    http
        .post(url,
            body: jsonEncode({
              // "boardid": "3", "user_id": "90"
              ConstantValuesVLA.user_idJsonKey: prefs.getString(ConstantValuesVLA.user_idJsonKey),
              ConstantValuesVLA.regionJsonKey: prefs.getString(ConstantValuesVLA.regionJsonKey),
            }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        assessKitsList.add(BoardModelVLA.fromJson(tutorialVideoListTemp[i]));
      }
      for (int i = 0; i < assessKitsList.length; i++) {
        gradeWidgetList.add(SlideTransitionCustomVidwath(
          (i + 2),
          Offset(0.0, (1.5 * (i + 2))),
          GestureDetector(
            onTap: () {
              prefs.setString(ConstantValuesVLA.boardidJsonKey, assessKitsList[i].Board_id);
              prefs.setString(ConstantValuesVLA.BoardNameJsonKey, assessKitsList[i].BoardName);
              prefs.setString(ConstantValuesVLA.BoardThumbnailJsonKey, assessKitsList[i].thumbnail);

              switch (int.parse(assessKitsList[i].Board_id)) {
                case 1:
                  {
                    languageIndex = 1;
                    prefs.setInt("languageIndex", languageIndex);
                  }
                  break;
                case 2:
                  {
                    languageIndex = 0;
                    prefs.setInt("languageIndex", languageIndex);
                  }
                  break;
                case 3:
                  {
                    languageIndex = 0;
                    prefs.setInt("languageIndex", languageIndex);
                  }
                  break;
                case 4:
                  {
                    languageIndex = 2;
                    prefs.setInt("languageIndex", languageIndex);
                  }
                  break;
                case 5:
                  {
                    languageIndex = 0;
                    prefs.setInt("languageIndex", languageIndex);
                  }
                  break;
                default:
                  {
                    languageIndex = 0;
                    prefs.setInt("languageIndex", languageIndex);
                  }
                  break;
              }
              /*
              * ಕನ್ನಡ ಮಾಧ್ಯಮ--1
              * English Medium--2
              * CBSE--3
              * URDU--4
              * PUC--5
              * */


              widget.thisSetNewScreenFunc(
                  Directionality(
                      textDirection: (languageIndex == 2)? TextDirection.ltr : TextDirection.ltr,
                      child: SwitchGradeVLA(widget.thisSetNewScreenFunc)));

              //widget.thisSetNewScreenFunc(SwitchGradeVLA(widget.thisSetNewScreenFunc));
            },
            child: Container(
              width: 153,
              margin: EdgeInsets.all(9),
              padding: EdgeInsets.all(9),
              child: Center(
                child: Column(
                  children: [
                    ImageCustomVidwath(
                      imageUrlICV: assessKitsList[i].thumbnail,
                      heightICV: 153,
                      widthICV: 153,
                    ),
                    TextCustomVidwath(
                      textTCV: assessKitsList[i].BoardName,
                      fontWeightTCV: FontWeight.bold,
                      fontSizeTCV: 14,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
      }
      setState(() {
        gradeWidgetList;
      });
    });
  }

  Future<bool> onBackPressed() {
    listOfWidgetForBack.removeLast();
    widget.thisSetNewScreenFunc(listOfWidgetForBack.last, addToQueue: false);
    return Future.value(false);
  }
}
