import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import '../../../constants_vla/constant_values_vla.dart';
import '../../../main.dart';
import '../../../models_vla/whats_new_model_vla.dart';
import '../../../platform_dependent_vla/video_player_vla/andr_ios_web_vla/custom_video_player_vla.dart';
import '../../../translation_vla/tr.dart';
import '../../../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/image_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/text_custom_vidwath.dart';

class WhatsNewLearnVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  WhatsNewLearnVLA(this.thisSetNewScreenFunc, {Key? key}) : super(key: key);

  @override
  State<WhatsNewLearnVLA> createState() => _WhatsNewLearnVLAState();
}

class _WhatsNewLearnVLAState extends State<WhatsNewLearnVLA> {
  List<Widget> listOfWhatsNewWidgets = [];
  var rng = Random();
  double eachTileHeight = 140;
  double eachTileWidth = 207;

  @override
  void initState() {
    super.initState();
    getVirutalClassesAPI();
  }

  @override
  Widget build(BuildContext context) {
    return (listOfWhatsNewWidgets.isNotEmpty)
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextCustomVidwath(
                  textTCV: TR.previous[languageIndex],
                  fontWeightTCV: FontWeight.w400,
                  fontSizeTCV: 14,
                ),
              ),
              DividerCustomVidwath(
                dividerHeight: 2,
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: listOfWhatsNewWidgets,
                ),
              ),
            ],
          )
        : Container();
  }

  Future<void> getVirutalClassesAPI() async {

    print("*************** CLASS ID WHATS NEW *****************${prefs.getString(ConstantValuesVLA.class_idJsonKey)}");



    var url = Uri.parse(
        ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.whatsNewConstant);

    http
        .post(url,
            body: jsonEncode({
              // "class_id": "110"
              ConstantValuesVLA.class_idJsonKey: prefs.getString(ConstantValuesVLA.class_idJsonKey)
            }))
        .then((value) {
      List<dynamic> virtualClassesListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < virtualClassesListTemp.length; i++) {
        WhatsNewModelVLA whatsNewModelVLA =
            WhatsNewModelVLA.fromJson(virtualClassesListTemp[i]);
        listOfWhatsNewWidgets.add(GestureDetector(
          onTap: () {

            print("**************  VIDEO LINK   *****************${ConstantValuesVLA.videoPlayerBaseURL + whatsNewModelVLA.path.trim() + "/" + whatsNewModelVLA.filename.trim() + whatsNewModelVLA.format.trim()}");

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return CustomVideoPlayerVidwath(
                    widget.thisSetNewScreenFunc,
                    ConstantValuesVLA.videoPlayerBaseURL + whatsNewModelVLA.path.trim() + "/" + whatsNewModelVLA.filename.trim() + whatsNewModelVLA.format.trim());
              }),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    offset: Offset(3, 3),
                    blurRadius: 5,
                    color: Color.fromRGBO(55, 71, 79, .5)),
              ],
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: SizedBox(
                // WHOLE TILE
                width: 175,
                height: 125,
                child: Column(
                  children: [
                    Container(
                      // ABOVE WHITE PART
                      width: 207,
                      height: 85,
                      color: the6Colors[i % 6],
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/whats_new_bg.png",
                            width: 207,
                            height: 108,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(9, 9, 9, 0),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: ImageCustomVidwath(
                                    imageUrlICV:
                                        whatsNewModelVLA.thumbnail.trim(),
                                    heightICV: eachTileHeight * .35,
                                    widthICV: eachTileHeight * .35,
                                    aboveImageICV:
                                        whatsNewModelVLA.thumbnail.trim(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextCustomVidwath(
                                        // TEACHER NAME
                                        textTCV: whatsNewModelVLA.professor,
                                        textColorTCV: Colors.white,
                                        fontSizeTCV: 10,
                                        fontWeightTCV: FontWeight.w500,
                                      ),
                                      Container(
                                        width: 55,
                                        height: 0.5,
                                        color: Colors.white,
                                      ),
                                      TextCustomVidwath(
                                        // SUBJECT NAME BELOW TEACHER NAME
                                        textTCV: whatsNewModelVLA.subjectname,
                                        textColorTCV: Colors.white,
                                        fontSizeTCV: 10,
                                        fontWeightTCV: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: TextCustomVidwath(
                                    // SUSTAINABLE MANAGEMENT OF
                                    textTCV: whatsNewModelVLA.TopicName,
                                    fontSizeTCV: 10,
                                    fontWeightTCV: FontWeight.w500,
                                    textColorTCV: ConstantValuesVLA.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // THE WHITE PART
                      width: 175,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(0),
                            bottomRight: Radius.circular(6),
                            bottomLeft: Radius.circular(6),
                            topRight: Radius.circular(0)),
                        color: const Color.fromRGBO(
                            252, 247, 249, 1.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextCustomVidwath(
                            // TRIANGLES
                            textTCV: whatsNewModelVLA.concept,
                            fontSizeTCV: 10,
                            fontWeightTCV: FontWeight.w400,
                            textColorTCV: ConstantValuesVLA.blackTextColor,
                          ),

                          //SUBSCRIBE AND DURATION BUTTON START
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(9),
                                    bottomRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(9),
                                    topRight: Radius.circular(0)),
                                color: ConstantValuesVLA.blackTextColor,
                              ),
                              child: TextCustomVidwath(
                                textTCV: whatsNewModelVLA.duration,
                                fontSizeTCV: 10,
                                textColorTCV: ConstantValuesVLA.whiteColor,
                              ),
                            ),
                          )
                          //SUBSCRIBE AND DURATION BUTTON END
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
      }

      setState(() {
        listOfWhatsNewWidgets;
      });
    });
  }
}
