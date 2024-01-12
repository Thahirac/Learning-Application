// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

// import 'package:client_information/client_information.dart';
import 'package:deep_pick/deep_pick.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../constants_vla/constant_values_vla.dart';
import '../main.dart';
import '../puc_vla/puc_dashboard_vla.dart';
import '../translation_vla/tr.dart';
import '../vidwath_custom_widgets/button_custom_vidwath.dart';
import '../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../vidwath_custom_widgets/edittext_label_icon_custom_vidwath.dart';
import '../vidwath_custom_widgets/text_custom_vidwath.dart';
import 'dashboard_vla.dart';
import 'enter_otp_vla.dart';
import 'no_internet_page_vla.dart';

class SignUpVLA extends StatefulWidget {
  const SignUpVLA({Key? key}) : super(key: key);

  @override
  _SignUpVLAState createState() => _SignUpVLAState();
}

String userPhoneNumber = "";
bool deviceChanged = false;

class _SignUpVLAState extends State<SignUpVLA> {
  //common for all start -a
  double screenWidth = 0, screenHeight = 0;
  bool isPortrait = true;

  //common for all end -a
  late ScrollController scrollController;

  bool showContactUs = false;
  bool pressedContinue = false;


  @override
  void initState() {
    scrollController = ScrollController();
    scrollToBottom();
    super.initState();
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
        body: Stack(
          children: [
            SingleChildScrollView(
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
                  DividerCustomVidwath(),
                  EdittextLabelIconCustomVidwath(
                    onChangedECV: (tempUserNumber) {
                      userPhoneNumber = tempUserNumber;
                      setState(() {
                        userPhoneNumber;
                      });
                    },
                    counterECV: userPhoneNumber.length,
                    maximumCharsECV: 10,
                    textInputTypeECV: TextInputType.number,
                    inputFormattersECV: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    labelIConECV: Icons.local_phone_rounded,
                    prefixECV: " +91 ",
                    titleECV: "Enter mobile number.",
                    hintTextECV: "Enter your mobile number.",
                  ),
                  ButtonCustomVidwath(
                    enabledBgColorBCV: ConstantValuesVLA.splashBgColor,
                    textBCV: TR.continue_[languageIndex],
                    enabledBCV: ((userPhoneNumber.length == 10) && (!pressedContinue)),
                    ///TS Changed Code
                    // onPressedBCV: () {
                    //   setState(() {
                    //     pressedContinue = true;
                    //   });
                    //   if (userPhoneNumberIsValidated()) {
                    //     callGenerateOTPAPI();
                    //     checkInternetConnection();
                    //   }
                    // },
                      onPressedBCV: () async{

                        if (userPhoneNumberIsValidated()) {

                          setState(() {
                            pressedContinue = true;
                          });

                          bool result = await SimpleConnectionChecker.isConnectedToInternet();
                          if (result == true){

                            callGenerateOTPAPI();

                          } else {

                            var snackBar = SnackBar(
                              content: Text("No Internet connection",style: TextStyle(color: Colors.white),),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 5),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);



                          }
                        }
                      },

                  ),
                  GestureDetector(
                    onTap: () {
                      showContactUs = (!showContactUs);
                      setState(() {
                        showContactUs;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(9),
                      margin: EdgeInsets.all(9),
                      child: TextCustomVidwath(
                        textTCV: "Need Help ?",
                        textColorTCV: ConstantValuesVLA.splashBgColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            showContactUs
                ? Container(
                    color: Color.fromRGBO(149, 149, 149, 0.5019607843137255),
                    height: screenHeight,
                    width: screenWidth,
                    child: Center(
                      child: Container(
                        color: ConstantValuesVLA.whiteColor,
                        margin: EdgeInsets.all(18),
                        height: 234,
                        child: Column(
                          children: [
                            Container(
                              color: ConstantValuesVLA.splashBgColor,
                              width: MediaQuery.of(context).size.width,
                              height: 54,
                              child: Center(
                                child: Stack(
                                  children: [
                                    Align(
                                        alignment: Alignment.center,
                                        child: TextCustomVidwath(
                                          textTCV: ConstantValuesVLA
                                              .contactInCapital,
                                          textColorTCV:
                                              ConstantValuesVLA.whiteColor,
                                          fontSizeTCV: 23,
                                        )),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        onPressed: () {
                                          showContactUs = false;
                                          setState(() {
                                            showContactUs;
                                          });
                                        },
                                        icon: const Icon(Icons.close),
                                        color: ConstantValuesVLA.whiteColor,
                                        iconSize: 36,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
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
                              onTap: () async{

                                final Uri launchUri = Uri(
                                  scheme: "tel",
                                  path: ConstantValuesVLA.vidwathTollFreeNumber,
                                );
                                await launchUrl(launchUri);

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
                                    textColorTCV:
                                        ConstantValuesVLA.splashBgColor,
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
                              onTap: () async{


                                final Uri launchUri = Uri(
                                 scheme: 'mailto',
                                  path: ConstantValuesVLA.vidwathAppEmailId,
                                  query: 'subject=&body=',
                                );
                                await launchUrl(launchUri);

                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.email,
                                    color: ConstantValuesVLA.splashBgColor,
                                    size: 23,
                                  ),
                                  TextCustomVidwath(
                                    textTCV:
                                        ConstantValuesVLA.vidwathAppEmailId,
                                    textColorTCV:
                                        ConstantValuesVLA.splashBgColor,
                                    fontSizeTCV: 18,
                                  )
                                ],
                              ),
                            ),
                            DividerCustomVidwath(),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  bool userPhoneNumberIsValidated() {
    if (userPhoneNumber.isNotEmpty) {
      if (userPhoneNumber.length == 10) {
        if (double.tryParse(userPhoneNumber) != null) {
          return true;
        }
      }else{

        var snackBar = SnackBar(
          content: Text("Please enter a valid Mobile Number",style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.amber,
          duration: const Duration(seconds: 5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
    }else{
      var snackBar = SnackBar(
        content: Text("Please fill the Mobile Number field",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.amber,
        duration: const Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return false;
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

  Future<void> callGenerateOTPAPI() async {

    print("******************deviceIDJsonKey*********************************${prefs.getString(ConstantValuesVLA.deviceIDJsonKey)}");

    var url = Uri.parse(ConstantValuesVLA.baseURLConstant +
        ConstantValuesVLA.requestOTPConstant);
    http
        .post(url,
            body: jsonEncode({
              ConstantValuesVLA.mobileJsonKey: userPhoneNumber,
              ConstantValuesVLA.deviceJsonKey: prefs.getString(ConstantValuesVLA.deviceIDJsonKey)
            }))
        .then((value) {
      setSharedPrefs(value.body);
    });
  }

  void setSharedPrefs(String body) {
    // @formatter:off
    prefs.setString(ConstantValuesVLA.activeJsonKey, pickFromJson(body, ConstantValuesVLA.activeJsonKey).value.toString());
    prefs.setString(ConstantValuesVLA.demo_viewsJsonKey, pickFromJson(body, ConstantValuesVLA.demo_viewsJsonKey).value.toString());
    prefs.setString(ConstantValuesVLA.device_verificationJsonKey, pickFromJson(body, ConstantValuesVLA.device_verificationJsonKey).value.toString());
    prefs.setString(ConstantValuesVLA.emailJsonKey, pickFromJson(body, ConstantValuesVLA.emailJsonKey).value.toString());
    prefs.setString(ConstantValuesVLA.dobJsonKey, pickFromJson(body, ConstantValuesVLA.dobJsonKey).value.toString());
    prefs.setString(ConstantValuesVLA.mobileJsonKey, pickFromJson(body, ConstantValuesVLA.mobileJsonKey).value.toString());
    prefs.setString(ConstantValuesVLA.otpJsonKey, pickFromJson(body, ConstantValuesVLA.otpJsonKey).value.toString());
    prefs.setString(ConstantValuesVLA.statusJsonKey, pickFromJson(body, ConstantValuesVLA.statusJsonKey).value.toString());
    prefs.setString(ConstantValuesVLA.userJsonKey, pickFromJson(body, ConstantValuesVLA.userJsonKey).value.toString());
    prefs.setString(ConstantValuesVLA.useridJsonKey, pickFromJson(body, ConstantValuesVLA.useridJsonKey).value.toString());
    prefs.setString(ConstantValuesVLA.usernameJsonKey, pickFromJson(body, ConstantValuesVLA.usernameJsonKey).value.toString());

    var jsonDecoded = jsonDecode(body);
    // print("jsonDecoded[\"user\"].toString()");
    print('******************USER SIGN UP*******************${jsonDecoded["user"].toString()}');
    // print(prefs.getString(ConstantValuesVLA.deviceIDJsonKey));
    if (jsonDecoded["user"].toString().contains("olduser")) {
      goToDashboardWithoutOTP(jsonDecoded);
    }else if(jsonDecoded["user"].toString().contains("device changed")){
      deviceChanged = true;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EnterOTPVLA()),
      ); } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EnterOTPVLA()),
      ); }

    // @formatter:on
  }

  void scrollToBottom() {
    Future.delayed(Duration(seconds: 1), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(seconds: 2), curve: Curves.bounceOut);
    });
  }

  void goToDashboardWithoutOTP(jsonDecoded) {
    //ClientInformation info = await ClientInformation.fetch();
    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.oldUserAppConfigConstant);
    http
        .post(url,
            body: jsonEncode({
              "id": jsonDecoded["userid"].toString(),
              "version": "6.4.9",
              "version_code": "69",
              "model": prefs.getString(ConstantValuesVLA.modelJsonKey),
              "democode": "none",
              "token": "nuthoetnauheotnuhaotnehuotnea"
            }))
        .then((value) {
      setSharedPreference(value.body);
      // print("value.body");
      // print("nuthoetnauheotnuhaotnehuotnea");
      // print(value.body);
    });
  }

  void setSharedPreference(String body) {
    // @formatter:off
    prefs.setString(ConstantValuesVLA.districtJsonKey, pickFromJson(body, ConstantValuesVLA.districtJsonKey).value.toString());

    prefs.setString(ConstantValuesVLA.emailJsonKey, pickFromJson(body, ConstantValuesVLA.emailJsonKey).value.toString());
    prefs.setString(ConstantValuesVLA.dobJsonKey, pickFromJson(body, ConstantValuesVLA.dobJsonKey).value.toString());
    prefs.setString(ConstantValuesVLA.mobileJsonKey, userPhoneNumber);
    //prefs.setString(ConstantValuesVLA.otpJsonKey, pickFromJson(body, ConstantValuesVLA.otpJsonKey).value.toString());
    prefs.setString(ConstantValuesVLA.refferedJsonKey, pickFromJson(body, ConstantValuesVLA.refferedJsonKey).value.toString());
    prefs.setString(ConstantValuesVLA.statusJsonKey, pickFromJson(body, ConstantValuesVLA.statusJsonKey).value.toString());
    prefs.setString(ConstantValuesVLA.useridJsonKey, pickFromJson(body, "idregistration").value.toString());
    prefs.setString(ConstantValuesVLA.user_idJsonKey, pickFromJson(body, "idregistration").value.toString());
    prefs.setString(ConstantValuesVLA.usernameJsonKey, pickFromJson(body, "name").value.toString());
    prefs.setString(ConstantValuesVLA.verifiedJsonKey, pickFromJson(body, "device_verification").value.toString());
    //*******************************************
    //*******************************************
    prefs.setString(ConstantValuesVLA.regionJsonKey,pickFromJson(body, ConstantValuesVLA.regionJsonKey).value.toString());
    prefs.setString(ConstantValuesVLA.boardidJsonKey,pickFromJson(body, "Board_id").value.toString());
    prefs.setString(ConstantValuesVLA.BoardNameJsonKey,pickFromJson(body, "board").value.toString());
    prefs.setString(ConstantValuesVLA.BoardThumbnailJsonKey,"https://www.visl.in/icons/cbse.png");
    prefs.setString(ConstantValuesVLA.classnameJsonKey,pickFromJson(body, "class_name").value.toString() );
    prefs.setString(ConstantValuesVLA.class_idJsonKey,pickFromJson(body, "classs").value.toString() );
    checkForSubscription();
    //*******************************************
    //*******************************************

// @formatter:on
  }

  void checkForSubscription() {
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
          if ((listOfMyPlans[i]["class_id"].toString() ==
                  (prefs.getString(ConstantValuesVLA.class_idJsonKey)!)) &&
              (listOfMyPlans[i]["active"].toString().contains("1"))) {
            isThisUserSubscribed = true;
          }
        }
      }
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
                          (prefs.getString(ConstantValuesVLA.boardidJsonKey) == "5")
                              ? PUCDashboardVLA(isdialoge: true,)
                              : DashboardVLA(isdialoge: true,)),
                  // PaymentSuccessVLA(() {})),
                  debugShowCheckedModeBanner:
                      (ConstantValuesVLA.baseURLConstant.contains("TEST") ||
                          razorPayKey.contains("test")),
                ))),
      );
    });
  }
}
