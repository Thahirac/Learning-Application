import 'dart:convert';
import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

import '../../main.dart';
import '../no_internet_page_vla.dart';

class NotificationVLA extends StatefulWidget {
  final  thisSetNewScreenFunc;

  NotificationVLA(this.thisSetNewScreenFunc, {Key? key}) : super(key: key);

  @override
  State<NotificationVLA> createState() => _NotificationVLAState();
}

class _NotificationVLAState extends State<NotificationVLA> {
  List<Widget> listOfNotificationWidgets = [];
  double heightIs = 0, widthIs = 0;

  @override
  void initState() {
    //getNotificationList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: listOfNotificationWidgets.isNotEmpty ? Column(
          children: listOfNotificationWidgets,
            ): Center(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [

            SizedBox(height: heightIs * 0.35,),

              Text("No Notification Here")

          ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /*void getNotificationList() {
    ExternalPath.getExternalStorageDirectories().then((value) {
      File theNotificationFile = File(value.first.toString() + "/bluetoothErrorLog/bleLog");
      theNotificationFile.exists().then((notificationFileExists) {
        if (notificationFileExists) {
          theNotificationFile
              .readAsString()
              .then((theNotificationFileReadAsString) {
            var notiJson = jsonDecode(theNotificationFileReadAsString);
            print("*************************************${notiJson.toString()}");
            print("*************************************${notiJson.toString()}");
            print("*************************************${notiJson["notificationsArray"]}");
            List<dynamic> listOfNotifications = notiJson["notificationsArray"];
            prefs.setInt("notificationReadCount",listOfNotifications.length );
            for (int i = 0; i < listOfNotifications.length; i++) {
              //print(listOfNotifications[i]["image"]);
              listOfNotificationWidgets.add(Container(
                width: widthIs,
                margin: const EdgeInsets.fromLTRB(9, 9, 9, 0),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: ConstantValuesVLA.splashBgColor,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(18))),
                child: Column(
                  children: [
                    TextCustomVidwath(
                      textTCV: listOfNotifications[i]["tittle"],
                      fontSizeTCV: 21,
                      fontWeightTCV: FontWeight.bold,
                      textColorTCV: ConstantValuesVLA.splashBgColor,
                    ),
                    DividerCustomVidwath(),
                    TextCustomVidwath(
                      textTCV: listOfNotifications[i]["message"],
                      fontSizeTCV: 18,
                    ),
                    DividerCustomVidwath(),
                    ImageCustomVidwath(
                      imageUrlICV: listOfNotifications[i]["image"],
                      widthICV: widthIs,
                      heightICV: 207,
                    ),
                  ],
                ),
              ));
              setState(() {
                listOfNotificationWidgets;
              });
            }
            //print("notiJson.toString()***********");
          });
        }
      });
    });
  }*/


  Future<void> checkInternetConnection() async {
    bool result = await SimpleConnectionChecker.isConnectedToInternet();
    if (result == true) {} else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NoInternetPageVLA()),
      );
    }
  }

  Future<bool> onBackPressed() {
    listOfWidgetForBack.removeLast();
    widget.thisSetNewScreenFunc(listOfWidgetForBack.last, addToQueue: false);
    return Future.value(false);
  }
}


