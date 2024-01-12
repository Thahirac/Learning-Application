import 'dart:convert';

// import 'package:client_information/client_information.dart';
import 'package:deep_pick/deep_pick.dart';
import 'package:flutter/material.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';
import 'package:pinput/pinput.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:vel_app_online/activities_vla/no_internet_page_vla.dart';
import 'package:vel_app_online/activities_vla/sign_up_vla.dart';

import '../constants_vla/constant_values_vla.dart';
import '../main.dart';
import '../models_vla/otp_verified_model_vla.dart';
import '../puc_vla/puc_dashboard_vla.dart';
import '../translation_vla/tr.dart';
import '../vidwath_custom_widgets/button_custom_vidwath.dart';
import '../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../vidwath_custom_widgets/text_custom_vidwath.dart';
import 'dashboard_vla.dart';
import 'name_board_class_vla.dart';

class EnterOTPVLA extends StatefulWidget {
  const EnterOTPVLA({Key? key}) : super(key: key);

  @override
  _EnterOTPVLAState createState() => _EnterOTPVLAState();
}

List<String> referralCodes = [];

class _EnterOTPVLAState extends State<EnterOTPVLA> {
  //common for all start -a
  double screenWidth = 0, screenHeight = 0;
  bool isPortrait = true;

  //common for all end -a
  String countDownText = "01:30";
  int countDownSeconds = 90;
  bool stopCounting = false;
  late ScrollController scrollController;
  bool showContactUs = false;
  final Uri emailOfContactUs = Uri(
    scheme: 'mailto',
    path: ConstantValuesVLA.vidwathAppEmailId,
    query: 'subject=&body=', //add subject and body here
  );
  bool showInvalidOTP = false;

