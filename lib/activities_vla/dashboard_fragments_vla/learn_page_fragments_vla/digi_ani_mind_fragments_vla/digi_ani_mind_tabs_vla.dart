// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../../translation_vla/tr.dart';
import '../../../../vidwath_custom_widgets/each_tab_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/image_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import '../../evaluate_dash_vla.dart';
import '../../evaluate_page_fragments_vla/assess_kit_quiz_fragments_vla/after_assess_kit_fragment_vla.dart';
import '../../evaluate_page_fragments_vla/assess_kit_quiz_fragments_vla/assess_kit_fragment_vla.dart';
import 'animations_digi_ani_mind_vla.dart';
import 'digibooks_digi_ani_mind_vla.dart';
import 'mind_maps_digi_ani_mind_vla.dart';


class DigiAniMindTabsVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  DigiAniMindTabsVLA(this.thisSetNewScreenFunc, {Key? key}) : super(key: key);

  @override
  State<DigiAniMindTabsVLA> createState() => _DigiAniMindTabsVLAState();
}

class _DigiAniMindTabsVLAState extends State<DigiAniMindTabsVLA>
    with TickerProviderStateMixin{
  Widget leftFragment = Container();
  late TabController tabController;
  int numberOfTabs = 3;

  double heightIs = 0, widthIs = 0;

  @override
  void initState() {
    super.initState();
    leftFragment = AssessKitFragmentVLA(
        widget.thisSetNewScreenFunc, changeBackToAssess, changeToAfterAssess);
    tabController = TabController(
        length: numberOfTabs,
        vsync: this,
        initialIndex: digiAniMindTabInitialIndex);
    tabController.addListener(() {
      digiAniMindTabInitialIndex = tabController.index;
      setState(() {
        digiAniMindTabInitialIndex;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        onWillPop: onBackPressed,
        child: SafeArea(
          child: Column(
            children: [
              heightIs > 500
                  ? ImageCustomVidwath(
                      imageUrlICV: selectedEvaluateSubject.image,
                      heightICV: 95.4,
                      widthICV: 95.4,
                      aboveImageICV: selectedEvaluateSubject.SubjectName,
                    )
                  : Container(),
              TextCustomVidwath(
                textTCV: selectedEvaluateSubject.SubjectName,
                fontWeightTCV: FontWeight.bold,
              ),
              Container(
                height: (heightIs > 500) ? (heightIs - 270) : (heightIs - 170),
                width: widthIs,
                child: DefaultTabController(
                  length: numberOfTabs,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      backgroundColor: Colors.white,
                      toolbarHeight: 0,
                      bottom: TabBar(
                        controller: tabController,
                        tabs: [
                          EachTabCustomVidwath(TR.digibook[languageIndex], digiAniMindTabInitialIndex == 0,),
                          EachTabCustomVidwath(TR.anim[languageIndex], digiAniMindTabInitialIndex == 1),
                          EachTabCustomVidwath(TR.mind[languageIndex], digiAniMindTabInitialIndex == 2),
                        ],
                      ),
                    ),
                    body: TabBarView(
                      controller: tabController,
                      children: [
                        DigibooksDigiAniMindVLA(widget.thisSetNewScreenFunc),
                        AnimationsDigiAniMindVLA(widget.thisSetNewScreenFunc),
                        MindMapsDigiAniMindVLA(widget.thisSetNewScreenFunc)
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
    //widget.thisSetNewScreenFunc(LearnDashVLA(widget.thisSetNewScreenFunc));
    listOfWidgetForBack.removeLast();
    widget.thisSetNewScreenFunc(listOfWidgetForBack.last, addToQueue: false);
    return Future.value(false);
  }
}
