// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../translation_vla/tr.dart';
import '../../../vidwath_custom_widgets/each_tab_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/image_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import '../evaluate_dash_vla.dart';
import 'assess_kit_quiz_fragments_vla/after_assess_kit_fragment_vla.dart';
import 'assess_kit_quiz_fragments_vla/assess_kit_fragment_vla.dart';
import 'assess_kit_quiz_fragments_vla/quiz_fragment_vla.dart';


class AssessKitQuizVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  AssessKitQuizVLA(this.thisSetNewScreenFunc, {Key? key}) : super(key: key);

  @override
  State<AssessKitQuizVLA> createState() => _AssessKitQuizVLAState();
}

class _AssessKitQuizVLAState extends State<AssessKitQuizVLA>
    with TickerProviderStateMixin{
  Widget leftFragment = Container();
  late TabController tabController;
  double heighIs = 0, widthIs = 0;

  @override
  void initState() {
    super.initState();
    leftFragment = AssessKitFragmentVLA(widget.thisSetNewScreenFunc, changeBackToAssess, changeToAfterAssess);
    tabController = TabController(length: 2, vsync: this, initialIndex: assessKitQuizTabInitialIndex);
    tabController.addListener(() {
      assessKitQuizTabInitialIndex = tabController.index;
      setState(() {
        assessKitQuizTabInitialIndex;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    heighIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        onWillPop: onBackPressed,
        child: SafeArea(
          child: Column(
            children: [
              (heighIs > 504)
                  ? ImageCustomVidwath(
                      imageUrlICV: selectedEvaluateSubject.image,
                      heightICV: 95.4,
                      widthICV: 95.4,
                      aboveImageICV: selectedEvaluateSubject.SubjectName,
                    )
                  : Container(),
              TextCustomVidwath(
                textTCV: selectedEvaluateSubject.SubjectName,
              ),
              Container(
                height: (heighIs > 500) ? (heighIs - 270) : (heighIs - 170),
                width: widthIs,
                child: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      backgroundColor: Colors.white,
                      toolbarHeight: 0,
                      bottom: TabBar(
                        controller: tabController,
                        tabs: [
                          EachTabCustomVidwath(TR.kit[languageIndex],
                              assessKitQuizTabInitialIndex == 0),
                          EachTabCustomVidwath(TR.qz[languageIndex],
                              assessKitQuizTabInitialIndex == 1),
                        ],
                      ),
                    ),
                    body: TabBarView(
                      controller: tabController,
                      children: [
                        leftFragment,
                        QuizFragmentVLA(widget.thisSetNewScreenFunc),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeBackToAssess() {
    leftFragment = AssessKitFragmentVLA(
        widget.thisSetNewScreenFunc, changeBackToAssess, changeToAfterAssess);
    setState(() {
      leftFragment;
    });
  }

  void changeToAfterAssess() {
    leftFragment = AfterAssessKitFragmentVLA(
        widget.thisSetNewScreenFunc, changeBackToAssess, changeToAfterAssess);
    setState(() {
      leftFragment;
    });
  }

  Future<bool> onBackPressed() {
    if (fromAfterAssess) {
      fromAfterAssess = false;
      changeBackToAssess();
    } else {
      listOfWidgetForBack.removeLast();
      widget.thisSetNewScreenFunc(listOfWidgetForBack.last, addToQueue: false);
    }
    return Future.value(false);
  }
}
