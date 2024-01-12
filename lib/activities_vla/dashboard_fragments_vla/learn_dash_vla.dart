// ignore_for_file: prefer_const_literals_to_create_immutables, must_be_immutable

import 'dart:convert';

import 'package:deep_pick/deep_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../constants_vla/constant_values_vla.dart';
import '../../main.dart';
import '../../translation_vla/tr.dart';
import '../../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../../vidwath_custom_widgets/text_custom_vidwath.dart';
import '../dashboard_vla.dart';
import 'learn_page_fragments_vla/beyond_text_learn_vla.dart';
import 'learn_page_fragments_vla/conceptual_videos_learn_vla.dart';
import 'learn_page_fragments_vla/progress_analysis_card_in_home_dashborad_vla.dart';
import 'learn_page_fragments_vla/subject_list_learn_vla.dart';
import 'learn_page_fragments_vla/virtual_class_learn_vla.dart';
import 'learn_page_fragments_vla/whats_new_learn_vla.dart';

class LearnDashVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  LearnDashVLA(this.thisSetNewScreenFunc, {Key? key}) : super(key: key);

  @override
  State<LearnDashVLA> createState() => _LearnDashVLAState();
}

bool scrollLearnToBottom = false;
String imageLink = "";

class _LearnDashVLAState extends State<LearnDashVLA> {
  bool showExitMessage = false;
  double screenWidth = 0, screenHeight = 0;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    listOfWidgetForBack = [];
    listOfWidgetForBack.add(LearnDashVLA(widget.thisSetNewScreenFunc));
    currentIndexOfBottomPressed = 0;
    setState(() {
      currentIndexOfBottomPressed;
      listOfWidgetForBack;
    });
    if (scrollLearnToBottom) {
      scrollLearnToBottom = false;
      Future.delayed(const Duration(seconds: 2), () {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn);
      });
    }
    Future.delayed(const Duration(seconds: 1), () {
      getOfferIfThere();
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    color: Colors.transparent,
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextCustomVidwath(
                        textTCV: TR.lets[languageIndex],
                        fontWeightTCV: FontWeight.w400,
                      ),
                    ],
                  ),
                  ProgressAnalysisCardInHomeDashboardVLA(
                      widget.thisSetNewScreenFunc),
                  const Divider(
                    color: Colors.transparent,
                    height: 5,
                  ),
                  SubjectListLearnVLA(widget.thisSetNewScreenFunc),
                  const Divider(
                    color: Colors.transparent,
                    height: 18,
                  ),
                  VirtualClassLearnVLA(widget.thisSetNewScreenFunc),
                  DividerCustomVidwath(),
                  WhatsNewLearnVLA(widget.thisSetNewScreenFunc),
                  DividerCustomVidwath(),
                  ConceptualVideosLearnVLA(widget.thisSetNewScreenFunc),
                  DividerCustomVidwath(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextCustomVidwath(
                      textTCV: TR.behond[languageIndex],
                      fontWeightTCV: FontWeight.w400,
                      fontSizeTCV: 15,
                    ),
                  ),
                  BeyondTextLearnVLA(widget.thisSetNewScreenFunc),
                ],
              ),
            ),
          ),
          showExitMessage
              ? Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                    color:
                        const Color.fromRGBO(149, 149, 149, 0.5019607843137255),
                    height: screenHeight,
                    width: screenWidth,
                    child: Center(
                      child: Container(
                        color: ConstantValuesVLA.whiteColor,
                        margin: const EdgeInsets.all(18),
                        height: 180,
                        child: Column(
                          children: [
                            Container(
                              color: ConstantValuesVLA.splashBgColor,
                              width: MediaQuery.of(context).size.width,
                              height: 54,
                              child: Center(
                                child: Stack(
                                  children: [
                                    Align(
                                        alignment: Alignment.center,
                                        child: TextCustomVidwath(
                                          textTCV: "EXIT",
                                          textColorTCV:
                                              ConstantValuesVLA.whiteColor,
                                          fontSizeTCV: 23,
                                        )),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        onPressed: () {
                                          showExitMessage = false;
                                          setState(() {
                                            showExitMessage;
                                          });
                                        },
                                        icon: const Icon(Icons.close),
                                        color: ConstantValuesVLA.whiteColor,
                                        iconSize: 23,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            DividerCustomVidwath(),
                            Flexible(
                                child: Text(
                              TR.are_u_sure_want_exit[languageIndex],
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            )),
                            DividerCustomVidwath(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      SystemNavigator.pop();
                                    },
                                    child: TextCustomVidwath(
                                      textTCV: "Yes",
                                      textColorTCV:
                                          ConstantValuesVLA.splashBgColor,
                                    )),
                                TextButton(
                                    onPressed: () {
                                      showExitMessage = false;
                                      setState(() {
                                        showExitMessage;
                                      });
                                    },
                                    child: TextCustomVidwath(
                                      textTCV: "No",
                                      textColorTCV:
                                          ConstantValuesVLA.splashBgColor,
                                    )),
                              ],
                            ),
                            DividerCustomVidwath(),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          (imageLink.length > 18)
              ? Center(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(125, 125, 125, .5),
                        //border: Border.all(color: ConstantValuesVLA.whiteColor, width: 5),
                        borderRadius: BorderRadius.all(Radius.circular(21))),
                    width: screenWidth,
                    height: screenHeight / 2,
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(12),
                    child: Stack(
                      children: [
                        Center(child: Image.network(imageLink)),
                        Padding(
                          padding: const EdgeInsets.all(21),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () {
                                  imageLink = "none";
                                  setState(() {
                                    imageLink;
                                  });
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: ConstantValuesVLA.blackTextColor,
                                  size: 54,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Future<bool> onBackPressed() {
    showExitMessage = true;
    setState(() {
      showExitMessage;
    });
    return Future.value(false);
  }

  void getOfferIfThere() {
    if (!imageLink.contains("none")) {
      var url = Uri.parse(ConstantValuesVLA.baseURLConstant +
          ConstantValuesVLA.oldUserAppConfigConstant);
      http
          .post(url,
              body: jsonEncode({
                "id": prefs.getString(ConstantValuesVLA.user_idJsonKey),
                "version": "6.4.9",
                "version_code": "69",
                "model": prefs.getString(ConstantValuesVLA.modelJsonKey),
                "democode": "none",
                "token": "nuthoetnauheotnuhaotnehuotnea"
              }))
          .then((value) {
        String body = value.body;

        String offerLink = pickFromJson(body, "adv").value.toString();
        String repeat = pickFromJson(body, "repeat").value.toString();
        if (repeat == "1" && offerLink.length > 27) {
          imageLink = offerLink;
          setState(() {
            imageLink;
          });
        } else {
          imageLink = "none";
        }
      });
    }
  }
}
