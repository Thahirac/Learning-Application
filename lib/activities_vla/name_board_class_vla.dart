// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart' as http;

import '../constants_vla/constant_values_vla.dart';
import '../main.dart';
import '../models_vla/board_model_vla.dart';
import '../models_vla/grade_model_vla.dart';
import '../puc_vla/puc_dashboard_vla.dart';
import '../translation_vla/tr.dart';
import '../vidwath_custom_widgets/button_custom_vidwath.dart';
import '../vidwath_custom_widgets/button_name_board_class_custom_vidwath.dart';
import '../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../vidwath_custom_widgets/edittext_label_icon_custom_vidwath.dart';
import '../vidwath_custom_widgets/text_custom_vidwath.dart';
import 'dashboard_vla.dart';
import 'enter_otp_vla.dart';
import 'no_internet_page_vla.dart';

class NameBoardClassVLA extends StatefulWidget {
  const NameBoardClassVLA({Key? key}) : super(key: key);

  @override
  _NameBoardClassVLAState createState() => _NameBoardClassVLAState();
}

class _NameBoardClassVLAState extends State<NameBoardClassVLA> {
  //common for all start -a
  double screenWidth = 0, screenHeight = 0;
  bool isPortrait = true;

  //common for all end -a

  int selectedRegion = 0, selectedBoard = 0, selectedGradeOrClass = 0;

  // SELECT REGION
  List<Widget> regionListWithOutSelection = [];
  List<Widget> regionListWithSelection = [];
  List<String> listRegionModelVLA = ["Karnataka", "Non-Karnataka"];

  // SELECT BOARD
  List<Widget> boardListWithOutSelection = [];
  List<Widget> boardListWithSelection = [];
  List<BoardModelVLA> listBoardModelVLA = [];

  // SELECT GRADE
  List<Widget> gradeListWithOutSelection = [];
  List<Widget> gradeListWithSelection = [];
  List<GradeModelVLA> listGradeModelVLA = [];

  //Others
  late ScrollController scrollController;

