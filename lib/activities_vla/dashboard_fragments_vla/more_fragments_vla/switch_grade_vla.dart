import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../../constants_vla/constant_values_vla.dart';
import '../../../main.dart';
import '../../../models_vla/switch_grade_model_vla.dart';
import '../../../puc_vla/puc_dashboard_vla.dart';
import '../../../translation_vla/tr.dart';
import '../../../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/image_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/slide_transition_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import '../../dashboard_vla.dart';

class SwitchGradeVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  SwitchGradeVLA(this.thisSetNewScreenFunc, {Key? key});

  @override
  State<SwitchGradeVLA> createState() => _SwitchGradeVLAState();
}

class _SwitchGradeVLAState extends State<SwitchGradeVLA> {
  List<SwitchGradeModelVLA> assessKitsList = [];
  var rng = Random();
  double screenWidth = 0, screenHeight = 0;
  List<Widget> gradeWidgetList = [];
  bool gradeWasChoosen = false;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    getTutorialVideoAPI();
    scrollController = ScrollController();
    scrollToBottom();
  }

  void scrollToBottom() {
    Future.delayed(const Duration(seconds: 1), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 5), curve: Curves.bounceOut);
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            child: Column(
              children: [
                DividerCustomVidwath(),
                Container(
                  decoration: BoxDecoration(
                      color: ConstantValuesVLA.splashBgColor,
                      borderRadius: BorderRadius.all(const Radius.circular(9))),
                  padding: const EdgeInsets.fromLTRB(9, 5, 9, 5),
                  child: TextCustomVidwath(
                    textTCV: TR.never[languageIndex],
                    fontSizeTCV: 21,
                    fontWeightTCV: FontWeight.bold,
                    textColorTCV: ConstantValuesVLA.whiteColor,
                  ),
                ),
                DividerCustomVidwath(),
                ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    color: const Color.fromRGBO(222, 220, 220, 1.0),
                    height: 162,
                    width: 153,
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ImageCustomVidwath(
                        imageUrlICV: prefs.getString(ConstantValuesVLA.BoardThumbnailJsonKey).toString(),
                        heightICV: 155,
                        widthICV: 145,
                        //aboveImageICV: virtualClassModelVLA.tittle,
                        boxFit: BoxFit.contain,
                      ),
                    ),
                    ),
                  ),

                DividerCustomVidwath(),
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(230, 250, 248, 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(9))),
                  padding: const EdgeInsets.all(5),
                  child: TextCustomVidwath(
                    textTCV: TR.select[languageIndex],
                    fontSizeTCV: 18,
                    textColorTCV: Colors.black,
                  ),
                ),
                DividerCustomVidwath(),
                Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: gradeWidgetList,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {


    print('************ Board Id *************${prefs.getString(ConstantValuesVLA.boardidJsonKey)}');
    print('************ User  Id *************${prefs.getString(ConstantValuesVLA.user_idJsonKey)}');



    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.switchGradeConstant);
    http.post(url,
        body: jsonEncode({
          // "boardid": "3", "user_id": "90"
          "boardid": prefs.getString(ConstantValuesVLA.boardidJsonKey),
          ConstantValuesVLA.user_idJsonKey: prefs.getString(ConstantValuesVLA.user_idJsonKey)
        }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        assessKitsList
            .add(SwitchGradeModelVLA.fromJson(tutorialVideoListTemp[i]));
      }
      setDefaultGrade();
      int tempEvenCount = 0;
      int tempOddCount = 5;
      for (int i = 0; i < assessKitsList.length; i++) {
        String imageUrl = "";
        if ((i % 2) == 0) {
          tempEvenCount = tempEvenCount + 1;
          //print(i.toString() + "---" + tempEvenCount.toString());
          imageUrl = "https://vidwathapp.b-cdn.net/Android_Online/application/Vidwath/icons/bg/Grade " +
              (tempEvenCount).toString() +
              ".png";
        } else {
          tempOddCount = tempOddCount + 1;
          // print(i.toString() + "---" + tempOddCount.toString());
          imageUrl = "https://vidwathapp.b-cdn.net/Android_Online/application/Vidwath/icons/bg/Grade " + (tempOddCount).toString() + ".png";
        }

        gradeWidgetList.add(SlideTransitionCustomVidwath(
          (i + 2),
          Offset(0.0, (1.5 * (i + 2))),
          GestureDetector(
            onTap: () {
              prefs.setString(ConstantValuesVLA.classnameJsonKey, assessKitsList[i].real_class);
              prefs.setString(ConstantValuesVLA.class_idJsonKey, assessKitsList[i].Class_id);
              gradeWasChoosen = true;
              checkForSubscription();
            },
            child: Container(
              margin: EdgeInsets.all(5),
              child: Stack(
                children: [
                  Image.network(
                    imageUrl,
                    width: screenWidth / 2.34,
                    height: 61.2,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: screenWidth / 2.34,
                    height: 61.2,
                    child: Center(
                      child: TextCustomVidwath(
                        textTCV: assessKitsList[i].classname,
                        fontWeightTCV: FontWeight.bold,
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
        gradeWidgetList;
      });
    });
  }

  void checkForSubscription() {
    isThisUserSubscribed = false;
    http
        .post(Uri.parse(ConstantValuesVLA.baseURLConstant + "mysubscriptions.php"),
        body: jsonEncode({
          ConstantValuesVLA.user_idJsonKey: prefs.getString(ConstantValuesVLA.user_idJsonKey)
        }))
        .then((value) {
      if (!value.body.toString().contains("notfound")) {
        List<dynamic> listOfMyPlans = jsonDecode(value.body).toList();
        for (int i = 0; i < listOfMyPlans.length; i++) {
          if ((listOfMyPlans[i]["class_id"].toString()==(prefs.getString(ConstantValuesVLA.class_idJsonKey)!)) && (listOfMyPlans[i]["active"].toString().contains("1"))) {
            isThisUserSubscribed = true;
          }
        }
      }

      onBackPressed();
    });
  }

  Future<bool> onBackPressed() {
    if (gradeWasChoosen) {
      listOfWidgetForBack = [];

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => (MaterialApp(
              theme: ThemeData(
                  primaryColor: ConstantValuesVLA.splashBgColor,
                  fontFamily: (languageIndex == 2) ? "Jameel Noori Nastaleeq" : "Roboto"),
              scrollBehavior: CustomClicks(),
              home: Directionality(
                  textDirection: (languageIndex == 2)
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child:
                  (prefs.getString(ConstantValuesVLA.boardidJsonKey) ==
                      "5")
                      ? PUCDashboardVLA()
                      : DashboardVLA()),
              debugShowCheckedModeBanner:
              (ConstantValuesVLA.baseURLConstant.contains("TEST") ||
                  razorPayKey.contains("test")),
            ))),
      );
    } else {
      var snackBar = const SnackBar(
          content: Text("Please choose a grade to proceed"),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return Future.value(false);
  }



  void setDefaultGrade() {
    prefs.setString(ConstantValuesVLA.classnameJsonKey, assessKitsList.last.real_class);
    prefs.setString(ConstantValuesVLA.class_idJsonKey, assessKitsList.last.Class_id);
  }

}


