import 'package:flutter/material.dart';

import '../activities_vla/dashboard_fragments_vla/notification_vla.dart';
import '../constants_vla/constant_values_vla.dart';
import '../main.dart';
class NotificationIcon extends StatelessWidget {

  const NotificationIcon({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return notification_icon(context);
  }

  Widget notification_icon(BuildContext context){

    return Container(
      width: 30,
      height: 30,
      child: Stack(
        children: [
          Icon(
            Icons.notifications_none,
            color: ConstantValuesVLA.splashBgColor,
            size: 28,
          ),
          Container(
            width: 27,
            height: 30,
            alignment: Alignment.topRight,
            margin: const EdgeInsets.only(top: 0),
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                  border: Border.all(
                      color: Colors.white, width: 1)),
              child: const Padding(
                padding: EdgeInsets.all(0.0),
                child: Center(
                  child: Text(
                    "0",
                    style: TextStyle(
                        fontSize: 8, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );




  }
}
