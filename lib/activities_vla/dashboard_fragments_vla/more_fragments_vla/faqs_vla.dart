/*
ExpandedTile(
theme: const ExpandedTileThemeData(
headerColor: Colors.green,
headerRadius: 24.0,
headerPadding: EdgeInsets.all(24.0),
headerSplashColor: Colors.red,
contentBackgroundColor: Colors.blue,
contentPadding: EdgeInsets.all(24.0),
contentRadius: 12.0,
),
controller: _controller,
title: const Text("this is the title"),
content: Container(
color: Colors.red,
child: const Center(
child: Text("This is the content!"),
),
),
onTap: () {
debugPrint("tapped!!");
},
onLongTap: () {
debugPrint("long tapped!!");
},
)*/
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../../constants_vla/constant_values_vla.dart';
import '../../../main.dart';
import '../../../models_vla/faqs_model_vla.dart';
import '../../../vidwath_custom_widgets/faq_animation_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/text_custom_vidwath.dart';


class FAQsVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  FAQsVLA(this.thisSetNewScreenFunc, {Key? key});

  @override
  State<FAQsVLA> createState() => _FAQsVLAState();
}

class _FAQsVLAState extends State<FAQsVLA> {
  List<FAQsModelVLA> assessKitsList = [];
  var rng = Random();
  double screenWidth = 0, screenHeight = 0;
  List<Widget> gradeWidgetList = [];
  List<int> selectedWidgetNumber = [];
  bool firstTimeOver = false;

  @override
  void initState() {
    super.initState();
    getTutorialVideoAPI();

    Future.delayed(const Duration(seconds: 1), () {
      appBarTitle = "FAQs";
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SizedBox(
            width: screenWidth,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: gradeWidgetList,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {
    var url = Uri.parse(
        ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.faqsConstant);
    http
        .post(url,
            body: jsonEncode({
              // "user_id": "90"
              ConstantValuesVLA.user_idJsonKey:
                  prefs.getString(ConstantValuesVLA.user_idJsonKey)
            }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        assessKitsList.add(FAQsModelVLA.fromJson(tutorialVideoListTemp[i]));
      }
      setAssessKits();
    });
  }

  Future<bool> onBackPressed() {
    gradeWidgetList = [];
    listOfWidgetForBack.removeLast();
    widget.thisSetNewScreenFunc(listOfWidgetForBack.last, addToQueue: false);
    return Future.value(false);
  }

  void setAssessKits() {
    for (int index = 0; index < assessKitsList.length; index++) {
      gradeWidgetList.add(
        GestureDetector(
          onTap: () {
            firstTimeOver = true;
            gradeWidgetList = [];
            // print(index);
            // print(selectedWidgetNumber);
            if (selectedWidgetNumber.contains(index)) {
              selectedWidgetNumber.remove(index);
            } else {
              selectedWidgetNumber.add(index);
            }
            setAssessKits();
          },
          child: FaqAnimationCustomVidwath(
            (!firstTimeOver) ? ((index + 2) * 630) : 0,
            Container(
              margin: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 9,
                        offset: Offset(5, 5),
                        color: Color.fromRGBO(55, 71, 79, .3))
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(9))),
              width: screenWidth,
              child: Column(
                children: [
                  Container(
                    width: screenWidth,
                    color: ConstantValuesVLA.splashBgColor,
                    padding: const EdgeInsets.fromLTRB(9, 9, 9, 9),
                    child: TextCustomVidwath(
                      maxLines: 3,
                      textTCV: assessKitsList[index].Question,
                      textColorTCV: ConstantValuesVLA.whiteColor,
                    ),
                  ),
                  selectedWidgetNumber.contains(index)
                      ? Container(
                          color: ConstantValuesVLA.whiteColor,
                          padding: const EdgeInsets.fromLTRB(9, 3, 9, 9),
                          child: TextCustomVidwath(
                            textTCV: assessKitsList[index].Answer,
                            maxLines: 108,
                            textAlignTCV: TextAlign.start,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      );
    }
    setState(() {
      gradeWidgetList;
    });
  }
}
/*
 String userName = "",
      status = "",
      referenceId = "",
      medium = "",
      grade = "",
      price = "",
      validity = "",
      startDate = "",
      endDate = "",
      alarmStartDate = "";


    "user_id": "125003",
    "user_name": "Santhosh M Kunthe",
    "class_id": "210",
    "topic_id": "0",
    "start_date": "2022-07-08 12:35",
    "end_date": "2022-08-08 12:35",
    "order_id": "test",
    "txn_amount": "699",
    "medium": "CBSE",
    "Class": "10",
    "years": "End of this Academic Year",
    "message": "Subscription successful",
    "alarmStartDate": "2022-08-03",
    "status": "success",
    "Class_subscribe": "YES"
* */
