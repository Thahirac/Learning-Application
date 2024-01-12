// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/study_lab_fragments_vla/e_books_study_lab_vla.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/study_lab_fragments_vla/tutorial_videos_study_lab_vla.dart';

import '../../constants_vla/constant_values_vla.dart';
import '../../main.dart';
import '../../translation_vla/tr.dart';
import '../../vidwath_custom_widgets/each_tab_custom_vidwath.dart';
import '../../vidwath_custom_widgets/text_custom_vidwath.dart';
import '../dashboard_vla.dart';

class StudyLabDashVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  StudyLabDashVLA(this.thisSetNewScreenFunc, {Key? key}) : super(key: key);

  @override
  State<StudyLabDashVLA> createState() => _StudyLabDashVLAState();
}

class _StudyLabDashVLAState extends State<StudyLabDashVLA>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: 2, vsync: this, initialIndex: studyLabDashTabInitialIndex);
    currentIndexOfBottomPressed = 1;
    setState(() {
      currentIndexOfBottomPressed;
    });

    tabController.addListener(() {
      studyLabDashTabInitialIndex = tabController.index;
      setState(() {
        studyLabDashTabInitialIndex;
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
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight:
                (MediaQuery.of(context).orientation == Orientation.portrait)
                    ? 54
                    : 21,
            title: Align(
              alignment: Alignment.center,
              child: TextCustomVidwath(
                textTCV: TR.learningMadeEasyAndFun[languageIndex],
                textColorTCV: ConstantValuesVLA.blackTextColor,
                textAlignTCV: TextAlign.center,
                fontWeightTCV: FontWeight.w400,
              ),
            ),
            bottom: TabBar(
              controller: tabController,
              tabs: [
                EachTabCustomVidwath(
                    TR.tutor[languageIndex], studyLabDashTabInitialIndex == 0),
                EachTabCustomVidwath(
                    TR.dgbok[languageIndex], studyLabDashTabInitialIndex == 1),
              ],
            ),
          ),
          body: TabBarView(
            controller: tabController,
            children: [
              TutorialVideosStudyLabVLA(widget.thisSetNewScreenFunc),
              EBooksStudyLabVLA(widget.thisSetNewScreenFunc)
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
