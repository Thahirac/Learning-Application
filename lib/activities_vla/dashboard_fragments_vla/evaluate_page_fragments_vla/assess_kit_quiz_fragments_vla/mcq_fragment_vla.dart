import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../constants_vla/constant_values_vla.dart';
import '../../../../main.dart';
import '../../../../models_vla/mcq_model_vla.dart';
import '../../../../translation_vla/tr.dart';
import '../../../../vidwath_custom_widgets/button_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/each_mcq_option_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import '../../evaluate_dash_vla.dart';
import '../../more_fragments_vla/check_subscription_view_plans_vla.dart';
import 'assess_kit_fragment_vla.dart';
import 'mcq_result_fragment_vla.dart';

class MCQFragmentVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  MCQFragmentVLA(this.thisSetNewScreenFunc, {Key? key});

  @override
  State<MCQFragmentVLA> createState() => _MCQFragmentVLAState();
}

List<MCQModelVLA> assessKitsListMCQFragment = [];
late DateTime totalTimeSpentStartTime;

class _MCQFragmentVLAState extends State<MCQFragmentVLA> {
  var rng = Random();
  double screenWidth = 0,
      screenHeight = 0;
  int currentPageNumber = 1;
  List<bool> selectedOptions4TrueFalse = [false, false, false, false];
  bool showExitMessage = false;
  bool showSubmitMessage = false;
  bool showMCQs = false;

