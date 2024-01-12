import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/more_fragments_vla/switch_grade_vla.dart';
import '../constants_vla/constant_values_vla.dart';
import '../main.dart';
import '../translation_vla/tr.dart';
import '../vidwath_custom_widgets/bottom_nav_each_custom_vidwath.dart';
import '../vidwath_custom_widgets/notification_icon_vla.dart';
import '../vidwath_custom_widgets/text_custom_vidwath.dart';
import 'dashboard_fragments_vla/evaluate_dash_vla.dart';
import 'dashboard_fragments_vla/learn_dash_vla.dart';
import 'dashboard_fragments_vla/more_dash_vla.dart';
import 'dashboard_fragments_vla/notification_vla.dart';
import 'dashboard_fragments_vla/study_lab_dash_vla.dart';
import 'dashboard_fragments_vla/test_dash_vla.dart';
import 'no_internet_page_vla.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DashboardVLA extends StatefulWidget {

  bool? isdialoge;
  DashboardVLA({Key? key,this.isdialoge,}) : super(key: key);

  @override
  _DashboardVLAState createState() => _DashboardVLAState();
}

int currentIndexOfBottomPressed = 0;

class _DashboardVLAState extends State<DashboardVLA> {
  AppUpdateInfo? _updateInfo;
 // GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  /// Cheking Any In app updation
  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {

      setState(() {
        _updateInfo = info;
      });
      _updateInfo?.updateAvailability == UpdateAvailability.updateAvailable ? inappupdationdialoge() : null;
    }).catchError((e) {
      // showSnack(e.toString());
    });
  }