  @override
  void initState() {
    super.initState();
    getDeviceModel();
    startCountDown();
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

    final defaultPinTheme = PinTheme(
      width: 54,
      height: 54,
      textStyle: TextStyle(
          fontSize: 18,
          color: ConstantValuesVLA.splashBgColor,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
          border: Border.all(color: ConstantValuesVLA.splashBgColor),
          borderRadius: BorderRadius.circular(27),
          color: ConstantValuesVLA.whiteColor),
    );

    final focusedPinTheme = PinTheme(
      width: 54,
      height: 54,
      textStyle: TextStyle(
          fontSize: 18,
          color: ConstantValuesVLA.splashBgColor,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
          border: Border.all(color: ConstantValuesVLA.splashBgColor),
          borderRadius: BorderRadius.circular(9),
          color: ConstantValuesVLA.whiteColor),
    );

    final submittedPinTheme = PinTheme(
      width: 54,
      height: 54,
      textStyle: TextStyle(
          fontSize: 18,
          color: ConstantValuesVLA.whiteColor,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
          border: Border.all(color: ConstantValuesVLA.whiteColor),
          borderRadius: BorderRadius.circular(27),
          color: ConstantValuesVLA.splashBgColor),
    );

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
                  Align(
                    child: Container(
                      margin: const EdgeInsets.all(27),
                      child: Column(
                        children: [
                          TextCustomVidwath(
                            textTCV: "Enter OTP sent to",
                            textColorTCV: ConstantValuesVLA.greyTextColor,
                            fontWeightTCV: FontWeight.normal,
                            fontSizeTCV: 18,
                            textAlignTCV: TextAlign.left,
                          ),
                          TextCustomVidwath(
                            textTCV: "+91 " +
                                userPhoneNumber.toString().substring(0, 5) +
                                " " +
                                userPhoneNumber.toString().substring(5, 10),
                            textColorTCV: ConstantValuesVLA.blackTextColor,
                            fontWeightTCV: FontWeight.bold,
                            fontSizeTCV: 18,
                          ),
                          DividerCustomVidwath(),
                          Pinput(
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: focusedPinTheme,
                            submittedPinTheme: submittedPinTheme,
                            length: 6,
                            onChanged: (otpEntered) {
                              if (otpEntered.length == 6) {
                                callVerifyOTPAPI(otpEntered);
                              }
                            },
                            /*onCompleted: (otpEntered) {
                              callVerifyOTPAPI(otpEntered);
                            },*/
                            androidSmsAutofillMethod:
                                AndroidSmsAutofillMethod.smsUserConsentApi,
                          ),
                        ],
                      ),
                    ),
                  ),
                  showInvalidOTP
                      ? TextCustomVidwath(
                          textTCV: "Invalid OTP",
                          textColorTCV: Colors.redAccent,
                        )
                      : Container(),
                  (countDownSeconds > 0)
                      ? Column(
                          children: [
                            TextCustomVidwath(
                              textTCV: "OTP Expires in",
                              // 01:30 i.e 90 seconds
                              textColorTCV:
                                  const Color.fromRGBO(7, 31, 163, 1.0),
                              fontWeightTCV: FontWeight.bold,
                              fontSizeTCV: 16,
                            ),
                            // COUNTDOWN TIMER TEXT CONTAINER
                            Container(
                              margin: const EdgeInsets.all(9),
                              height: 63,
                              width: 63,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ConstantValuesVLA.splashBgColor),
                                  shape: BoxShape.circle,
                                  color: ConstantValuesVLA.whiteColor),
                              child: Center(
                                child: TextCustomVidwath(
                                  textTCV: countDownText,
                                  textColorTCV: ConstantValuesVLA.splashBgColor,
                                  fontSizeTCV: 18,
                                ),
                              ),
                            ),
                            // COUNTDOWN TIMER TEXT CONTAINER
                          ],
                        )
                      : ButtonCustomVidwath(
                          textBCV: "Resend OTP",
                          onPressedBCV: callGenerateOTPAPI,
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
                                        iconSize: 23,
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

  void startCountDown() {
    if (!stopCounting) {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        startCountDown();
        countDownSeconds = countDownSeconds - 1;
        if (countDownSeconds == 1) {
          stopCounting = true;
          setState(() {
            countDownSeconds;
          });
        }
        countDownText = '${(Duration(seconds: countDownSeconds))}'
            .split('.')[0]
            .padLeft(8, '0')
            .substring(
              3,
            );
        setState(() {
          countDownText;
        });
      });
    }
  }

  Future<void> callVerifyOTPAPI(String otpEntered) async {
    //ClientInformation info = await ClientInformation.fetch();
    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.verifyOTPConstant);
    http
        .post(url,
            body: jsonEncode({
          // @formatter:off
              ConstantValuesVLA.otpJsonKey: otpEntered,
              ConstantValuesVLA.deviceJsonKey: prefs.getString(ConstantValuesVLA.deviceIDJsonKey),
              ConstantValuesVLA.modelJsonKey: prefs.getString(ConstantValuesVLA.modelJsonKey),
              ConstantValuesVLA.idJsonKey: prefs.getString(ConstantValuesVLA.useridJsonKey)
              // @formatter:on
            }))
        .then((value) {
      // print("otp is otp is");
      // print(pickFromJson(value.body, ConstantValuesVLA.otpJsonKey).value.toString());
      if (otpEntered == pickFromJson(value.body, ConstantValuesVLA.otpJsonKey)
              .value
              .toString()) {
        showInvalidOTP = false;
        setState(() {
          showInvalidOTP;
        });
        setSharedPreference(value.body);
        setReferralCodes(value.body);
        stopCounting = true;

        if (prefs.getString(ConstantValuesVLA.usernameJsonKey) == null ||
            prefs.getString(ConstantValuesVLA.usernameJsonKey).toString().endsWith("null")) {

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NameBoardClassVLA()),);

        }

        if (deviceChanged) {
          goToDashboard();
        }
      } else {
        showInvalidOTP = true;
        setState(() {
          showInvalidOTP;
        });
      }
    });
  }

  void goToDashboard() {
    //ClientInformation info = await ClientInformation.fetch();
    var url = Uri.parse(ConstantValuesVLA.baseURLConstant +
        ConstantValuesVLA.oldUserAppConfigConstant);
    http
        .post(url,
            body: jsonEncode({
              "id": prefs.getString(ConstantValuesVLA.useridJsonKey),
              "version": "6.4.9",
              "version_code": "69",
              "model": prefs.getString(ConstantValuesVLA.modelJsonKey),
              "democode": "none",
              "token": "nuthoetnauheotnuhaotnehuotnea"
            }))
        .then((value) {
      deviceChangedSharedPref(value.body);
      // print("value.body");
      // print("nuthoetnauheotnuhaotnehuotnea");
      // print(value.body);
    });
  }

  void deviceChangedSharedPref(String body) {
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
          if ((listOfMyPlans[i]["class_id"].toString()==(
                  prefs.getString(ConstantValuesVLA.class_idJsonKey)!)) &&
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
                          (prefs.getString(ConstantValuesVLA.boardidJsonKey) ==
                                  "5")
                              ? PUCDashboardVLA()
                              : DashboardVLA()),
                  // PaymentSuccessVLA(() {})),
                  debugShowCheckedModeBanner:
                      (ConstantValuesVLA.baseURLConstant.contains("TEST") ||
                          razorPayKey.contains("test")),
                ))),
      );
    });
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
    checkInternetConnection();
    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.requestOTPConstant);
    http
        .post(url,
            body: jsonEncode({
              ConstantValuesVLA.mobileJsonKey: prefs.getString(ConstantValuesVLA.mobileJsonKey),
              ConstantValuesVLA.deviceJsonKey: prefs.getString(ConstantValuesVLA.deviceIDJsonKey)
            }))
        .then((value) {
      countDownSeconds = 90;
      stopCounting = false;
      startCountDown();
      setState(() {
        countDownSeconds;
      });
    });
  }

  void setSharedPreference(String body) {
    // @formatter:off
      prefs.setString(ConstantValuesVLA.districtJsonKey, pickFromJson(body, ConstantValuesVLA.districtJsonKey).value.toString());
      prefs.setString(ConstantValuesVLA.emailJsonKey, pickFromJson(body, ConstantValuesVLA.emailJsonKey).value.toString());
      prefs.setString(ConstantValuesVLA.dobJsonKey, pickFromJson(body, ConstantValuesVLA.dobJsonKey).value.toString());
      prefs.setString(ConstantValuesVLA.mobileJsonKey, pickFromJson(body, ConstantValuesVLA.mobileJsonKey).value.toString());
      prefs.setString(ConstantValuesVLA.otpJsonKey, pickFromJson(body, ConstantValuesVLA.otpJsonKey).value.toString());
      prefs.setString(ConstantValuesVLA.refferedJsonKey, pickFromJson(body, ConstantValuesVLA.refferedJsonKey).value.toString());
      prefs.setString(ConstantValuesVLA.statusJsonKey, pickFromJson(body, ConstantValuesVLA.statusJsonKey).value.toString());
      prefs.setString(ConstantValuesVLA.useridJsonKey, pickFromJson(body, ConstantValuesVLA.useridJsonKey).value.toString());
      prefs.setString(ConstantValuesVLA.user_idJsonKey, pickFromJson(body, ConstantValuesVLA.useridJsonKey).value.toString());
      prefs.setString(ConstantValuesVLA.usernameJsonKey, pickFromJson(body, ConstantValuesVLA.usernameJsonKey).value.toString());
      prefs.setString(ConstantValuesVLA.verifiedJsonKey, pickFromJson(body, ConstantValuesVLA.verifiedJsonKey).value.toString());
    // @formatter:on
  }

  void scrollToBottom() {
    Future.delayed(Duration(seconds: 1), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(seconds: 2), curve: Curves.bounceOut);
    });
  }

  void getDeviceModel() {
    if (kIsWeb) {
      DeviceInfoPlugin().webBrowserInfo.then((value) {
        prefs.setString(
            ConstantValuesVLA.modelJsonKey, value.userAgent.toString());
      });
    } else {
      if (Platform.isAndroid) {
        DeviceInfoPlugin().androidInfo.then((value) {
          prefs.setString(
              ConstantValuesVLA.modelJsonKey, value.model.toString());
        });
      } else if (Platform.isIOS) {
        DeviceInfoPlugin().iosInfo.then((value) {
          prefs.setString(
              ConstantValuesVLA.modelJsonKey, value.model.toString());
        });
      } else if (Platform.isLinux) {
        DeviceInfoPlugin().linuxInfo.then((value) {
          prefs.setString(
              ConstantValuesVLA.modelJsonKey, value.buildId.toString());
        });
      } else if (Platform.isMacOS) {
        DeviceInfoPlugin().macOsInfo.then((value) {
          prefs.setString(
              ConstantValuesVLA.modelJsonKey, value.model.toString());
        });
      } else if (Platform.isWindows) {
        DeviceInfoPlugin().windowsInfo.then((value) {
          prefs.setString(
              ConstantValuesVLA.modelJsonKey, value.numberOfCores.toString());
        });
      }
    }
  }

  void setReferralCodes(String body) {
    OTPVerifiedModelVLA otpVerifiedModelVLA =
        OTPVerifiedModelVLA.fromJson(jsonDecode(body));
    referralCodes = otpVerifiedModelVLA.coupenCodes;
  }
}
