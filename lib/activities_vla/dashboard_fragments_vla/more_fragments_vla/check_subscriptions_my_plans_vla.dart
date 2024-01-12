// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:deep_pick/deep_pick.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../../constants_vla/constant_values_vla.dart';
import '../../../main.dart';
import '../../../translation_vla/tr.dart';
import '../../../vidwath_custom_widgets/divider_custom_vidwath.dart';


class CheckSubscriptionMyPlansVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  CheckSubscriptionMyPlansVLA(this.thisSetNewScreenFunc, {Key? key}) : super(key: key);

  @override
  State<CheckSubscriptionMyPlansVLA> createState() => _CheckSubscriptionMyPlansVLAState();
}

class _CheckSubscriptionMyPlansVLAState extends State<CheckSubscriptionMyPlansVLA> {
  List<Widget> plansList = [
    Text(
      TR.my_plan[languageIndex],
      style: TextStyle(
          fontSize: 23,
          color: ConstantValuesVLA.splashBgColor,
          fontWeight: FontWeight.bold),
    ),
    DividerCustomVidwath(),
    Text(
      TR.youHaveAlreadySubscribed[languageIndex],
      style: TextStyle(
        fontSize: 18,
        color: ConstantValuesVLA.splashBgColor,
      ),
      textAlign: TextAlign.center,
    ),
    DividerCustomVidwath(),
  ];
  double heightIs = 0, widthIs = 0;

  TextStyle leftTextStyleIs = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: ConstantValuesVLA.splashBgColor);
  TextStyle rightTextStyleIs = TextStyle(fontSize: 18);

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
              child: Column(
                children: plansList,
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
          ConstantValuesVLA.user_idJsonKey:
          prefs.getString(ConstantValuesVLA.user_idJsonKey)
        }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        var eachPlan = (tutorialVideoListTemp[i]);
        //print(i);
        //print(tutorialVideoListTemp[i]);
        plansList.add(Container(
          margin: EdgeInsets.all(9),
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
              border: Border.all(
                color: ConstantValuesVLA.splashBgColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: Column(
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
              Row(
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
              ),
              Row(
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
              ),
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
            ],
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
