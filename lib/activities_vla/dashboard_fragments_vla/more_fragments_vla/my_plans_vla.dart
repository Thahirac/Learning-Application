// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:deep_pick/deep_pick.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/more_fragments_vla/view_plans_vla.dart';

import '../../../constants_vla/constant_values_vla.dart';
import '../../../main.dart';
import '../../../translation_vla/tr.dart';
import '../../../vidwath_custom_widgets/button_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/divider_custom_vidwath.dart';
import 'check_subscriptions_my_plans_vla.dart';

class MyPlansVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  MyPlansVLA(this.thisSetNewScreenFunc, {Key? key}) : super(key: key);

  @override
  State<MyPlansVLA> createState() => _MyPlansVLAState();
}

class _MyPlansVLAState extends State<MyPlansVLA> {
  List<Widget> plansList = [
    Text(
      TR.my_plan[languageIndex],
      style: TextStyle(
          fontSize: 23,
          color: ConstantValuesVLA.splashBgColor,
          fontWeight: FontWeight.bold),
    )
  ];
  double heightIs = 0, widthIs = 0;

  TextStyle leftTextStyleIs = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: ConstantValuesVLA.splashBgColor);
  TextStyle rightTextStyleIs = TextStyle(fontSize: 16);

  @override
  void initState() {
    getTutorialVideoAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(backgroundColor: Colors.transparent,
        body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: widthIs,
            child: (plansList.length > 1)
                ? Column(
                    children: plansList,
                  )
                : Container(
                    margin: EdgeInsets.all(9),
                    padding: EdgeInsets.all(9),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DividerCustomVidwath(),
                        DividerCustomVidwath(),
                        DividerCustomVidwath(),
                        Text(
                          TR.checkOurNewPlansBelow[languageIndex],
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: ConstantValuesVLA.splashBgColor),
                          textAlign: TextAlign.center,
                        ),
                        DividerCustomVidwath(),
                        ButtonCustomVidwath(
                          textBCV: TR.view_plans[languageIndex],
                          onPressedBCV: () {
                            if (isThisUserSubscribed) {
                              widget.thisSetNewScreenFunc(
                                  CheckSubscriptionMyPlansVLA(
                                      widget.thisSetNewScreenFunc));
                            } else {
                              widget.thisSetNewScreenFunc(
                                  ViewPlansVLA(widget.thisSetNewScreenFunc));
                            }
                          },
                        )
                      ],
                    ),
                  ),
          ),
        )),
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {
    var url = Uri.parse(
        ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.myPlansConstant);
    http
        .post(url,
            body: jsonEncode({
              // "user_id": "90"
              ConstantValuesVLA.user_idJsonKey: prefs.getString(ConstantValuesVLA.user_idJsonKey)
            }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        var eachPlan = (tutorialVideoListTemp[i]);
        //print(i);
        //print(tutorialVideoListTemp[i]);
        plansList.add(SizedBox(
          height:  heightIs * 0.3,
          child: Card(
            margin: EdgeInsets.only(top: 12,bottom: 12,left: 20,right: 20),
            color: Colors.white,
            shadowColor: Colors.blueGrey,
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))
            ),
            child:
            Stack(
              alignment: Alignment.topRight,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            width: widthIs / 2.16,
                            child: Text(
                              TR.mediumWithColon[languageIndex],
                              textAlign: TextAlign.right,
                              style: leftTextStyleIs,
                            )),
                        Text(
                          " " + eachPlan["medium"],
                          style: rightTextStyleIs,
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        SizedBox(
                            width: widthIs / 2.16,
                            child: Text(
                              TR.gradeWithColon[languageIndex],
                              textAlign: TextAlign.right,
                              style: leftTextStyleIs,
                            )),
                        Text(
                          " " + eachPlan["class"],
                          style: rightTextStyleIs,
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                  Row(
                      children: [
                        SizedBox(
                            width: widthIs / 2.16,
                            child: Text(
                              TR.amountWithColon[languageIndex],
                              textAlign: TextAlign.right,
                              style: leftTextStyleIs,
                            )),
                        Text(
                          " ₹ " + eachPlan["txn_amount"] + " /-",
                          style: rightTextStyleIs,
                        ),
                      ],
                    ),
                     /*   Row(
                      children: [
                        SizedBox(
                            width: widthIs / 2.16,
                            child: Text(
                              TR.statusWithColon[languageIndex],
                              textAlign: TextAlign.right,
                              style: leftTextStyleIs,
                            )),
                        Text(
                          " " + eachPlan["Status"],
                          style: rightTextStyleIs,
                        ),
                      ],
                    ),*/
                /*    Row(
                      children: [
                        SizedBox(
                            width: widthIs / 2.16,
                            child: Text(
                              TR.activeWithColon[languageIndex],
                              textAlign: TextAlign.right,
                              style: leftTextStyleIs,
                            )),
                        Text(
                          " " +
                              eachPlan["active"]
                                  .toString()
                                  .replaceAll("1", "Yes")
                                  .replaceAll("0", "No"),
                          style: rightTextStyleIs,
                        ),
                      ],
                    ),*/
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        SizedBox(
                            width: widthIs / 2.16,
                            child: Text(
                              TR.purchaseDateWithColon[languageIndex],
                              textAlign: TextAlign.right,
                              style: leftTextStyleIs,
                            )),
                        Text(
                          " " +
                              DateFormat('E dd MMM yy').format(
                                  DateTime.parse(eachPlan["start_date"].toString())),
                          style: rightTextStyleIs,
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        SizedBox(
                            width: widthIs / 2.16,
                            child: Text(
                              TR.validTillDateWithColon[languageIndex],
                              textAlign: TextAlign.right,
                              style: leftTextStyleIs,
                            )),
                        Text(
                          " " +
                              DateFormat('E dd MMM yy').format(
                                  DateTime.parse(eachPlan["end_date"].toString())),
                          style: rightTextStyleIs,
                        ),
                      ],
                    ),

                  ],
                ),
                Positioned(
                    top: -5,
                    child: Icon(Icons.bookmark,size: 30,color: eachPlan["active"].toString() == "1" ? Colors.green : Colors.redAccent,)),
              ],
            ),
          ),
        ));
        setState(() {
          plansList;
        });
      }
    });
  }

  Future<bool> onBackPressed() {
    listOfWidgetForBack.removeLast();
    widget.thisSetNewScreenFunc(listOfWidgetForBack.last, addToQueue: false);
    return Future.value(false);
  }
}
