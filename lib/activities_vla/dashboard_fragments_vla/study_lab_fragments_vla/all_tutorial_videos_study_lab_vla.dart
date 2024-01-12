import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/study_lab_fragments_vla/tutorial_videos_study_lab_vla.dart';

import '../../../constants_vla/constant_values_vla.dart';
import '../../../main.dart';
import '../../../models_vla/all_tutorial_videos_model_study_lab_vla.dart';
import '../../../platform_dependent_vla/video_player_vla/andr_ios_web_vla/custom_video_player_vla.dart';
import '../../../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/image_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/text_custom_vidwath.dart';

class AllTutorialVideosStudyLabVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  AllTutorialVideosStudyLabVLA(this.thisSetNewScreenFunc, {Key? key})
      : super(key: key);

  @override
  State<AllTutorialVideosStudyLabVLA> createState() =>
      _AllTutorialVideosStudyLabVLAState();
}

class _AllTutorialVideosStudyLabVLAState
    extends State<AllTutorialVideosStudyLabVLA> {
  List<AllTutorialVideosModelStudyLabVLA>
      listAllTutorialVideosModelStudyLabVLA = [];
  var rng = Random();
  double eachTileHeight = 130;
  double eachTileWidth = 166;

  @override
  void initState() {
    super.initState();
    getTutorialVideoAPI();
    Future.delayed(const Duration(seconds: 1), () {
      appBarTitle = subjectName;
      widget.thisSetNewScreenFunc(Container(),
          addToQueue: false, changeAppBar: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            itemCount: listAllTutorialVideosModelStudyLabVLA.length,
            itemBuilder: (context, mainIndex) {
              String topicNameIs = (listAllTutorialVideosModelStudyLabVLA[mainIndex].TopicName.length > 36) ? listAllTutorialVideosModelStudyLabVLA[mainIndex]
                  .TopicName.substring(0, 36)
                      : listAllTutorialVideosModelStudyLabVLA[mainIndex]
                          .TopicName;
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 9, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustomVidwath(
                          textTCV: topicNameIs,
                          fontSizeTCV: 14,
                          textColorTCV: ConstantValuesVLA.blackTextColor,
                          maxLines: 3,
                          fontWeightTCV: FontWeight.w500,
                        ),
                        TextCustomVidwath(
                          textTCV: ">>",
                          fontSizeTCV: 14,
                          textColorTCV: ConstantValuesVLA.splashBgColor,
                          fontWeightTCV: FontWeight.bold,
                        )
                      ],
                    ),
                  ),
                  DividerCustomVidwath(
                    dividerHeight: 5,
                  ),
                  SizedBox(
                    height: eachTileHeight,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: listAllTutorialVideosModelStudyLabVLA[mainIndex].notes.length,
                        itemBuilder: (context, subIndex) {
                          return GestureDetector(
                            //EACH TILE
                            onTap: () {
                              singleSubjectSubscriptionIdIs = listAllTutorialVideosModelStudyLabVLA[mainIndex].Subject_id;
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return CustomVideoPlayerVidwath(
                                      widget.thisSetNewScreenFunc,
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "${ConstantValuesVLA.videoPlayerBaseURL +
                                          listAllTutorialVideosModelStudyLabVLA[
                                                  mainIndex]
                                              .notes[subIndex]
                                              .path
                                              .trim()}/" +
                                          listAllTutorialVideosModelStudyLabVLA[
                                                  mainIndex]
                                              .notes[subIndex]
                                              .filename
                                              .trim() +
                                          listAllTutorialVideosModelStudyLabVLA[
                                                  mainIndex]
                                              .notes[subIndex]
                                              .format
                                              .trim());
                                }),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 3,left: 8,top: 8,bottom: 8),
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      offset: Offset(3, 3),
                                      blurRadius: 5,
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
                                              imageUrlICV: listAllTutorialVideosModelStudyLabVLA[mainIndex].notes[subIndex].thumbnail.trim().replaceAll(" ", ""),
                                              heightICV: eachTileHeight * .425,
                                              widthICV: eachTileHeight * .425,
                                              aboveImageICV: listAllTutorialVideosModelStudyLabVLA[mainIndex].notes[subIndex].professor,
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
                                                  listAllTutorialVideosModelStudyLabVLA[
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
                                                  listAllTutorialVideosModelStudyLabVLA[
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
                                   /* Align(
                                      // BOTTOM WHITE BAR
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        height: eachTileHeight - 85,
                                        width: eachTileWidth,
                                        color: const Color.fromRGBO(
                                            252, 247, 249, 1.0),
                                        child: Column(
                                          children:[
                                            Padding(
                                              padding: const EdgeInsets.only(left: 1,right: 1,top: 3),
                                              child: TextCustomVidwath(
                                                // TRIANGLES
                                                textTCV:
                                                listAllTutorialVideosModelStudyLabVLA[mainIndex].notes[subIndex].TopicName,
                                                fontSizeTCV: 9,
                                                fontWeightTCV: FontWeight.w500,
                                                textColorTCV: ConstantValuesVLA
                                                    .blackTextColor,
                                              ),
                                            ),
                                            TextCustomVidwath(
                                              // SIMILAR FIGURES Ex 6.1
                                              textTCV: listAllTutorialVideosModelStudyLabVLA[mainIndex].notes[subIndex].concept,
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
                                                      listAllTutorialVideosModelStudyLabVLA[
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
                                    ),*/
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
                                                listAllTutorialVideosModelStudyLabVLA[mainIndex].notes[subIndex].TopicName,
                                                fontSizeTCV: 9,
                                                fontWeightTCV: FontWeight.w500,
                                                textColorTCV: ConstantValuesVLA
                                                    .blackTextColor,
                                              ),
                                            ),
                                            TextCustomVidwath(
                                              // SIMILAR FIGURES Ex 6.1
                                              textTCV: listAllTutorialVideosModelStudyLabVLA[mainIndex].notes[subIndex].concept,
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
                                                      listAllTutorialVideosModelStudyLabVLA[
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
                  DividerCustomVidwath()
                ],
              );
            }),
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {
    var url = Uri.parse(ConstantValuesVLA.baseURLConstant +
        ConstantValuesVLA.tutorialViewAllConstant);
    http
        .post(url,
            body: jsonEncode({
              // "class_id": "210", "Subject_id": "1"
              ConstantValuesVLA.class_idJsonKey:
                  prefs.getString(ConstantValuesVLA.class_idJsonKey),
              ConstantValuesVLA.Subject_idJsonKey: subject_id
            }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();

      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        listAllTutorialVideosModelStudyLabVLA.add(
            AllTutorialVideosModelStudyLabVLA.fromJson(
                tutorialVideoListTemp[i]));
      }
      setState(() {
        listAllTutorialVideosModelStudyLabVLA;
      });
    });
  }

  Future<bool> onBackPressed() {
    //widget.thisSetNewScreenFunc(StudyLabDashVLA(widget.thisSetNewScreenFunc));
    listOfWidgetForBack.removeLast();
    widget.thisSetNewScreenFunc(listOfWidgetForBack.last, addToQueue: false);
    return Future.value(false);
  }
}
