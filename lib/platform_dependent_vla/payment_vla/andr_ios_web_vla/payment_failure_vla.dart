// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/more_fragments_vla/view_plans_vla.dart';
import 'package:vel_app_online/activities_vla/dashboard_vla.dart';
import 'package:vel_app_online/constants_vla/constant_values_vla.dart';
import 'package:vel_app_online/main.dart';
import 'package:vel_app_online/puc_vla/puc_dashboard_vla.dart';
import 'package:vel_app_online/translation_vla/tr.dart';
import 'package:vel_app_online/vidwath_custom_widgets/button_custom_vidwath.dart';
import 'package:vel_app_online/vidwath_custom_widgets/divider_custom_vidwath.dart';
import 'package:vel_app_online/vidwath_custom_widgets/text_custom_vidwath.dart';

class PaymentFailureVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  PaymentFailureVLA(this.thisSetNewScreenFunc, {Key? key}) : super(key: key);

  @override
  State<PaymentFailureVLA> createState() => _PaymentFailureVLAState();
}

class _PaymentFailureVLAState extends State<PaymentFailureVLA> {
  final Uri emailOfContactUs = Uri(
    scheme: 'mailto',
    path: ConstantValuesVLA.vidwathAppEmailId,
    query: 'subject=&body=', //add subject and body here
  );

  @override
  void initState() {
    updateDatabaseAboutPayment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(backgroundColor: Colors.transparent,
        body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Column(
                children: [
                  DividerCustomVidwath(),
                  DividerCustomVidwath(),
                  TextCustomVidwath(
                    textTCV: "Payment failed, Kindly try again",
                    fontWeightTCV: FontWeight.bold,
                    fontSizeTCV: 21,
                    textColorTCV: Colors.redAccent,
                  ),
                  DividerCustomVidwath(),
                  DividerCustomVidwath(),
                  Center(
                    child: Container(
                      color: ConstantValuesVLA.whiteColor,
                      margin: EdgeInsets.all(18),
                      height: 270,
                      child: Column(
                        children: [
                          DividerCustomVidwath(),
                          Flexible(
                              child: Text(
                            TR.msg_contact_header[languageIndex],
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          )),
                          DividerCustomVidwath(),
                          GestureDetector(
                            onTap: () {
                              launch("tel://" +
                                  ConstantValuesVLA.vidwathTollFreeNumber);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.call,
                                  color: ConstantValuesVLA.splashBgColor,
                                  size: 23,
                                ),
                                TextCustomVidwath(
                                  textTCV:
                                      ConstantValuesVLA.vidwathTollFreeNumber,
                                  textColorTCV: ConstantValuesVLA.splashBgColor,
                                  fontSizeTCV: 18,
                                )
                              ],
                            ),
                          ),
                          TextCustomVidwath(
                            textTCV: "(Toll-free Number)",
                          ),
                          DividerCustomVidwath(),
                          GestureDetector(
                            onTap: () {
                              launch(emailOfContactUs.toString());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.email,
                                  color: ConstantValuesVLA.splashBgColor,
                                  size: 36,
                                ),
                                TextCustomVidwath(
                                  textTCV: ConstantValuesVLA.vidwathAppEmailId,
                                  textColorTCV: ConstantValuesVLA.splashBgColor,
                                  fontSizeTCV: 18,
                                )
                              ],
                            ),
                          ),
                          DividerCustomVidwath(),
                          ButtonCustomVidwath(
                            textBCV: "Retry",
                            onPressedBCV: () {
                              onBackPressed();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ))),
        )),
      ),
    );
  }

  void updateDatabaseAboutPayment() {
    String paymentSuccessData = jsonEncode({
      ConstantValuesVLA.user_idJsonKey:
          prefs.getString(ConstantValuesVLA.user_idJsonKey),
      "class_id": prefs.getString(ConstantValuesVLA.class_idJsonKey),
      "classname": prefs.getString(ConstantValuesVLA.classnameJsonKey),
      "name": prefs.getString(ConstantValuesVLA.usernameJsonKey).toString(),
      "mobile": prefs.getString(ConstantValuesVLA.mobileJsonKey).toString(),
      "order_id": paymentFailureResponseGlobal.code.toString(),
      "amount": (paymentAmount / 100).toString(),
      "failure_rerason": paymentFailureResponseGlobal.message.toString(),
      "validity": selectedPlansModelVLA.class_validity.toString(),
      "gateway": "Paytm"
    });
    /*print("paymentSuccessData");
    print("paymentSuccessData**");
    print(paymentSuccessData);*/

    var url = Uri.parse(ConstantValuesVLA.baseURLConstant +
        ConstantValuesVLA.failureUpdateAfterPaymentDoneConstant);
    http.post(url, body: paymentSuccessData).then((value) {
      //getTutorialVideoAPI();
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
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: (prefs.getString(ConstantValuesVLA.boardidJsonKey) ==
                            "5")
                        ? PUCDashboardVLA()
                        : DashboardVLA()),
            debugShowCheckedModeBanner:
            (ConstantValuesVLA.baseURLConstant.contains("TEST") ||
                razorPayKey.contains("test")),              ))),
    );
    return Future.value(false);
  }
}
