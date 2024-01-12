import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vel_app_online/activities_vla/dashboard_vla.dart';
import 'package:vel_app_online/activities_vla/no_internet_page_vla.dart';
import 'package:vel_app_online/activities_vla/one_account_one_device_vla.dart';
import 'package:vel_app_online/activities_vla/sign_up_vla.dart';
import 'package:vel_app_online/puc_vla/puc_dashboard_vla.dart';

import '../constants_vla/constant_values_vla.dart';
import '../main.dart';

class SplashVLA extends StatefulWidget {
  const SplashVLA({Key? key}) : super(key: key);

  @override
  _SplashVLAState createState() => _SplashVLAState();
}

class _SplashVLAState extends State<SplashVLA> {
  //common for all start -a
  double screenWidth = 0, screenHeight = 0;
  bool isPortrait = true;

  //common for all end -a

  List<TypewriterAnimatedText> subtitleList = [];
  var randomInstance = Random();

  void getDeviceId() {
    PlatformDeviceId.getDeviceId.then((theDeviceID) {
      prefs.setString(ConstantValuesVLA.deviceIDJsonKey, theDeviceID.toString());
      prefs.setString(ConstantValuesVLA.deviceJsonKey, theDeviceID.toString());
      // print("prefs.getString(ConstantValuesVLA.deviceIDJsonKey)");
      // print(prefs.getString(ConstantValuesVLA.deviceIDJsonKey));
      getDeviceModel();
      // print("getDeviceModel();");
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
          goToHome();
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

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
      SharedPreferences.getInstance().then((value) {
        prefs = value;
        // print("SharedPreferences");
        if (prefs.getInt("languageIndex") == null) {
          languageIndex = 0;
        } else {
          languageIndex = prefs.getInt("languageIndex")!;
        }
        getDeviceId();
      });
      ///TS Changed Code
      checkInternetConnection();
    });
    addSubtitleArray();
  }

