import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vel_app_online/models_vla/digibooks_model_learn_vla.dart';

import '../../../../constants_vla/constant_values_vla.dart';
import '../../../../main.dart';
import '../../../../vidwath_custom_widgets/slide_transition_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import '../../evaluate_page_fragments_vla/assess_kit_quiz_fragments_vla/pdf_viewer_vla.dart';


class AfterMindMapsVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  DigibooksModelLearnVLA digibooksModelLearnVLA;

  AfterMindMapsVLA(this.thisSetNewScreenFunc, this.digibooksModelLearnVLA,
      {Key? key});

  @override
  State<AfterMindMapsVLA> createState() => _AfterMindMapsVLAState();
}

class _AfterMindMapsVLAState extends State<AfterMindMapsVLA> {
  List<Widget> widgetLists = [];
  var rng = Random();
  double screenWidth = 0, screenHeight = 0;

  @override
  void initState() {
    super.initState();
    getTutorialVideoAPI();

    Future.delayed(const Duration(seconds: 1), () {
      appBarTitle = widget.digibooksModelLearnVLA.TopicName;
      widget.thisSetNewScreenFunc(Container(),
          addToQueue: false, changeAppBar: true);
    });
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
    for (int i = 0; i < widget.digibooksModelLearnVLA.notes.length; i++) {
      widgetLists.add(SlideTransitionCustomVidwath(
        (i + 2),
        Offset(0.0, (1.5 * (i + 2))),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return PDFViewerVLA(
                    widget.thisSetNewScreenFunc,
                    "https://vidwathapp.b-cdn.net/Android_Online/application/" +
                        widget.digibooksModelLearnVLA.notes[i].ContentPath
                            .trim() +
                        "/" +
                        widget.digibooksModelLearnVLA.notes[i].ContentName
                            .trim() +
                        ".pdf",
                    widget.digibooksModelLearnVLA.notes[i].DisplayName);
              }),
            );
          },
          child: Column(
            children: [
              Image.asset(
                "assets/pdf.png",
                width: 153,
              ),
              TextCustomVidwath(
                textTCV: widget.digibooksModelLearnVLA.notes[i].DisplayName,
                textColorTCV: ConstantValuesVLA.splashBgColor,
                fontSizeTCV: 21,
              ),
            ],
          ),
        ),
      ));
    }
    setState(() {
      widgetLists;
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
