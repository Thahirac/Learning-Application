import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vel_app_online/constants_vla/constant_values_vla.dart';
import 'package:vel_app_online/main.dart';
import 'package:vel_app_online/models_vla/each_puc_digibooks_model_vla.dart';
import 'package:vel_app_online/models_vla/tutorial_videos_notes_model_study_lab_vla.dart';
import 'package:vel_app_online/platform_dependent_vla/video_player_vla/andr_ios_web_vla/custom_video_player_vla.dart';
import 'package:vel_app_online/puc_vla/puc_show_subjects_vla.dart';
import 'package:vel_app_online/vidwath_custom_widgets/image_custom_vidwath.dart';
import 'package:vel_app_online/vidwath_custom_widgets/text_custom_vidwath.dart';

class PUCDigibooksTabVLA extends StatefulWidget {
  var thisSetNewScreenFunc;
  String s_id,class_id;

  PUCDigibooksTabVLA(this.thisSetNewScreenFunc,this.s_id,this.class_id, {Key? key}) : super(key: key);

  @override
  State<PUCDigibooksTabVLA> createState() => _PUCDigibooksTabVLAState();
}

String subject_id = "";

class _PUCDigibooksTabVLAState extends State<PUCDigibooksTabVLA> {
  List<EachPUCDigibooksModelVLA> listTutorialVideosModelStudyLabVLA = [];
  //var rng = Random();
  Widget noDataImage = Container();
  double eachTileWidth = 180;

  @override
  void initState() {
    super.initState();
    getTutorialVideoAPI();
  }

  @override
  Widget build(BuildContext context) {
    eachTileWidth = MediaQuery.of(context).size.width / 2.16;
    return Container(
      height: MediaQuery.of(context).size.height,
      child: (listTutorialVideosModelStudyLabVLA.isNotEmpty)
          ? ListView.builder(
              // OUTER LIST VIEW BUILDER
              itemCount: listTutorialVideosModelStudyLabVLA.length,
              itemBuilder: (context, mainIndex) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25,left: 5,right: 20,bottom: 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            listTutorialVideosModelStudyLabVLA[mainIndex].topicname,
                            style: TextStyle(color: ConstantValuesVLA.splashBgColor,
                                fontSize: 16,fontFamily: (languageIndex == 2) ? 'Jameel Noori Nastaleeq' : 'Roboto',
                            ),
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: (eachTileWidth * 265 / 561) + 33.3,
                      child: ListView.builder(
                          // INNER LIST VIEW BUILDER
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              listTutorialVideosModelStudyLabVLA[mainIndex]
                                  .notes
                                  .length,
                          itemBuilder: (context, subIndex) {
                            return GestureDetector(
                              //EACH TILE
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return CustomVideoPlayerVidwath(
                                        widget.thisSetNewScreenFunc,
                                        ConstantValuesVLA.videoPlayerBaseURL +
                                            listTutorialVideosModelStudyLabVLA[
                                                    mainIndex]
                                                .notes[subIndex]
                                                .contentpath
                                                .trim() +
                                            "/" +
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
                              child: Card(
                                color: Colors.white,
                                // Color.fromRGBO(
                                //     99 + rng.nextInt(99),
                                //     99 + rng.nextInt(99),
                                //     99 + rng.nextInt(99),
                                //     1),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: SizedBox(
                                  height: (eachTileWidth * 265 / 561) + 32.8,
                                  width: eachTileWidth,
                                  child: Column(
                                    children: [
                                      ImageCustomVidwath(
                                        imageUrlICV:"https://vidwathapp.b-cdn.net/Android_Online/application/" + listTutorialVideosModelStudyLabVLA[mainIndex].notes[subIndex].thumbnail.trim().replaceAll(" ", ""),
                                        heightICV: eachTileWidth * 265 / 561,
                                        widthICV: eachTileWidth,
                                        aboveImageICV:
                                            listTutorialVideosModelStudyLabVLA[
                                                    mainIndex]
                                                .notes[subIndex]
                                                .displayname,
                                      ),
                                      TextCustomVidwath(
                                        textTCV:
                                            listTutorialVideosModelStudyLabVLA[
                                                    mainIndex]
                                                .notes[subIndex]
                                                .displayname,
                                        fontSizeTCV: 12,
                                      )
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

  //  print('***************** ListOfPucDataToBePassed 3 *********************${listOfPucDataToBePassed[3]}');

    //print('***************** ListOfPucDataToBePassed 2 *********************${listOfPucDataToBePassed[2]}');


    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.pucDigibooksConstant);
    http
        .post(url,
            body: jsonEncode({
              ConstantValuesVLA.user_idJsonKey: prefs.getString(ConstantValuesVLA.user_idJsonKey),
              "pid": widget.class_id,
              "sid": widget.s_id,
            }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        listTutorialVideosModelStudyLabVLA
            .add(EachPUCDigibooksModelVLA.fromJson(tutorialVideoListTemp[i]));
      }
      if (listTutorialVideosModelStudyLabVLA.isEmpty) {
        noDataImage = Image.asset("assets/ic_no_record_found.png",);
      }
      setState(() {
        listTutorialVideosModelStudyLabVLA;
      });
    });
  }
}