  Future<void> checkInternetConnection() async {
    bool result = await SimpleConnectionChecker.isConnectedToInternet();
    if (result == true) {
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NoInternetPageVLA()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //common for all start -b
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    //common for all end -b

    return Scaffold(
      backgroundColor: ConstantValuesVLA.splashBgColor,
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Center(
          child: SizedBox(
            height: 306,
            child: Padding(
              padding: EdgeInsets.all(36),
              child: Column(
                children: [
                  Image.asset(ConstantValuesVLA.logoImage),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: isPortrait
                          ? EdgeInsets.fromLTRB(0, 0, screenWidth * .025, 0)
                          : EdgeInsets.fromLTRB(0, 0, screenWidth * .2, 0),
                      width: screenWidth * .75,
                      child: DefaultTextStyle(
                        style: TextStyle(
                            fontSize: 23.0,
                            color: ConstantValuesVLA.liteTextColor),
                        child: AnimatedTextKit(
                          pause: const Duration(seconds: 1),
                          isRepeatingAnimation: false,
                          animatedTexts: [
                            // @formatter:off
                              TypewriterAnimatedText('Space for Learning', textAlign: TextAlign.end),
                              subtitleList[
                                  randomInstance.nextInt(subtitleList.length-1)],
                            // @formatter:on
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addSubtitleArray() {
    // @formatter:off
    subtitleList.add(TypewriterAnimatedText('Interactive Learning',
        textAlign: TextAlign.end));
    subtitleList.add(TypewriterAnimatedText('Toppers Notes and Webinars',
        textAlign: TextAlign.end));
    subtitleList.add(TypewriterAnimatedText('Self Assessment Kit available',
        textAlign: TextAlign.end));
    subtitleList.add(TypewriterAnimatedText('Handy NCERT and DSERT Solutions',
        textAlign: TextAlign.end));
    subtitleList.add(TypewriterAnimatedText('Updated Syllabus Content',
        textAlign: TextAlign.end));
    subtitleList.add(TypewriterAnimatedText('Easy to reach Science Lab',
        textAlign: TextAlign.end));
    subtitleList.add(TypewriterAnimatedText(
        'Analytics to Identify Area of Improvements',
        textAlign: TextAlign.end));
    subtitleList.add(
        TypewriterAnimatedText('Digi Books at Hand', textAlign: TextAlign.end));
    subtitleList.add(TypewriterAnimatedText('Appreciated by DSERT and NCERT',
        textAlign: TextAlign.end));
    subtitleList.add(TypewriterAnimatedText('Mind Map at finger tips',
        textAlign: TextAlign.end));
    subtitleList.add(TypewriterAnimatedText('Animated Videos at disposal',
        textAlign: TextAlign.end));
    subtitleList.add(TypewriterAnimatedText(
        'Syllabus Based Conceptual Learning',
        textAlign: TextAlign.end));
   subtitleList.add(TypewriterAnimatedText('Convenient Tutorial Videos',
        textAlign: TextAlign.end));
    subtitleList
        .add(TypewriterAnimatedText('Quiz Space', textAlign: TextAlign.end));

    subtitleList.shuffle();
    // @formatter:on
  }

  void goToHome() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (prefs.getString(ConstantValuesVLA.class_idJsonKey) != null &&
          prefs.getString(ConstantValuesVLA.regionJsonKey) != null &&
          prefs.getString(ConstantValuesVLA.boardidJsonKey) != null &&
          prefs.getString(ConstantValuesVLA.classnameJsonKey) != null &&
          prefs.getString(ConstantValuesVLA.boardidJsonKey) != null &&
          prefs.getString(ConstantValuesVLA.user_idJsonKey) != null &&
          prefs.getString(ConstantValuesVLA.deviceJsonKey) != null &&
          //prefs.getString(ConstantValuesVLA.modelJsonKey) != null &&
          prefs.getString(ConstantValuesVLA.useridJsonKey) != null &&
          prefs.getString(ConstantValuesVLA.mobileJsonKey) != null &&
          prefs.getString(ConstantValuesVLA.deviceIDJsonKey) != null) {
        checkUserAndDevice();
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignUpVLA()),
        );
      }
    });
  }

  Future<void> checkUserAndDevice() async {
    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.requestOTPConstant);


    //print('****************MOBILE***********************${prefs.getString(ConstantValuesVLA.mobileJsonKey)}');

    //print('*****************DEVICE ID**********************${prefs.getString(ConstantValuesVLA.deviceIDJsonKey)}');


    http.post(url,
            body: jsonEncode({
              ConstantValuesVLA.mobileJsonKey: prefs.getString(ConstantValuesVLA.mobileJsonKey),
              ConstantValuesVLA.deviceJsonKey: prefs.getString(ConstantValuesVLA.deviceIDJsonKey)
            }))
        .then((value) {
      var jsonDecoded = jsonDecode(value.body);
      // print("signup jsonDecoded user");
      print('****************USER *****************${jsonDecoded["user"].toString()}');
      // print(prefs.getString(ConstantValuesVLA.deviceIDJsonKey));
      if (jsonDecoded["user"].toString().contains("device changed")) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OneAccountOneDeviceVLA()),
        );
      }
      if (jsonDecoded["user"].toString().contains("olduser")) {
        checkForSubscription();
      }
    });
  }

  void checkForSubscription() {
    http.post(Uri.parse(
                ConstantValuesVLA.baseURLConstant + "mysubscriptions.php"),
            body: jsonEncode({
              ConstantValuesVLA.user_idJsonKey:
                  prefs.getString(ConstantValuesVLA.user_idJsonKey)
            }))
        .then((value) {
      if (!value.body.toString().contains("notfound")) {
        List<dynamic> listOfMyPlans = jsonDecode(value.body).toList();
        for (int i = 0; i < listOfMyPlans.length; i++) {
          if ((listOfMyPlans[i]["class_id"].toString() == (prefs.getString(ConstantValuesVLA.class_idJsonKey)!)) && (listOfMyPlans[i]["active"].toString().contains("1"))) {
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
                      child: (prefs.getString(ConstantValuesVLA.boardidJsonKey) == "5")
                              ? PUCDashboardVLA()
                              : DashboardVLA()),
                  // PaymentSuccessVLA(() {})),
                  debugShowCheckedModeBanner: (ConstantValuesVLA.baseURLConstant.contains("TEST") || razorPayKey.contains("test")),
                ))),
      );
    });
  }
}