/*  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }*/

  //common for all start -a
  double screenWidth = 0, screenHeight = 0;
  bool isPortrait = true;
  //common for all end -a
  int noOfUnreadNotification = 0;
  String? initialMessage;
  bool _resolved = false;

  inappupdationdialoge() async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        titleTextStyle: TextStyle(fontWeight: FontWeight.w700,fontFamily: "Roboto",fontSize: 20),
        title: Text("Update App?",style: TextStyle(color: ConstantValuesVLA.splashBgColor),),
        content: Text(
          "Please update to the latest version for new features and improvements.",
        ),
        backgroundColor: ConstantValuesVLA.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 45,
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: ConstantValuesVLA.splashBgColor,
                      fixedSize: Size.fromWidth(100),
                      padding: EdgeInsets.all(10),
                    ),
                    child: Text(
                      "Update Now",
                      style: TextStyle(color: Colors.white,fontSize: 14),
                    ),

                    onPressed: (){

                          InAppUpdate.performImmediateUpdate().catchError((e) {
                            //showSnack(e.toString());
                            return AppUpdateResult.inAppUpdateFailed;
                          });

                          Navigator.pop(context);

                        }


                      ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  _welcomepopup() async {
    return  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: EdgeInsets.only(top: 150,bottom: 150,left: 20,right: 20),
        contentPadding: EdgeInsets.only(top: 20,left: 15,right: 15),
        clipBehavior: Clip.hardEdge,
        titlePadding: EdgeInsets.only(top: 25,left: 15,),
        titleTextStyle: TextStyle(fontWeight: FontWeight.w700,fontFamily: "Roboto",fontSize: 20,color: ConstantValuesVLA.splashBgColor,),
        title: Text("Welcome to Vidwath Learning App!",),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("NOTE: A few instructions to be followed before using the app",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: "Roboto"),),
            SizedBox(height: 20,),
            Text("• After logging in to our app, you can\nview any module from any of the\nsubjects only once, which is absolutely\nfree\n• Later, the user can view all the modules\nof all the subjects by subscribing to our\napp.",style: TextStyle(fontSize: 14,fontFamily: "Roboto"),),
          ],
        ),
        backgroundColor: HexColor("#94ccc9"),
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 15,right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 40,
                  width: 70,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: HexColor("#17d2f5"),
                        fixedSize: Size.fromWidth(100),
                        padding: EdgeInsets.all(10),
                      ),
                      child: Text(
                        "GOT IT",
                        style: TextStyle(color: Colors.white,fontSize: 14),
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      }
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.isdialoge == true ?  _welcomepopup():null;
    });


    checkForUpdate();
    currentIndexOfBottomPressed = 0;
    listOfWidgetForBack = [];
    listOfWidgetForBack.add(LearnDashVLA(setWidgetToNewScreen));
    checkInternetConnection();
    DASHBOARDMAINWIDGET = LearnDashVLA(setWidgetToNewScreen);
    //getNotificationCount();
    setState(() {
      currentIndexOfBottomPressed;
      DASHBOARDMAINWIDGET;
      listOfWidgetForBack;
    });

    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then(
          (value) => setState(
            () {
              _resolved = true;
              initialMessage = value?.data.toString();
              //print('**********************initial notification****************************$initialMessage');
            },
          ),
        );

    FirebaseMessaging.onMessage.listen(showFlutterNotification);
  }

  Future<void> checkInternetConnection() async {
    bool result = await SimpleConnectionChecker.isConnectedToInternet();
    if (result == true) {
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NoInternetPageVLA()),
      );
    }
  }

  void setWidgetToNewScreen(Widget newWidget,
      {bool addToQueue = true, bool changeAppBar = false}) {
    if (changeAppBar) {
      setState(() {
        appBarTitle;
      });
    } else {
      if (addToQueue) listOfWidgetForBack.add(newWidget);
      checkInternetConnection();
      DASHBOARDMAINWIDGET = newWidget;
      setState(() {
        // print("uotnauhoeatnhu45454545554444");
        appBarTitle = "";
        DASHBOARDMAINWIDGET;
        listOfWidgetForBack;
      });
      // CHECK BEFORE LIVE
      //getNotificationCount();
    }
  }

  @override
  Widget build(BuildContext context) {
    //common for all start -b
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    //common for all end -b

    Widget bottomNavigationBar = SizedBox(
      height: appBarHeight,
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BottomNavEachCustomVidwath(
            imageAssetNameBNECV: "assets/dashboard_learn.png",
            onPressedBNECV: () {
              currentIndexOfBottomPressed = 0;
              listOfWidgetForBack = [];
              listOfWidgetForBack.add(LearnDashVLA(setWidgetToNewScreen));
              checkInternetConnection();
              DASHBOARDMAINWIDGET = LearnDashVLA(setWidgetToNewScreen);
              setState(() {
                appBarTitle = "";
                currentIndexOfBottomPressed;
                DASHBOARDMAINWIDGET;
                listOfWidgetForBack;
              });
            },
            myIndexBNECV: 0,
            currentIndexBNECV: currentIndexOfBottomPressed,
            labelBNECV: TR.learn[languageIndex],
          ),
          BottomNavEachCustomVidwath(
            imageAssetNameBNECV: "assets/dashboard_study_lab.png",
            onPressedBNECV: () {
              currentIndexOfBottomPressed = 1;
              listOfWidgetForBack.add(StudyLabDashVLA(setWidgetToNewScreen));
              checkInternetConnection();
              DASHBOARDMAINWIDGET = StudyLabDashVLA(setWidgetToNewScreen);
              setState(() {
                appBarTitle = "";
                currentIndexOfBottomPressed;
                DASHBOARDMAINWIDGET;
                listOfWidgetForBack;
              });
            },
            myIndexBNECV: 1,
            currentIndexBNECV: currentIndexOfBottomPressed,
            labelBNECV: TR.study_lab[languageIndex],
          ),
          BottomNavEachCustomVidwath(
            imageAssetNameBNECV: "assets/dashboard_evaluate.png",
            onPressedBNECV: () {
              currentIndexOfBottomPressed = 2;
              listOfWidgetForBack.add(EvaluateDashVLA(setWidgetToNewScreen));
              checkInternetConnection();
              DASHBOARDMAINWIDGET = EvaluateDashVLA(setWidgetToNewScreen);
              setState(() {
                appBarTitle = "";
                currentIndexOfBottomPressed;
                DASHBOARDMAINWIDGET;
                listOfWidgetForBack;
              });
            },
            myIndexBNECV: 2,
            currentIndexBNECV: currentIndexOfBottomPressed,
            labelBNECV: TR.evaluate[languageIndex],
          ),
          BottomNavEachCustomVidwath(
            imageAssetNameBNECV: "assets/dashboard_test.png",
            onPressedBNECV: () {
              currentIndexOfBottomPressed = 3;
              listOfWidgetForBack.add(TestDashVLA(setWidgetToNewScreen));
              checkInternetConnection();
              DASHBOARDMAINWIDGET = TestDashVLA(setWidgetToNewScreen);
              setState(() {
                appBarTitle = "";
                currentIndexOfBottomPressed;
                DASHBOARDMAINWIDGET;
                listOfWidgetForBack;
              });
            },
            myIndexBNECV: 3,
            currentIndexBNECV: currentIndexOfBottomPressed,
            labelBNECV: TR.tests[languageIndex],
          ),
          BottomNavEachCustomVidwath(
            imageAssetNameBNECV: "assets/navigation_dash.png",
            onPressedBNECV: () {
              currentIndexOfBottomPressed = 4;
              listOfWidgetForBack.add(Directionality(
                  textDirection: (languageIndex == 2)
                      ? TextDirection.ltr
                      : TextDirection.ltr,
                  child: MoreDashVLA(setWidgetToNewScreen)));
              checkInternetConnection();
              DASHBOARDMAINWIDGET = Directionality(
                  textDirection: (languageIndex == 2)
                      ? TextDirection.ltr
                      : TextDirection.ltr,
                  child: MoreDashVLA(setWidgetToNewScreen));
              setState(() {
                appBarTitle = "";
                currentIndexOfBottomPressed;
                DASHBOARDMAINWIDGET;
                listOfWidgetForBack;
              });
            },
            myIndexBNECV: 4,
            currentIndexBNECV: currentIndexOfBottomPressed,
            labelBNECV: TR.moreitem[languageIndex],
          ),
        ],
      ),
    );

    return Stack(
      children: [
        Image.asset(
          "assets/app_bg_main.png",
          height: screenHeight,
          width: screenWidth,
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body:SafeArea(
                child: SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: Column(
                children: [
                  //APPBAR
                  Container(
                    padding: const EdgeInsets.all(9.0),
                    height: appBarHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ROUNDED BORDER TEXT English medium text
                        listOfWidgetForBack.length > 1
                            ? IconButton(
                                onPressed: () {
                                  listOfWidgetForBack.removeLast();
                                  setWidgetToNewScreen(listOfWidgetForBack.last,
                                      addToQueue: false);
                                },
                                icon: const Icon(Icons.arrow_back_ios_new))
                            : GestureDetector(
                                onTap: () {
                                  listOfWidgetForBack.add(Directionality(
                                      textDirection: (languageIndex == 2)
                                          ? TextDirection.ltr
                                          : TextDirection.ltr,
                                      child: SwitchGradeVLA(
                                          setWidgetToNewScreen)));
                                  DASHBOARDMAINWIDGET = Directionality(
                                      textDirection: (languageIndex == 2)
                                          ? TextDirection.ltr
                                          : TextDirection.ltr,
                                      child:
                                          SwitchGradeVLA(setWidgetToNewScreen));
                                  setState(() {
                                    DASHBOARDMAINWIDGET;
                                    listOfWidgetForBack;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    border: Border.all(
                                      color: ConstantValuesVLA.splashBgColor,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      TextCustomVidwath(
                                        textTCV: prefs
                                            .getString(ConstantValuesVLA
                                                .BoardNameJsonKey)
                                            .toString(),
                                        textColorTCV:
                                            ConstantValuesVLA.splashBgColor,
                                        fontSizeTCV: 12,
                                      ),
                                      Container(
                                        width: 1,
                                        height: 14,
                                        margin: const EdgeInsets.all(3),
                                        color: ConstantValuesVLA.splashBgColor,
                                      ),
                                      TextCustomVidwath(
                                        textTCV: prefs
                                            .getString(ConstantValuesVLA
                                                .classnameJsonKey)
                                            .toString(),
                                        textColorTCV:
                                            ConstantValuesVLA.splashBgColor,
                                        fontSizeTCV: 13,
                                      )
                                    ],
                                  ),
                                ),
                              ),

                        // APPBAR TITLE
                        TextCustomVidwath(
                          textTCV: appBarTitle,
                          fontSizeTCV: 13,
                          fontWeightTCV: FontWeight.bold,
                        ),

                        /// Notification Icon VLA
                        GestureDetector(
                          onTap: () {
                            listOfWidgetForBack
                                .add(NotificationVLA(setWidgetToNewScreen));
                            DASHBOARDMAINWIDGET =
                                NotificationVLA(setWidgetToNewScreen);
                            setState(() {
                              DASHBOARDMAINWIDGET;
                              listOfWidgetForBack;
                            });

                            ///TS Code Changed

                            // Navigator.push(
                            //   context,
                            //   PageRouteBuilder(
                            //     pageBuilder: (c, a1, a2) => NotificationVLA(widget.thisSetNewScreenFunc),
                            //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            //       var begin = const Offset(1.0, 0.0);
                            //       var end = Offset.zero;
                            //       var tween = Tween(begin: begin, end: end);
                            //       var offsetAnimation = animation.drive(tween);
                            //       return SlideTransition(
                            //         position: offsetAnimation,
                            //         child: child,
                            //       );
                            //     },
                            //     transitionDuration: const Duration(milliseconds: 500),
                            //   ),
                            // );
                          },
                          child: NotificationIcon(),
                        ),
                      ],
                    ),
                  ),
                  //APPBAR
                  screenWidth > screenHeight
                      ? bottomNavigationBar
                      : Container(),
                  Expanded(
                    child: DASHBOARDMAINWIDGET,
                  ),
                  screenWidth < screenHeight
                      ? bottomNavigationBar
                      : Container(),
                ],
              ),
            )),

        ),
      ],
    );
  }

  /*void getNotificationCount() async {
    await Permission.storage.status.then((permissionStatus) async {
      if (!permissionStatus.isGranted) {
       await Permission.storage.request();
      } else {
        ExternalPath.getExternalStorageDirectories().then((value) {
          File theNotificationFile = File(value.first.toString() + "/bluetoothErrorLog/bleLog");
          theNotificationFile.exists().then((notificationFileExists) {
            if (notificationFileExists) {
              theNotificationFile.readAsString()
                  .then((theNotificationFileReadAsString) {
                var notiJson = jsonDecode(theNotificationFileReadAsString);

                if (kDebugMode) {
                  print("*************************************${notiJson.toString()}");

                  print("*************************************${notiJson["notificationsArray"]}");
                }



                List<dynamic> listOfNotifications = notiJson["notificationsArray"];
                if (prefs.getInt("notificationReadCount") == null) {
                  prefs.setInt("notificationReadCount", 0);
                }
                noOfUnreadNotification = listOfNotifications.length - prefs.getInt("notificationReadCount")!;
                setState(() {
                  noOfUnreadNotification;
                });
              });
            }
          });
        });
      }
    });
  }*/
}
