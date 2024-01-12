import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../../../../constants_vla/constant_values_vla.dart';
import '../../../../models_vla/digibooks_model_learn_vla.dart';
import '../../../../models_vla/digibooks_notes_model_learn_vla.dart';
import '../../../../platform_dependent_vla/video_player_vla/andr_ios_web_vla/custom_video_player_vla.dart';
import '../../../../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/image_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import '../../evaluate_dash_vla.dart';


class AnimationsDigiAniMindVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  AnimationsDigiAniMindVLA(this.thisSetNewScreenFunc, {Key? key})
      : super(key: key);

  @override
  State<AnimationsDigiAniMindVLA> createState() =>
      _AnimationsDigiAniMindVLAState();
}

String subject_id = "";

class _AnimationsDigiAniMindVLAState extends State<AnimationsDigiAniMindVLA> {
  Widget noDataImage = Container();
  List<DigibooksModelLearnVLA> listDigibooksModelLearnVLA = [];
  var rng = Random();

  @override
  void initState() {
    super.initState();
    getTutorialVideoAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: (listDigibooksModelLearnVLA.isNotEmpty)
          ?  ListView.builder(
          itemCount: listDigibooksModelLearnVLA.length,
          itemBuilder: (context, mainIndex) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(3, 3, 3, 0),
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TextCustomVidwath(
                          textTCV:
                              listDigibooksModelLearnVLA[mainIndex].TopicName,
                          fontSizeTCV: 14.0,
                          textColorTCV: ConstantValuesVLA.blackTextColor,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.18,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          listDigibooksModelLearnVLA[mainIndex].notes.length,
                      itemBuilder: (context, subIndex) {
                        DigibooksNotesModelLearnVLA digibooksNotesModelLearnVLA = listDigibooksModelLearnVLA[mainIndex].notes[subIndex];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return CustomVideoPlayerVidwath(
                                    widget.thisSetNewScreenFunc,
                                    // ignore: prefer_interpolation_to_compose_strings
                                    ConstantValuesVLA.videoPlayerBaseURL +
                                        "/" +
                                        digibooksNotesModelLearnVLA.ContentPath
                                            .trim() +
                                        "/" +
                                        digibooksNotesModelLearnVLA.ContentName
                                            .trim() +
                                        digibooksNotesModelLearnVLA.format
                                            .trim());
                              }),
                            );
                          },
                          child: Container(
                            height: 111,
                            margin: EdgeInsets.all(5),
                            width: 189,
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9.0),
                              ),
                              child: Column(
                                children: [
                                  ImageCustomVidwath(
                                    imageUrlICV:
                                        listDigibooksModelLearnVLA[mainIndex]
                                            .notes[subIndex]
                                            .thumbnail
                                            .trim(),
                                    heightICV: 86,
                                    widthICV: 191,
                                    aboveImageICV:
                                        digibooksNotesModelLearnVLA.thumbnail,
                                  ),
                                  TextCustomVidwath(
                                    textTCV:
                                        digibooksNotesModelLearnVLA.DisplayName,
                                    fontSizeTCV: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                DividerCustomVidwath(
                  dividerHeight: 10.0,
                )
              ],
            );
          }) :
      Container(
        child: noDataImage,
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {

    print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^selectedEvaluateSubject IdSubjectMaster: ${selectedEvaluateSubject.IdSubjectMaster}');

    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.animationsConstant);
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
      setState(() {
        listDigibooksModelLearnVLA;
      });
    });
  }
}
