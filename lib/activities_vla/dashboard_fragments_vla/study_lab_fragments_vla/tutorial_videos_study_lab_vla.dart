// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../constants_vla/constant_values_vla.dart';
import '../../../main.dart';
import '../../../models_vla/tutorial_videos_model_study_lab_vla.dart';
import '../../../platform_dependent_vla/video_player_vla/andr_ios_web_vla/custom_video_player_vla.dart';
import '../../../translation_vla/tr.dart';
import '../../../vidwath_custom_widgets/image_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import 'all_tutorial_videos_study_lab_vla.dart';

class TutorialVideosStudyLabVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  TutorialVideosStudyLabVLA(this.thisSetNewScreenFunc, {Key? key})
      : super(key: key);

  @override
  State<TutorialVideosStudyLabVLA> createState() =>
      _TutorialVideosStudyLabVLAState();
}

String subject_id = "";
String subjectName = "";

class _TutorialVideosStudyLabVLAState extends State<TutorialVideosStudyLabVLA> {
  List<TutorialVideosModelStudyLabVLA> listTutorialVideosModelStudyLabVLA = [];
  var rng = Random();
  Widget noDataImage = Container();
  double eachTileHeight = 130;
  double eachTileWidth = 166;

  @override
  void initState() {
    super.initState();
    getTutorialVideoAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: (listTutorialVideosModelStudyLabVLA.isNotEmpty)
          ? ListView.builder(
              // OUTER LIST VIEW BUILDER
              itemCount: listTutorialVideosModelStudyLabVLA.length,
              itemBuilder: (context, mainIndex) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        subject_id =
                            listTutorialVideosModelStudyLabVLA[mainIndex].subject_id;
                        subjectName = listTutorialVideosModelStudyLabVLA[mainIndex].SubjectsName;
                        widget.thisSetNewScreenFunc(
                            AllTutorialVideosStudyLabVLA(
                                widget.thisSetNewScreenFunc));
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                        padding: const EdgeInsets.all(3),
                        child: Row(
                          // SUBJECT NAME AND VIEW ALL
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextCustomVidwath(
                              textTCV:
                                  listTutorialVideosModelStudyLabVLA[mainIndex].SubjectsName,
                              fontSizeTCV: 14,
                              textColorTCV: ConstantValuesVLA.blackTextColor,
                            ),
                            TextCustomVidwath(
                              textTCV: TR.view_all[languageIndex],
                              textColorTCV: ConstantValuesVLA.splashBgColor,
                              fontSizeTCV: 12,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: eachTileHeight,
                      child: ListView.builder(
                          // INNER LIST VIEW BUILDER
                          scrollDirection: Axis.horizontal,
                          itemCount: listTutorialVideosModelStudyLabVLA[mainIndex].notes.length,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, subIndex) {
                            return GestureDetector(
                              //EACH TILE
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return CustomVideoPlayerVidwath(
                                        widget.thisSetNewScreenFunc,
                                        "${ConstantValuesVLA.videoPlayerBaseURL +
                                            listTutorialVideosModelStudyLabVLA[
                                                    mainIndex]
                                                .notes[subIndex]
                                                .path
                                                .trim()}/" +
                                            listTutorialVideosModelStudyLabVLA[
                                                    mainIndex]
                                                .notes[subIndex]
                                                .filename
                                                .trim() +
                                            listTutorialVideosModelStudyLabVLA[
                                                    mainIndex]
                                                .notes[subIndex]
                                                .format
                                                .trim());
                                  }),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 3,left: 8,top: 5,bottom: 5),
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(2, 2),
                                        blurRadius: 2,
                                        color: Color.fromRGBO(55, 71, 79, .5)),
                                  ],
                                  color: the6Colors[subIndex % 6],
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                height: eachTileHeight - 5,
                                width: eachTileWidth - 9,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6.0),
                                  child: Stack(
                                    children: [
                                      Image.asset("assets/whats_new_bg.png"),
                                      Padding(
                                        // PHOTO TEACHER AND SUBJECT NAME
                                        padding: const EdgeInsets.all(12),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: ImageCustomVidwath(
                                                imageUrlICV: listTutorialVideosModelStudyLabVLA[mainIndex].notes[subIndex].thumbnail.trim().replaceAll(" ", ""),
                                                heightICV: eachTileHeight * .425,
                                                widthICV: eachTileHeight * .425,
                                                aboveImageICV: listTutorialVideosModelStudyLabVLA[mainIndex].notes[subIndex].professor,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(height: 15,),

                                                  TextCustomVidwath(
                                                    // TEACHER NAME
                                                    textTCV:
                                                        listTutorialVideosModelStudyLabVLA[
                                                                mainIndex]
                                                            .notes[subIndex]
                                                            .professor,
                                                    textColorTCV: Colors.white,
                                                    fontSizeTCV: 10,
                                                    fontWeightTCV:
                                                        FontWeight.w500,
                                                  ),
                                                  Container(
                                                    width: 55,
                                                    height: 0.5,
                                                    color: Colors.white,
                                                  ),
                                                  TextCustomVidwath(
                                                    // SUBJECT NAME BELOW TEACHER NAME
                                                    textTCV:
                                                        listTutorialVideosModelStudyLabVLA[
                                                                mainIndex]
                                                            .notes[subIndex]
                                                            .subjectname,
                                                    textColorTCV: Colors.white,
                                                    fontSizeTCV: 10,
                                                    fontWeightTCV:
                                                        FontWeight.bold,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        // BOTTOM WHITE BAR
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          height: eachTileHeight - 85,
                                          width: eachTileWidth,
                                          color: const Color.fromRGBO(252, 247, 249, 1.0),
                                          child: Column(
                                            children:[
                                              Padding(
                                                padding: const EdgeInsets.only(left: 1,right: 1,top: 1),
                                                child: TextCustomVidwath(
                                                  // TRIANGLES
                                                  textTCV:
                                                      listTutorialVideosModelStudyLabVLA[mainIndex].notes[subIndex].TopicName,
                                                  fontSizeTCV: 9,
                                                  fontWeightTCV: FontWeight.w500,
                                                  textColorTCV: ConstantValuesVLA
                                                      .blackTextColor,
                                                ),
                                              ),
                                              TextCustomVidwath(
                                                // SIMILAR FIGURES Ex 6.1
                                                textTCV: listTutorialVideosModelStudyLabVLA[mainIndex].notes[subIndex].concept,
                                                fontSizeTCV: 6,
                                             textColorTCV: Colors.grey.shade700,
                                              ),
                                             Expanded(child: SizedBox()),
                                              //SUBSCRIBE AND DURATION BUTTON START
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius.circular(0),
                                                                bottomRight: Radius.circular(9),
                                                                bottomLeft: Radius.circular(0),
                                                                topRight: Radius.circular(9)),
                                                        color: Color.fromRGBO(249, 86, 86, 1),
                                                      ),
                                                      child: TextCustomVidwath(
                                                        textTCV: "  Subscribe  ",
                                                        fontSizeTCV: 6,
                                                        textColorTCV:
                                                            ConstantValuesVLA
                                                                .whiteColor,
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius.only(
                                                                topLeft: Radius.circular(9),
                                                                bottomRight: Radius.circular(0),
                                                                bottomLeft: Radius.circular(9),
                                                                topRight: Radius.circular(0)),
                                                        color: ConstantValuesVLA.blackTextColor,
                                                      ),
                                                      child: TextCustomVidwath(
                                                        textTCV:
                                                            listTutorialVideosModelStudyLabVLA[
                                                                        mainIndex]
                                                                    .notes[
                                                                        subIndex]
                                                                    .duration +
                                                                "   ",
                                                        fontSizeTCV: 6,
                                                        textColorTCV:
                                                            ConstantValuesVLA
                                                                .whiteColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                              //SUBSCRIBE AND DURATION BUTTON END
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              })
          : Container(
              child: noDataImage,
            ),
    );
  }

  Future<void> getTutorialVideoAPI() async {
    var url = Uri.parse(ConstantValuesVLA.baseURLConstant +
        ConstantValuesVLA.tutorialsConstant);
    http
        .post(url,
            body: jsonEncode({
              // "class_id": "10"
              ConstantValuesVLA.class_idJsonKey:
                  prefs.getString(ConstantValuesVLA.class_idJsonKey)
            }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        listTutorialVideosModelStudyLabVLA.add(
            TutorialVideosModelStudyLabVLA.fromJson(tutorialVideoListTemp[i]));
      }
      if (listTutorialVideosModelStudyLabVLA.isEmpty) {
        noDataImage = Image.asset("assets/ic_no_record_found.png");
      }
      setState(() {
        listTutorialVideosModelStudyLabVLA;
      });
    });
  }
}
