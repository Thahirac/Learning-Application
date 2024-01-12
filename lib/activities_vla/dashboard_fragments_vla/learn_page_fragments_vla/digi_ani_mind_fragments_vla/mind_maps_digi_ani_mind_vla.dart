import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../../../../constants_vla/constant_values_vla.dart';
import '../../../../main.dart';
import '../../../../models_vla/digibooks_model_learn_vla.dart';
import '../../../../vidwath_custom_widgets/slide_transition_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import '../../evaluate_dash_vla.dart';
import '../../evaluate_page_fragments_vla/assess_kit_quiz_fragments_vla/pdf_viewer_vla.dart';
import 'after_mind_maps_vla.dart';

class MindMapsDigiAniMindVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  MindMapsDigiAniMindVLA(this.thisSetNewScreenFunc, {Key? key})
      : super(key: key);

  @override
  State<MindMapsDigiAniMindVLA> createState() => _MindMapsDigiAniMindVLAState();
}

class _MindMapsDigiAniMindVLAState extends State<MindMapsDigiAniMindVLA> {
  Widget noDataImage = Container();
  List<DigibooksModelLearnVLA> listDigibooksModelLearnVLA = [];
  var rng = Random();
  List<Widget> mindMapList = [];

  @override
  void initState() {
    super.initState();
    getTutorialVideoAPI();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: (listDigibooksModelLearnVLA.isNotEmpty)
          ? Column(
              children: mindMapList,
            )
          : Container(
              child: noDataImage,
            ),
    );
  }

  Future<void> getTutorialVideoAPI() async {
    var url = Uri.parse(
        ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.mindmapsConstant);
    http
        .post(url,
            body: jsonEncode({
              // "class_id": "10"
              ConstantValuesVLA.subject_idJsonKey: selectedEvaluateSubject.IdSubjectMaster,
              "type": "2"
            }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        listDigibooksModelLearnVLA
            .add(DigibooksModelLearnVLA.fromJson(tutorialVideoListTemp[i]));
      }
      if (listDigibooksModelLearnVLA.isEmpty) {
        noDataImage = Image.asset("assets/ic_no_record_found.png",);
      }

      for (int mainIndex = 0;
          mainIndex < listDigibooksModelLearnVLA.length;
          mainIndex++) {
        mindMapList.add(
          SlideTransitionCustomVidwath(
            (mainIndex + 1),
            Offset(0.0, (1.5 * (mainIndex + 2))),
            GestureDetector(
              onTap: () {
                if (listDigibooksModelLearnVLA[mainIndex].notes.length == 1) {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return PDFViewerVLA(
                            widget.thisSetNewScreenFunc,
                            // ignore: prefer_interpolation_to_compose_strings
                            "${"${"https://vidwathapp.b-cdn.net/Android_Online/application/" + listDigibooksModelLearnVLA[mainIndex].notes[0].ContentPath.trim()}/" + listDigibooksModelLearnVLA[mainIndex].notes[0].ContentName.trim()}.pdf",
                            listDigibooksModelLearnVLA[mainIndex].notes[0].DisplayName);
                      }),
                    );
                  });
                } else {
                  widget.thisSetNewScreenFunc(AfterMindMapsVLA(
                      widget.thisSetNewScreenFunc,
                      listDigibooksModelLearnVLA[mainIndex]));
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: ConstantValuesVLA.assessKitQuizMargin,
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                    color: the5Colors[mainIndex % 5],
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: .5,
                        offset: Offset(.25, .6),
                        color: Colors.blueGrey,
                      )
                    ]),
                child: TextCustomVidwath(
                  textTCV: listDigibooksModelLearnVLA[mainIndex].TopicName,
                  textAlignTCV: (languageIndex == 2)? TextAlign.right : TextAlign.left,
                  fontSizeTCV: 14.0,
                ),
              ),
            ),
          ),
        );
      }
      setState(() {
        mindMapList;
      });
    });
  }
}
