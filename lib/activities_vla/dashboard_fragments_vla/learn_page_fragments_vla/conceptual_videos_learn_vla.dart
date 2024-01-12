import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../constants_vla/constant_values_vla.dart';
import '../../../main.dart';
import '../../../models_vla/conceptual_videos_model_vla.dart';
import '../../../platform_dependent_vla/video_player_vla/andr_ios_web_vla/custom_video_player_vla.dart';
import '../../../translation_vla/tr.dart';
import '../../../vidwath_custom_widgets/image_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/text_custom_vidwath.dart';

class ConceptualVideosLearnVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  ConceptualVideosLearnVLA(this.thisSetNewScreenFunc, {Key? key})
      : super(key: key);

  @override
  State<ConceptualVideosLearnVLA> createState() =>
      _ConceptualVideosLearnVLAState();
}

class _ConceptualVideosLearnVLAState extends State<ConceptualVideosLearnVLA> {
  List<Widget> listOfConceptualVideosWidgets = [];

  @override
  void initState() {
    super.initState();
    getVirutalClassesAPI();
  }

  @override
  Widget build(BuildContext context) {
    return (listOfConceptualVideosWidgets.length > 0)
        ? Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextCustomVidwath(
                  textTCV: TR.conceptual[languageIndex],
                  fontWeightTCV: FontWeight.w400,
                  fontSizeTCV: 14,
                ),
              ),
              SingleChildScrollView(
                physics:  BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: listOfConceptualVideosWidgets,
                ),
              ),
            ],
          )
        : Container();
  }

  Future<void> getVirutalClassesAPI() async {
    var url = Uri.parse(ConstantValuesVLA.baseURLConstant +
        ConstantValuesVLA.conceptualVideosConstant);
    http
        .post(url,
            body: jsonEncode({
              // "class_id": "10", "medium": "2"
              ConstantValuesVLA.class_idJsonKey:
                  prefs.getString(ConstantValuesVLA.classnameJsonKey),
              ConstantValuesVLA.mediumJsonKey:
                  prefs.getString(ConstantValuesVLA.boardidJsonKey)
            }))
        .then((value) {
      List<dynamic> virtualClassesListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < virtualClassesListTemp.length; i++) {
        ConceptualVideosModelVLA conceptualVideosModelVLA =
            ConceptualVideosModelVLA.fromJson(virtualClassesListTemp[i]);
        listOfConceptualVideosWidgets.add(GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return CustomVideoPlayerVidwath(
                  widget.thisSetNewScreenFunc,
                  ConstantValuesVLA.videoPlayerBaseURL +
                      conceptualVideosModelVLA.ContentPath.trim() +
                      "/" +
                      conceptualVideosModelVLA.ContentName.trim() +
                      conceptualVideosModelVLA.format.trim(),
                );
              }),
            );
          },
          child: Container(
            height: 110,
            width: 175,
            margin: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    offset: Offset(3, 3),
                    blurRadius: 5,
                    color: Color.fromRGBO(55, 71, 79, .5)),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              child: Column(
                children: [
                  ImageCustomVidwath(
                    imageUrlICV: conceptualVideosModelVLA.thumbnail,
                    heightICV: 85,
                    widthICV: 175,
                    aboveImageICV: conceptualVideosModelVLA.DisplayName,
                    boxFit: BoxFit.fill,
                  ),
                  Expanded(
                    child: Container(
                     padding: EdgeInsets.all(3),
                      child: TextCustomVidwath(
                        textTCV: conceptualVideosModelVLA.DisplayName,
                        fontSizeTCV: 10,
                        fontWeightTCV: FontWeight.w500,
                        textColorTCV: ConstantValuesVLA.blackTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
      }

      setState(() {
        listOfConceptualVideosWidgets;
      });
    });
  }
}