  @override
  void initState() {
    super.initState();
    totalTimeSpentStartTime = DateTime.now();
    checkForSubscription();
    // showMCQ();
    getTutorialVideoAPI();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Stack(
        children: [
          Image.asset(
            "assets/app_bg_main.png",
            height: screenHeight,
            width: screenWidth,
            fit: BoxFit.fill,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                  size: 36,
                ),
                onPressed: () {
                  onBackPressed();
                },
              ),
              title: TextCustomVidwath(
                textTCV: topicName,
              ),
              backgroundColor: Color.fromRGBO(255, 255, 255, .8),
              elevation: 0,
              centerTitle: true,
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  (assessKitsListMCQFragment.isNotEmpty)
                      ? SizedBox(
                    height: screenHeight - 144,
                    child: Container(
                      margin: const EdgeInsets.all(9),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: showMCQs
                            ? Column(
                          children: [
                            DividerCustomVidwath(),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextCustomVidwath(
                                textTCV: "Question No. " +
                                    currentPageNumber.toString() +
                                    "/" +
                                    assessKitsListMCQFragment.length
                                        .toString(),
                                fontSizeTCV: 12,
                                textColorTCV: Colors.black,
                              ),
                            ),
                            DividerCustomVidwath(),
                            HtmlWidget(
                              assessKitsListMCQFragment[
                              currentPageNumber - 1]
                                  .Question,
                              textStyle: TextStyle(
                                  fontSize: 18,
                                  color: ConstantValuesVLA
                                      .blackTextColor),
                            ),
                            DividerCustomVidwath(),
                            DividerCustomVidwath(),
                            // A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0
                            // A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0

                            EachMCQOptionCustomVidwath(
                              onpressed: () {
                                setListTrue(0);
                                assessKitsListMCQFragment[currentPageNumber - 1].userAnswer = "1";
                              },
                              selectionContainerColor:
                              (selectedOptions4TrueFalse[0] || assessKitsListMCQFragment[currentPageNumber - 1].userAnswer == "1") ?
                              Colors.teal : ConstantValuesVLA.whiteColor,
                              selectionTextColor:
                              (selectedOptions4TrueFalse[0] || assessKitsListMCQFragment[currentPageNumber - 1].userAnswer == "1")
                                  ? ConstantValuesVLA.whiteColor
                                  : ConstantValuesVLA.blackTextColor,
                              abcdText: "A",
                              optionString: assessKitsListMCQFragment[currentPageNumber - 1].Option1,
                            ),

                            // B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
                            // B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
                            EachMCQOptionCustomVidwath(
                                onpressed: () {
                                  setListTrue(1);
                                  assessKitsListMCQFragment[currentPageNumber - 1].userAnswer = "2";
                                },
                                selectionContainerColor:
                                (selectedOptions4TrueFalse[1] ||
                                    assessKitsListMCQFragment[
                                    currentPageNumber -
                                        1]
                                        .userAnswer ==
                                        "2")
                                    ? Colors.teal
                                    : ConstantValuesVLA
                                    .whiteColor,
                                selectionTextColor:
                                (selectedOptions4TrueFalse[1] ||
                                    assessKitsListMCQFragment[
                                    currentPageNumber -
                                        1]
                                        .userAnswer ==
                                        "2")
                                    ? ConstantValuesVLA
                                    .whiteColor
                                    : ConstantValuesVLA
                                    .blackTextColor,
                                abcdText: "B",
                                optionString:
                                assessKitsListMCQFragment[
                                currentPageNumber - 1]
                                    .Option2),
                            // C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C
                            // C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C

                            EachMCQOptionCustomVidwath(
                              onpressed: () {
                                setListTrue(2);
                                assessKitsListMCQFragment[
                                currentPageNumber - 1]
                                    .userAnswer = "3";
                              },
                              selectionContainerColor:
                              (selectedOptions4TrueFalse[2] ||
                                  assessKitsListMCQFragment[
                                  currentPageNumber -
                                      1]
                                      .userAnswer ==
                                      "3")
                                  ? Colors.teal
                                  : ConstantValuesVLA
                                  .whiteColor,
                              selectionTextColor:
                              (selectedOptions4TrueFalse[2] ||
                                  assessKitsListMCQFragment[
                                  currentPageNumber -
                                      1]
                                      .userAnswer ==
                                      "3")
                                  ? ConstantValuesVLA.whiteColor
                                  : ConstantValuesVLA
                                  .blackTextColor,
                              abcdText: "C",
                              optionString:
                              assessKitsListMCQFragment[
                              currentPageNumber - 1]
                                  .Option3,
                            ),

                            // D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D
                            // D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D

                            EachMCQOptionCustomVidwath(
                              onpressed: () {
                                setListTrue(3);
                                assessKitsListMCQFragment[currentPageNumber - 1]
                                    .userAnswer = "4";
                              },
                              selectionContainerColor:
                              (selectedOptions4TrueFalse[3] ||
                                  assessKitsListMCQFragment[
                                  currentPageNumber -
                                      1]
                                      .userAnswer ==
                                      "4")
                                  ? Colors.teal
                                  : ConstantValuesVLA
                                  .whiteColor,
                              selectionTextColor:
                              (selectedOptions4TrueFalse[3] ||
                                  assessKitsListMCQFragment[
                                  currentPageNumber -
                                      1]
                                      .userAnswer ==
                                      "4")
                                  ? ConstantValuesVLA.whiteColor
                                  : ConstantValuesVLA
                                  .blackTextColor,
                              abcdText: "D",
                              optionString:
                              assessKitsListMCQFragment[
                              currentPageNumber - 1]
                                  .Option4,
                            ),
                          ],
                        )
                            : Container(),
                      ),
                    ),
                  )
                      : SizedBox(
                    height: screenHeight,
                    width: screenWidth,
                    child: Center(
                      child: TextCustomVidwath(
                        textTCV: "No data found",
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(18, 5, 5, 5),
                            child: ClipOval(
                              child: Container(
                                color: (currentPageNumber > 1)
                                    ? Color.fromRGBO(
                                    80, 158, 168, 1.0)
                                    : Colors.grey,
                                padding: EdgeInsets.all(7),
                                child: IconButton(
                                    onPressed: () {
                                      selectedOptions4TrueFalse = [
                                        false,
                                        false,
                                        false,
                                        false
                                      ];
                                      currentPageNumber = currentPageNumber - 1;
                                      if (currentPageNumber < 1)
                                        currentPageNumber = 1;
                                      setState(() {
                                        currentPageNumber;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.chevron_left,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ),
                          (currentPageNumber !=
                              assessKitsListMCQFragment.length)
                              ? Container(
                            margin: const EdgeInsets.fromLTRB(5, 5, 18, 5),
                            child: ClipOval(
                              child: Container(
                                color: currentPageNumber <
                                    (assessKitsListMCQFragment.length)
                                    ? const Color.fromRGBO(80, 158, 168, 1.0)
                                    : Colors.grey,
                                padding: EdgeInsets.all(7),
                                child: IconButton(
                                    onPressed: () {
                                      selectedOptions4TrueFalse = [
                                        false,
                                        false,
                                        false,
                                        false
                                      ];
                                      currentPageNumber = currentPageNumber + 1;
                                      if (currentPageNumber >= assessKitsListMCQFragment.length)
                                        currentPageNumber = assessKitsListMCQFragment.length;
                                      setState(() {
                                        currentPageNumber;
                                      });
                                      // TODO UNCOMMENT ABOVE

                                      /*widget.thisSetNewScreenFunc(
                                        MCQResultFragmentVLA(
                                            widget.thisSetNewScreenFunc));*/
                                    },
                                    icon: const Icon(
                                      Icons.chevron_right,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          )
                              : Container(
                            child: ButtonCustomVidwath(
                              textBCV: "Submit",
                              textSizeBCV: 16,
                              enabledBgColorBCV: Colors.white,
                              textColorBCV:
                              ConstantValuesVLA.splashBgColor,
                              onPressedBCV: () {
                                showSubmitMessage = true;
                                setState(() {
                                  showSubmitMessage;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  showExitMessage
                      ? Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Container(
                      color: const Color.fromRGBO(
                          149, 149, 149, 0.5019607843137255),
                      height: screenHeight,
                      width: screenWidth,
                      child: Center(
                        child: Container(
                          color: ConstantValuesVLA.whiteColor,
                          margin: const EdgeInsets.all(18),
                          height: 207,
                          child: Column(
                            children: [
                              Container(
                                color: ConstantValuesVLA.splashBgColor,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: 54,
                                child: Center(
                                  child: Stack(
                                    children: [
                                      Align(
                                          alignment: Alignment.center,
                                          child: TextCustomVidwath(
                                            textTCV: "EXIT",
                                            textColorTCV:
                                            ConstantValuesVLA
                                                .whiteColor,
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
                                          color: ConstantValuesVLA
                                              .whiteColor,
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: TextCustomVidwath(
                                        textTCV: "Yes",
                                        textColorTCV: ConstantValuesVLA
                                            .splashBgColor,
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
                                        textColorTCV: ConstantValuesVLA.splashBgColor,
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
                  showSubmitMessage
                      ? Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Container(
                      color: const Color.fromRGBO(
                          149, 149, 149, 0.5019607843137255),
                      height: screenHeight,
                      width: screenWidth,
                      child: Center(
                        child: Container(
                          color: ConstantValuesVLA.whiteColor,
                          margin: const EdgeInsets.all(18),
                          height: 216,
                          child: Column(
                            children: [
                              Container(
                                color: ConstantValuesVLA.splashBgColor,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: 54,
                                child: Center(
                                  child: Stack(
                                    children: [
                                      Align(
                                          alignment: Alignment.center,
                                          child: TextCustomVidwath(
                                            textTCV: "SUBMIT",
                                            textColorTCV:
                                            ConstantValuesVLA
                                                .whiteColor,
                                            fontSizeTCV: 23,
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          onPressed: () {
                                            showSubmitMessage = false;
                                            setState(() {
                                              showSubmitMessage;
                                            });
                                          },
                                          icon: const Icon(Icons.close),
                                          color: ConstantValuesVLA
                                              .whiteColor,
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
                                    TR.are_u_sure_want_to_submit[
                                    languageIndex],
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                              DividerCustomVidwath(),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MCQResultFragmentVLA(widget
                                                      .thisSetNewScreenFunc)),
                                        );
                                      },
                                      child: TextCustomVidwath(
                                        textTCV: "Yes",
                                        textColorTCV: Colors.green,
                                        fontSizeTCV: 21,
                                        fontWeightTCV: FontWeight.bold,
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        showSubmitMessage = false;
                                        setState(() {
                                          showSubmitMessage;
                                        });
                                      },
                                      child: TextCustomVidwath(
                                        textTCV: "No",
                                        textColorTCV: Colors.redAccent,
                                        fontSizeTCV: 21,
                                        fontWeightTCV: FontWeight.bold,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {
    assessKitsListMCQFragment.clear();
    var url = Uri.parse(
        ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.mcqConstant);
    http
        .post(url,
        body: jsonEncode({
          // "topic_id": "4017"
          ConstantValuesVLA.topic_idJsonKey: IdTopicMaster,
        }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      //print(tutorialVideoListTemp.length);
      //print("-u/aoe*u/u/-oeau/oea-u/aoe-u");
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        assessKitsListMCQFragment
            .add(MCQModelVLA.fromJson(tutorialVideoListTemp[i]));
        //print(assessKitsListMCQFragment[i].Question.toString());
        //print(assessKitsListMCQFragment[i].RightAnswer.toString());
      }
      setState(() {
        assessKitsListMCQFragment;
      });
    });
  }

  Future<bool> onBackPressed() {
    // print("Future<bool> onBackPressed() {");
    showExitMessage = true;
    setState(() {
      showExitMessage;
    });
    return Future.value(false);
  }

  void setListTrue(int optionIndex) {

    if(!selectedOptions4TrueFalse.contains(true)){
     /* for (int i = 0; i < 4; i++) {
        // selectedOptions4TrueFalse[i] = (optionIndex == i);
        // setState(() {
        //   selectedOptions4TrueFalse;
        // });

        if(i==optionIndex){



        }else{
          selectedOptions4TrueFalse[i]=false;
        }
      }*/

      selectedOptions4TrueFalse[optionIndex]=true;

      setState(() {

      });
    }

    //print(selectedOptions4TrueFalse);
  }

  void checkForSubscription() {
    if (!isThisUserSubscribed) {
      if (prefs.getStringList("subscriptionCheckSubjectIDList") == null) {
        prefs.setStringList("subscriptionCheckSubjectIDList",
            [(selectedEvaluateSubject.IdSubjectMaster.toString())]);
        showMCQ();
      } else {
        List<String> subscriptionCheckSubjectIDList =
        prefs.getStringList("subscriptionCheckSubjectIDList")!;
        if (subscriptionCheckSubjectIDList
            .contains(selectedEvaluateSubject.IdSubjectMaster.toString())) {
          Navigator.pop(context);
          Future.delayed(const Duration(seconds: 1), () {
            // widget.thisSetNewScreenFunc(
            //     CheckSubscriptionViewPlansVLA(widget.thisSetNewScreenFunc));
            widget.thisSetNewScreenFunc(
                Directionality(
                    textDirection: (languageIndex == 2)? TextDirection.rtl : TextDirection.ltr,
                    child:  CheckSubscriptionViewPlansVLA(widget.thisSetNewScreenFunc)));

            //onBackPressed();
          });
        } else {
          subscriptionCheckSubjectIDList
              .add(selectedEvaluateSubject.IdSubjectMaster.toString());
          prefs.setStringList(
              "subscriptionCheckSubjectIDList", subscriptionCheckSubjectIDList);
          showMCQ();
        }
      }
    } else if (isThisUserSubscribed) {
      showMCQ();
    }
  }

  void showMCQ() {
    showMCQs = true;
    setState(() {
      showMCQs;
    });
  }
}
// /home/ubuntu/Music/AndroidProjs/VidwathJava/vidwathBackups/vidwathEditing-for playing in flutter/app/src/main/java/com/visl/activities/ResultMCQActivity.java
