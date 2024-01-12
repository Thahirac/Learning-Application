import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/more_dash_vla.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/more_fragments_vla/switch_course_vla.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/more_fragments_vla/switch_grade_vla.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/notification_vla.dart';
import 'package:vel_app_online/constants_vla/constant_values_vla.dart';
import 'package:vel_app_online/main.dart';
import 'package:vel_app_online/puc_vla/puc_show_subjects_vla.dart';
import 'package:vel_app_online/translation_vla/tr.dart';
import 'package:vel_app_online/vidwath_custom_widgets/bottom_nav_each_custom_vidwath.dart';
import 'package:vel_app_online/vidwath_custom_widgets/text_custom_vidwath.dart';

import '../activities_vla/dashboard_fragments_vla/learn_page_fragments_vla/progress_pages_vla/subject_wise_analysis_time_spent.dart';
import '../activities_vla/no_internet_page_vla.dart';
import '../vidwath_custom_widgets/notification_icon_vla.dart';

class PUCDashboardVLA extends StatefulWidget {
  bool? isdialoge;
   PUCDashboardVLA({Key? key,this.isdialoge}) : super(key: key);

  @override
  _PUCDashboardVLAState createState() => _PUCDashboardVLAState();
}

class _PUCDashboardVLAState extends State<PUCDashboardVLA> {


