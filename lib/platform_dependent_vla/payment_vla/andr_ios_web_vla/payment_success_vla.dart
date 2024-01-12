// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:deep_pick/deep_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as mater;
import 'package:intl/intl.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/more_dash_vla.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/more_fragments_vla/view_plans_vla.dart';
import 'package:vel_app_online/activities_vla/dashboard_vla.dart';
import 'package:vel_app_online/constants_vla/constant_values_vla.dart';
import 'package:http/http.dart' as http;
import 'package:vel_app_online/main.dart';
import 'package:vel_app_online/puc_vla/puc_dashboard_vla.dart';
import 'package:vel_app_online/translation_vla/tr.dart';
import 'package:vel_app_online/vidwath_custom_widgets/divider_custom_vidwath.dart';
import 'package:vel_app_online/vidwath_custom_widgets/text_custom_vidwath.dart';

class PaymentSuccessVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  PaymentSuccessVLA(this.thisSetNewScreenFunc, {Key? key}) : super(key: key);

  @override
  State<PaymentSuccessVLA> createState() => _PaymentSuccessVLAState();
}

class _PaymentSuccessVLAState extends State<PaymentSuccessVLA> {
  List<Widget> plansList = [
    Text(
      "Payment Successful",
      style: TextStyle(
          fontSize: 23,
          color: Colors.green,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline),
    ),
    DividerCustomVidwath(),
    Text(
      paymentSuccessResponseGlobal.paymentId.toString() +
          "\n  Kindly note this for further reference.",
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
    updateDatabaseAboutPayment();
    super.initState();
  }

  void checkForSubscription() {
    isThisUserSubscribed = false;
    http
        .post(
            Uri.parse(
                ConstantValuesVLA.baseURLConstant + "mysubscriptions.php"),
            body: jsonEncode({
              ConstantValuesVLA.user_idJsonKey:
                  prefs.getString(ConstantValuesVLA.user_idJsonKey)
            }))
        .then((value) {
      if (!value.body.toString().contains("notfound")) {
        List<dynamic> listOfMyPlans = jsonDecode(value.body).toList();
        for (int i = 0; i < listOfMyPlans.length; i++) {
          if ((listOfMyPlans[i]["class_id"].toString()==(
                  prefs.getString(ConstantValuesVLA.class_idJsonKey)!)) &&
              (listOfMyPlans[i]["active"].toString().contains("1"))) {
            isThisUserSubscribed = true;
          }
        }
      }
    });
  }

  Future<bool> onBackPressed() {
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
                        ? mater.TextDirection.rtl
                        : mater.TextDirection.ltr,
                    child: (prefs.getString(ConstantValuesVLA.boardidJsonKey) ==
                            "5")
                        ? PUCDashboardVLA()
                        : DashboardVLA()),
            debugShowCheckedModeBanner: (ConstantValuesVLA.baseURLConstant.contains("TEST") || razorPayKey.contains("test")),              ))),
    );

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            onBackPressed();
          },
          label: TextCustomVidwath(
            textTCV: "Done",
            textColorTCV: Colors.white,
          ),
          icon: Icon(Icons.done),
        ),
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
              ConstantValuesVLA.user_idJsonKey: prefs.getString(ConstantValuesVLA.user_idJsonKey)
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
        checkForSubscription();
      }
    });
  }

  void updateDatabaseAboutPayment() {
    String paymentSuccessData = jsonEncode({
      "Class": prefs.getString(ConstantValuesVLA.classnameJsonKey),
      ConstantValuesVLA.user_idJsonKey: prefs.getString(ConstantValuesVLA.user_idJsonKey),
      "user_name":
          prefs.getString(ConstantValuesVLA.usernameJsonKey).toString(),
      ConstantValuesVLA.class_idJsonKey:
          prefs.getString(ConstantValuesVLA.class_idJsonKey).toString(),
      "order_id": paymentSuccessResponseGlobal.paymentId.toString(),
      "subject_code": "0",
      "subject_name": "0",
      "payment_id": "1",
      "topic_id": "0",
      "txn_amount": (paymentAmount / 100).toString(),
      "payed": (paymentAmount / 100).toString(),
      ConstantValuesVLA.mediumJsonKey:
          prefs.getString(ConstantValuesVLA.BoardNameJsonKey),
      "subject_id": "1",
      "gateway": "Paytm",
      "validity": selectedPlansModelVLA.class_validity,
    });
print("paymentSuccessData");
    print("paymentSuccessData**");
    print(paymentSuccessData);


    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.updateAfterPaymentDoneConstantforRazorpay);
    http.post(url, body: paymentSuccessData).then((value) {
      getTutorialVideoAPI();
    });
  }
}