  String referralCodeEntered = "";
  String? errorTextReferralCode = null;
  String? errorTextUserName = null;
  String userNameEnteredIs = "";

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    //common for all start -b
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    //common for all end -b
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: scrollController,
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    "assets/splash_back.png",
                    width: screenWidth,
                    fit: BoxFit.fitWidth,
                  ),
                  Align(
                    child: Image.asset("assets/splash_front.png"),
                    alignment: Alignment.topCenter,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.all(9),
                  child: TextCustomVidwath(
                    textTCV: "Your Name",
                    textColorTCV: ConstantValuesVLA.splashBgColor,
                    fontSizeTCV: 21,
                  ),
                ),
              ),
              EdittextLabelIconCustomVidwath(
                hintTextECV: TR.enter_your_name[languageIndex],
                labelIConECV: Icons.account_circle_outlined,
                onChangedECV: (nameVal) {
                  userNameEnteredIs = nameVal;
                  if (userNameEnteredIs.length > 2) {
                    setRegionWidget();
                  }
                },
                titleECV: TR.name[languageIndex],
                counterECV: userNameEnteredIs.length,
                errortextECV: errorTextUserName,
              ),
              DividerCustomVidwath(
                dividerHeight: 27,
              ),
              // REGION SELECTION --START
              regionListWithOutSelection.isNotEmpty
                  ? Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.all(9),
                            child: TextCustomVidwath(
                              textTCV: TR.select_region[languageIndex],
                              textColorTCV: ConstantValuesVLA.splashBgColor,
                              fontSizeTCV: 21,
                            ),
                          ),
                        ),
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: regionListWithSelection.isEmpty
                              ? regionListWithOutSelection
                              : regionListWithSelection,
                        )
                      ],
                    )
                  : Container(),
              // REGION SELECTION --END
              DividerCustomVidwath(
                dividerHeight: 27,
              ),
              // BOARD SELECTION --START
              boardListWithOutSelection.isNotEmpty
                  ? Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.all(9),
                            child: TextCustomVidwath(
                              textTCV: TR.select_board[languageIndex],
                              textColorTCV: ConstantValuesVLA.splashBgColor,
                              fontSizeTCV: 21,
                            ),
                          ),
                        ),
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: boardListWithSelection.isEmpty
                              ? boardListWithOutSelection
                              : boardListWithSelection,
                        )
                      ],
                    )
                  : Container(),
              // BOARD SELECTION --END
              DividerCustomVidwath(
                dividerHeight: 27,
              ),
              // GRADE SELECTION --START
              gradeListWithOutSelection.isNotEmpty
                  ? Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.all(9),
                            child: TextCustomVidwath(
                              textTCV: TR.select[languageIndex],
                              textColorTCV: ConstantValuesVLA.splashBgColor,
                              fontSizeTCV: 21,
                            ),
                          ),
                        ),
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: gradeListWithSelection.isEmpty
                              ? gradeListWithOutSelection
                              : gradeListWithSelection,
                        )
                      ],
                    )
                  : Container(),
              // GRADE SELECTION --END
              DividerCustomVidwath(
                dividerHeight: 27,
              ),
              // REFERRAL SELECTION --START
              (gradeListWithSelection.isEmpty ||
                      gradeListWithOutSelection.isEmpty)
                  ? Container()
                  : Column(
                      children: [
                        EdittextLabelIconCustomVidwath(
                          titleECV: "Referral Code",
                          hintTextECV: "Enter Referral Code (if any)",
                          labelIConECV: Icons.workspaces_filled,
                          onChangedECV: (referralEnteredtemp) {
                            referralCodeEntered =
                                referralEnteredtemp.toString();
                            referralCodes.contains(referralCodeEntered);
                          },
                          errortextECV: errorTextReferralCode,
                        ),
                        TextCustomVidwath(
                          textTCV: TR.by_sigining_app_agree[languageIndex],
                          textColorTCV: Color.fromRGBO(81, 81, 81, 1.0),
                        ),
                        Wrap(
                          children: [
                            GestureDetector(
                              onTap: () {
                                launch("https://vidwath.com/tnc.html");
                              },
                              child: TextCustomVidwath(
                                textTCV: TR
                                    .terms_amp_conditions_signup[languageIndex],
                                textColorTCV: ConstantValuesVLA.splashBgColor,
                              ),
                            ),
                            TextCustomVidwath(
                              textTCV: "&",
                              textColorTCV: Color.fromRGBO(81, 81, 81, 1.0),
                            ),
                            GestureDetector(
                              onTap: () {
                                launch(
                                    "https://vidwath.com/privacy-policy.html");
                              },
                              child: TextCustomVidwath(
                                textTCV: TR.privacy_policy2[languageIndex],
                                textColorTCV: ConstantValuesVLA.splashBgColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.all(9),
                            width: MediaQuery.of(context).size.width,
                            child: ButtonCustomVidwath(
                              enabledBgColorBCV: ConstantValuesVLA.splashBgColor,
                              textBCV: TR.submit_button[languageIndex],
                              onPressedBCV: () {
                                checkInternetConnection();
                                setSharedPrefs();
                              },
                            )),
                      ],
                    )
              // REFERRAL SELECTION --END
            ],
          ),
        ),
      ),
    );
  }

  void setSharedPrefs() {
    http
        .post(
            Uri.parse(ConstantValuesVLA.baseURLConstant +
                ConstantValuesVLA.updateUserDetailsToDatabase),
            body: jsonEncode({
              "referredby": "",
              "board_id": listBoardModelVLA[selectedBoard].Board_id,
              "grade": listGradeModelVLA[selectedGradeOrClass].real_class,
              "name": userNameEnteredIs,
              "refferalcode": "0",
              "id": prefs.getString(ConstantValuesVLA.user_idJsonKey),
              "region": listRegionModelVLA[selectedRegion]
            }))
        .then((nameBoardClassResult) {
      prefs.setString(ConstantValuesVLA.usernameJsonKey, userNameEnteredIs);
    });

    // @formatter:off
    prefs.setString(ConstantValuesVLA.regionJsonKey,listRegionModelVLA[selectedRegion] );
    prefs.setString(ConstantValuesVLA.boardidJsonKey,listBoardModelVLA[selectedBoard].Board_id );
    prefs.setString(ConstantValuesVLA.BoardNameJsonKey,listBoardModelVLA[selectedBoard].BoardName );
    prefs.setString(ConstantValuesVLA.BoardThumbnailJsonKey,listBoardModelVLA[selectedBoard].thumbnail );
    prefs.setString(ConstantValuesVLA.classnameJsonKey,listGradeModelVLA[selectedGradeOrClass].real_class );
    prefs.setString(ConstantValuesVLA.class_idJsonKey,listGradeModelVLA[selectedGradeOrClass].Class_id);
    /*print("*************************************");
    print("**************************************");
    print("***************************************");
    print(listRegionModelVLA[selectedRegion] );
    print(listBoardModelVLA[selectedBoard].Board_id);
    print(listBoardModelVLA[selectedBoard].BoardName );
    print(listBoardModelVLA[selectedBoard].thumbnail );
    print(listGradeModelVLA[selectedGradeOrClass].real_class);
    print(listGradeModelVLA[selectedGradeOrClass].Class_id);*/
    // @formatter:on

    switch (int.parse(listBoardModelVLA[selectedBoard].Board_id)) {
      case 1:
        {
          languageIndex = 1;
          prefs.setInt("languageIndex", languageIndex);
        }
        break;
      case 2:
        {
          languageIndex = 0;
          prefs.setInt("languageIndex", languageIndex);
        }
        break;
      case 3:
        {
          languageIndex = 0;
          prefs.setInt("languageIndex", languageIndex);
        }
        break;
      case 4:
        {
          languageIndex = 2;
          prefs.setInt("languageIndex", languageIndex);
        }
        break;
      case 5:
        {
          languageIndex = 0;
          prefs.setInt("languageIndex", languageIndex);
        }
        break;
      default:
        {
          languageIndex = 0;
          prefs.setInt("languageIndex", languageIndex);
        }
        break;
    }

    if (userNameEnteredIs.length > 5) {
      if (referralCodes.contains(referralCodeEntered) || referralCodeEntered == "") {
        checkForSubscription();
      } else {
        errorTextReferralCode = "Kindly check your referral code";
        setState(() {
          errorTextReferralCode;
        });
      }
    } else {
      errorTextUserName = "Username should be at-least 3 characters long.";
      setState(() {
        errorTextUserName;
      });
      scrollController.animateTo(scrollController.position.minScrollExtent, duration: Duration(seconds: 2), curve: Curves.bounceInOut);
    }
  }

  void checkForSubscription() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => (prefs.getString(ConstantValuesVLA.boardidJsonKey) == "5")
          ? PUCDashboardVLA(isdialoge: true,)
          : DashboardVLA(isdialoge: true,)),
    );
  }

  Future<void> checkInternetConnection() async {
    bool result = await SimpleConnectionChecker.isConnectedToInternet();
    if (result == true) {
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NoInternetPageVLA()),
      );
    }
  }

  void setRegionWidget() {
    regionListWithOutSelection = [
      ButtonNameBoardClassCustomVidwath(
        textBCV: "Karnataka",
        onPressedBCV: () {
          checkInternetConnection();
          makeSelectionRegion(0);
        },
        enabledBCV: false,
      ),
      ButtonNameBoardClassCustomVidwath(
        textBCV: "Non-Karnataka",
        onPressedBCV: () {
          checkInternetConnection();
          makeSelectionRegion(1);
        },
        enabledBCV: false,
      ),
    ];
    setState(() {
      regionListWithOutSelection;
    });
  }

  void makeSelectionRegion(int selectedPosition) {
    selectedRegion = selectedPosition;
    callBoardAPI(listRegionModelVLA[selectedPosition]);
    // SELECT BOARD
    boardListWithOutSelection.clear();
    boardListWithSelection.clear();
    listBoardModelVLA.clear();

    // SELECT GRADE
    gradeListWithOutSelection.clear();
    gradeListWithSelection.clear();
    listGradeModelVLA.clear();

    List<Widget> tempWidgetList = [];
    for (int i = 0; i < listRegionModelVLA.length; i++) {
      if (i == selectedPosition) {
        tempWidgetList.add(ButtonNameBoardClassCustomVidwath(
          textBCV: listRegionModelVLA[i],
          onPressedBCV: () {
            checkInternetConnection();
            makeSelectionRegion(i);
          },
          enabledBCV: true,
        ));
      } else {
        tempWidgetList.add(ButtonNameBoardClassCustomVidwath(
          textBCV: listRegionModelVLA[i],
          onPressedBCV: () {
            checkInternetConnection();
            makeSelectionRegion(i);
          },
          enabledBCV: false,
        ));
      }
      regionListWithSelection = tempWidgetList;
      setState(() {
        regionListWithSelection;
      });
    }
  }

  void callBoardAPI(String karOrNon) {
    listBoardModelVLA.clear();
    boardListWithOutSelection.clear();
    setState(() {
      boardListWithSelection.clear();
    });
    var url = Uri.parse(ConstantValuesVLA.baseURLConstant +
        ConstantValuesVLA.switchCourseConstant);
    http
        .post(url,
            body: jsonEncode({
              ConstantValuesVLA.regionJsonKey: karOrNon,
              ConstantValuesVLA.user_idJsonKey:
                  prefs.getString(ConstantValuesVLA.useridJsonKey)
            }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        BoardModelVLA boardModelVLA =
            BoardModelVLA.fromJson(tutorialVideoListTemp[i]);
        listBoardModelVLA.add(boardModelVLA);
        boardListWithOutSelection.add(ButtonNameBoardClassCustomVidwath(
          textBCV: boardModelVLA.BoardName,
          onPressedBCV: () {
            checkInternetConnection();
            makeSelectionBoard(i);
          },
          enabledBCV: false,
        ));
        setState(() {
          boardListWithOutSelection;
        });
      }
      scrollToBottom();
    });
  }

  void makeSelectionBoard(int selectedPosition) {
    selectedBoard = selectedPosition;
    callGradeAPI(listBoardModelVLA[selectedPosition].Board_id);

    // SELECT GRADE
    gradeListWithOutSelection.clear();
    gradeListWithSelection.clear();
    listGradeModelVLA.clear();

    List<Widget> tempWidgetList = [];
    for (int i = 0; i < listBoardModelVLA.length; i++) {
      if (i == selectedPosition) {
        tempWidgetList.add(ButtonNameBoardClassCustomVidwath(
          textBCV: listBoardModelVLA[i].BoardName,
          onPressedBCV: () {
            checkInternetConnection();
            makeSelectionBoard(i);
          },
          enabledBCV: true,
        ));
      } else {
        tempWidgetList.add(ButtonNameBoardClassCustomVidwath(
          textBCV: listBoardModelVLA[i].BoardName,
          onPressedBCV: () {
            checkInternetConnection();
            makeSelectionBoard(i);
          },
          enabledBCV: false,
        ));
      }
      boardListWithSelection = tempWidgetList;
      setState(() {
        boardListWithSelection;
      });
    }
  }

  void callGradeAPI(String boardID) {
    listGradeModelVLA.clear();
    gradeListWithOutSelection.clear();
    setState(() {
      gradeListWithSelection.clear();
    });
    var url = Uri.parse(
        ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.gradesConstant);
    http
        .post(url,
            body: jsonEncode({
              ConstantValuesVLA.boardidJsonKey: boardID,
              ConstantValuesVLA.user_idJsonKey:
                  prefs.getString(ConstantValuesVLA.useridJsonKey)
            }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        GradeModelVLA gradeModelVLA =
            GradeModelVLA.fromJson(tutorialVideoListTemp[i]);
        listGradeModelVLA.add(gradeModelVLA);
        gradeListWithOutSelection.add(ButtonNameBoardClassCustomVidwath(
          textBCV: gradeModelVLA.category.replaceAll("0", "") +
              " " +
              gradeModelVLA.classname,
          onPressedBCV: () {
            checkInternetConnection();
            makeSelectionGrade(i);
          },
          enabledBCV: false,
        ));
        setState(() {
          gradeListWithOutSelection;
        });
      }
      scrollToBottom();
    });
  }

  void makeSelectionGrade(int selectedPosition) {
    scrollToBottom();
    selectedGradeOrClass = selectedPosition;
    List<Widget> tempWidgetList = [];
    for (int i = 0; i < listGradeModelVLA.length; i++) {
      if (i == selectedPosition) {
        tempWidgetList.add(ButtonNameBoardClassCustomVidwath(
          textBCV: listGradeModelVLA[i].classname,
          onPressedBCV: () {
            checkInternetConnection();
            makeSelectionGrade(i);
          },
          enabledBCV: true,
        ));
      } else {
        tempWidgetList.add(ButtonNameBoardClassCustomVidwath(
          textBCV: listGradeModelVLA[i].classname,
          onPressedBCV: () {
            checkInternetConnection();
            makeSelectionGrade(i);
          },
          enabledBCV: false,
        ));
      }
      gradeListWithSelection = tempWidgetList;
      setState(() {
        gradeListWithSelection;
      });
    }
  }

  void scrollToBottom() {
    Future.delayed(Duration(seconds: 1), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(seconds: 1), curve: Curves.bounceOut);
    });
  }
}
