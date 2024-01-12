import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

import '../constants_vla/constant_values_vla.dart';
import '../main.dart';
import '../puc_vla/puc_dashboard_vla.dart';
import '../translation_vla/tr.dart';
import '../vidwath_custom_widgets/button_custom_vidwath.dart';
import '../vidwath_custom_widgets/divider_custom_vidwath.dart';
import 'dashboard_vla.dart';

class NoInternetPageVLA extends StatefulWidget {
  const NoInternetPageVLA({Key? key}) : super(key: key);

  @override
  State<NoInternetPageVLA> createState() => _NoInternetPageVLAState();
}

class _NoInternetPageVLAState extends State<NoInternetPageVLA> {
  late BuildContext bodyContext;

  @override
  Widget build(BuildContext context) {
    bodyContext = context;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      TR.noInternetPage[languageIndex],
                      style: const TextStyle(
                          fontSize: 23,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  DividerCustomVidwath(),
                  const Icon(
                    Icons.signal_wifi_connected_no_internet_4,
                    size: 36,
                    color: Colors.redAccent,
                  ),
                  DividerCustomVidwath(),
                  ButtonCustomVidwath(
                    textBCV: TR.openNetworkSettings[languageIndex],
                    textSizeBCV: 16,
                    textColorBCV: Colors.white,
                    onPressedBCV: () {
                      AppSettings.openAppSettings(type: AppSettingsType.wireless,);
                    },
                  ),
                  DividerCustomVidwath(),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  Future<bool> onBackPressed() {
    SimpleConnectionChecker.isConnectedToInternet().then((value) {
      if (value) {
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
                        child: (prefs.getString(
                                    ConstantValuesVLA.boardidJsonKey) ==
                                "5")
                            ? PUCDashboardVLA()
                            : DashboardVLA()),
                debugShowCheckedModeBanner:
                (ConstantValuesVLA.baseURLConstant.contains("TEST") ||
                    razorPayKey.contains("test")),                  ))),
        );
      } else {
        var snackBar = const SnackBar(
            content: Text("Need internet connection to proceed"),
            backgroundColor: Colors.red);
        ScaffoldMessenger.of(bodyContext).showSnackBar(snackBar);
      }
    });
    return Future.value(false);
  }

  @override
  void initState() {
    super.initState();
  }
}
