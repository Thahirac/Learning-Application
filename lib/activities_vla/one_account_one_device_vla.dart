import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:vel_app_online/activities_vla/sign_up_vla.dart';

import '../constants_vla/constant_values_vla.dart';
import '../main.dart';
import '../translation_vla/tr.dart';
import '../vidwath_custom_widgets/button_custom_vidwath.dart';
import '../vidwath_custom_widgets/divider_custom_vidwath.dart';

class OneAccountOneDeviceVLA extends StatefulWidget {
  const OneAccountOneDeviceVLA({Key? key}) : super(key: key);

  @override
  State<OneAccountOneDeviceVLA> createState() => _OneAccountOneDeviceVLAState();
}

class _OneAccountOneDeviceVLAState extends State<OneAccountOneDeviceVLA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      "assets/splash_back.png",
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                    ),
                    Align(
                      child: Image.asset("assets/splash_front.png"),
                      alignment: Alignment.topCenter,
                    ),
                  ],
                ),
                DividerCustomVidwath(),
                Container(
                  margin: const EdgeInsets.all(9),
                  padding: const EdgeInsets.all(9),
                  child: Text(
                    TR.oneAccountOneDevice[languageIndex],
                    style: const TextStyle(
                        fontSize: 23,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                DividerCustomVidwath(),
                ButtonCustomVidwath(
                  textBCV: "I understand",
                  onPressedBCV: () {
                    listOfWidgetForBack = [];
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpVLA()),
                    );
                  },
                ),
                DividerCustomVidwath(),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void getDeviceId() {
    PlatformDeviceId.getDeviceId.then((theDeviceID) {
      prefs.setString(ConstantValuesVLA.deviceIDJsonKey, theDeviceID.toString());
      prefs.setString(ConstantValuesVLA.deviceJsonKey, theDeviceID.toString());
      getDeviceModel();
    });
  }

  void getDeviceModel() {
    if (kIsWeb) {
      DeviceInfoPlugin().webBrowserInfo.then((value) {
        prefs.setString(ConstantValuesVLA.modelJsonKey, value.userAgent.toString());
      });
    } else {
      if (Platform.isAndroid) {
        DeviceInfoPlugin().androidInfo.then((value) {
          prefs.setString(ConstantValuesVLA.modelJsonKey, value.model.toString());
        });
      } else if (Platform.isIOS) {
        DeviceInfoPlugin().iosInfo.then((value) {
          prefs.setString(ConstantValuesVLA.modelJsonKey, value.model.toString());
        });
      } else if (Platform.isLinux) {
        DeviceInfoPlugin().linuxInfo.then((value) {
          prefs.setString(ConstantValuesVLA.modelJsonKey, value.buildId.toString());
        });
      } else if (Platform.isMacOS) {
        DeviceInfoPlugin().macOsInfo.then((value) {
          prefs.setString(ConstantValuesVLA.modelJsonKey, value.model.toString());
        });
      } else if (Platform.isWindows) {
        DeviceInfoPlugin().windowsInfo.then((value) {
          prefs.setString(ConstantValuesVLA.modelJsonKey, value.numberOfCores.toString());
        });
      }
    }
  }

  @override
  void initState() {
    prefs.clear().then((value) {
      getDeviceId();
    });
    super.initState();
  }
}