  AppUpdateInfo? _updateInfo;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {

      setState(() {
        _updateInfo = info;
      });
      _updateInfo?.updateAvailability == UpdateAvailability.updateAvailable ?  inappupdationdialoge() : null;
    }).catchError((e) {
      // showSnack(e.toString());
    });
  }

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




  //common for all start -a
  double screenWidth = 0, screenHeight = 0;
  bool isPortrait = true;

  //common for all end -a

  int currentIndexOfBottomPressed = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.isdialoge == true ?  _welcomepopup():null;
    });

    checkForUpdate();
    currentIndexOfBottomPressed = 0;
    listOfWidgetForBack = [];
    listOfWidgetForBack.add(PUCShowSubjectsVLA(setWidgetToNewScreen));
    checkInternetConnection();
    DASHBOARDMAINWIDGET = PUCShowSubjectsVLA(setWidgetToNewScreen);
    //getNotificationCount();
    setState(() {
      currentIndexOfBottomPressed;
      DASHBOARDMAINWIDGET;
      listOfWidgetForBack;
    });

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

  // void setWidgetToNewScreen(Widget newWidget, {bool addToQueue = true}) {
  //   if (addToQueue) listOfWidgetForBack.add(newWidget);
  //   DASHBOARDMAINWIDGET = newWidget;
  //   setState(() {
  //     DASHBOARDMAINWIDGET;
  //     listOfWidgetForBack;
  //   });
  // }

  void setWidgetToNewScreen(Widget newWidget, {bool addToQueue = true, bool changeAppBar = false}) {
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

          GestureDetector(
            onTap: (){

              currentIndexOfBottomPressed = 0;
              listOfWidgetForBack = [];
              listOfWidgetForBack.add(PUCShowSubjectsVLA(setWidgetToNewScreen));
              checkInternetConnection();
              DASHBOARDMAINWIDGET = PUCShowSubjectsVLA(setWidgetToNewScreen);

              setState(() {
                currentIndexOfBottomPressed;
                DASHBOARDMAINWIDGET;
                listOfWidgetForBack;
              });

            },
            child: Container(
              width: screenWidth / 5.1,
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: appBarHeight - 30,
                  height: 0 == currentIndexOfBottomPressed ? 0 : appBarHeight,
                  child: Image.asset(
                      "assets/dashboard_learn.png"
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: screenWidth / 5.1,
                  height: 0 == currentIndexOfBottomPressed ? appBarHeight : 0,
                  child: Center(
                    child: Text(
                      TR.learn[languageIndex],
                      style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,fontSize: 12),
                      textAlign: TextAlign.center,
                      /*textAlignTCV: TextAlign.center,
                    fontWeightTCV: FontWeight.bold,
                    textColorTCV: Colors.blue,*/
                    ),
                  ),
                ),
              ],
            ),
            ),
          ),

          GestureDetector(
            onTap: (){

              currentIndexOfBottomPressed = 4;
              listOfWidgetForBack.add( Directionality( textDirection: (languageIndex == 2)? TextDirection.ltr : TextDirection.ltr,child:  MoreDashVLA(setWidgetToNewScreen)));
              checkInternetConnection();
              DASHBOARDMAINWIDGET =  Directionality( textDirection: (languageIndex == 2)? TextDirection.ltr : TextDirection.ltr,child:  MoreDashVLA(setWidgetToNewScreen));

              setState(() {
                currentIndexOfBottomPressed;
                DASHBOARDMAINWIDGET;
                listOfWidgetForBack;
              });


            },
            child: Container(
              width: screenWidth / 5.1,
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: appBarHeight - 30,
                    height: 4 == currentIndexOfBottomPressed ? 0 : appBarHeight,
                    child: Image.asset(
                      "assets/navigation_dash.png",
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: screenWidth / 5.1,
                    height: 4 == currentIndexOfBottomPressed ? appBarHeight : 0,
                    child: Center(
                      child: Text(
                        TR.moreitem[languageIndex],
                        style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,fontSize: 12),
                        textAlign: TextAlign.center,
                        /*textAlignTCV: TextAlign.center,
                    fontWeightTCV: FontWeight.bold,
                    textColorTCV: Colors.blue,*/
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),


         /*
          BottomNavEachCustomVidwath(
            imageAssetNameBNECV: "assets/dashboard_learn.png",
            onPressedBNECV: () {

              setState(() {

                currentIndexOfBottomPressed = 0;
                listOfWidgetForBack = [];
                listOfWidgetForBack.add(PUCShowSubjectsVLA(setWidgetToNewScreen));
                checkInternetConnection();
                DASHBOARDMAINWIDGET = PUCShowSubjectsVLA(setWidgetToNewScreen);

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
            imageAssetNameBNECV: "assets/navigation_dash.png",
            onPressedBNECV: () {

              setState(() {

                currentIndexOfBottomPressed = 4;
                listOfWidgetForBack.add(MoreDashVLA(setWidgetToNewScreen));
                checkInternetConnection();
                DASHBOARDMAINWIDGET = MoreDashVLA(setWidgetToNewScreen);

                currentIndexOfBottomPressed;
                DASHBOARDMAINWIDGET;
                listOfWidgetForBack;
              });
            },
            myIndexBNECV: 4,
            currentIndexBNECV: currentIndexOfBottomPressed,
            labelBNECV: TR.moreitem[languageIndex],
          ),*/


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
          body: SafeArea(
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
                      /// ROUNDED BORDER TEXT English medium text
                      listOfWidgetForBack.length > 1
                          ? IconButton(
                              onPressed: () {
                                listOfWidgetForBack.removeLast();
                                setWidgetToNewScreen(listOfWidgetForBack.last, addToQueue: false);
                              },
                              icon: const Icon(Icons.arrow_back_ios_new))
                          : GestureDetector(
                              onTap: () {
                                listOfWidgetForBack.add(SwitchGradeVLA(setWidgetToNewScreen));
                                DASHBOARDMAINWIDGET = SwitchGradeVLA(setWidgetToNewScreen);
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
                                      textTCV: prefs.getString(ConstantValuesVLA.BoardNameJsonKey).toString(),
                                      textColorTCV: ConstantValuesVLA.splashBgColor,
                                      fontSizeTCV: 12,
                                    ),
                                    Container(
                                      width: 1,
                                      height: 14,
                                      margin: const EdgeInsets.all(3),
                                      color: ConstantValuesVLA.splashBgColor,
                                    ),
                                    TextCustomVidwath(
                                      textTCV: prefs.getString(ConstantValuesVLA.classnameJsonKey).toString(),
                                      textColorTCV: ConstantValuesVLA.splashBgColor,
                                      fontSizeTCV: 13,
                                    )
                                  ],
                                ),
                              ),
                            ),


                      //Expanded(child: SizedBox()),


                      /// APPBAR TITLE
                      TextCustomVidwath(
                        textTCV: appBarTitle,
                        fontSizeTCV: 13,
                        fontWeightTCV: FontWeight.bold,
                      ),

                      /// Notification Icon VLA
                      Row(
                        children: [

                          /// SubjectWiseAnalysisTimeSpendVLA
                          listOfWidgetForBack.length > 1 ? Container():
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: GestureDetector(
                              onTap: (){

                                listOfWidgetForBack.add(SubjectWiseAnalysisTimeSpendVLA(setWidgetToNewScreen));
                                DASHBOARDMAINWIDGET = SubjectWiseAnalysisTimeSpendVLA(setWidgetToNewScreen);
                                setState(() {
                                  DASHBOARDMAINWIDGET;
                                  listOfWidgetForBack;
                                });


                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                child: Image.asset(
                                  "assets/ic_analytics_home-nbg.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              listOfWidgetForBack.add(NotificationVLA(setWidgetToNewScreen));
                              DASHBOARDMAINWIDGET = NotificationVLA(setWidgetToNewScreen);
                              setState(() {
                                DASHBOARDMAINWIDGET;
                                listOfWidgetForBack;
                              });
                            },
                            child: NotificationIcon(),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                //BODY VIEW
                screenWidth > screenHeight ? bottomNavigationBar : Container(),
                Expanded(
                  child: DASHBOARDMAINWIDGET,
                ),
                screenWidth < screenHeight ? bottomNavigationBar : Container(),
              ],
            ),
          )),

        ),
      ],
    );
  }
}


