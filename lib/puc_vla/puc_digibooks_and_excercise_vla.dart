// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/learn_dash_vla.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/study_lab_fragments_vla/e_books_study_lab_vla.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/study_lab_fragments_vla/tutorial_videos_study_lab_vla.dart';
import 'package:vel_app_online/constants_vla/constant_values_vla.dart';
import 'package:vel_app_online/main.dart';
import 'package:vel_app_online/puc_vla/puc_digibooks_tab_vla.dart';
import 'package:vel_app_online/puc_vla/puc_exercise_tab_vla.dart';
import 'package:vel_app_online/translation_vla/tr.dart';
import 'package:vel_app_online/vidwath_custom_widgets/each_tab_custom_vidwath.dart';
import 'package:vel_app_online/vidwath_custom_widgets/text_custom_vidwath.dart';

class PUCDigibooksAndExcerciseVLA extends StatefulWidget {
  var thisSetNewScreenFunc;
  String s_id, class_id, subject_name;

  PUCDigibooksAndExcerciseVLA(
      this.thisSetNewScreenFunc, this.s_id, this.class_id, this.subject_name,
      {Key? key})
      : super(key: key);

  @override
  State<PUCDigibooksAndExcerciseVLA> createState() =>
      _PUCDigibooksAndExcerciseVLAState();
}

class _PUCDigibooksAndExcerciseVLAState
    extends State<PUCDigibooksAndExcerciseVLA> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: 2, vsync: this, initialIndex: pucTabInitialIndex);
    tabController.addListener(() {
      pucTabInitialIndex = tabController.index;
      setState(() {
        pucTabInitialIndex;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Align(
              alignment: Alignment.center,
              child: TextCustomVidwath(

                textTCV: "${widget.subject_name}",
                textColorTCV: ConstantValuesVLA.blackTextColor,
                fontSizeTCV: 20,
                fontWeightTCV: FontWeight.bold,
                textAlignTCV: TextAlign.center

              ),
            ),
            bottom: TabBar(
              controller: tabController,
              tabs: [
                EachTabCustomVidwath(
                    TR.digibook[languageIndex], pucTabInitialIndex == 0),
                EachTabCustomVidwath("Exercise", pucTabInitialIndex == 1),
              ],
            ),
          ),
          body: TabBarView(
            controller: tabController,
            children: [
              PUCDigibooksTabVLA(
                  widget.thisSetNewScreenFunc, widget.s_id, widget.class_id),
              PUCExerciseTabVLA(
                  widget.thisSetNewScreenFunc, widget.s_id, widget.class_id)
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onBackPressed() {
    //widget.thisSetNewScreenFunc(LearnDashVLA(widget.thisSetNewScreenFunc));
    listOfWidgetForBack.removeLast();
    widget.thisSetNewScreenFunc(listOfWidgetForBack.last, addToQueue: false);
    return Future.value(false);
  }
}
