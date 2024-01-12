import 'package:flutter/material.dart';
import 'package:vel_app_online/constants_vla/constant_values_vla.dart';
import 'package:vel_app_online/vidwath_custom_widgets/text_custom_vidwath.dart';

class ShowLessVLA extends StatefulWidget {
  const ShowLessVLA({Key? key}) : super(key: key);

  @override
  State<ShowLessVLA> createState() => _ShowLessVLAState();
}

class _ShowLessVLAState extends State<ShowLessVLA> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: 90,
      height: 25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border:
              Border.all(color: ConstantValuesVLA.splashBgColor, width: 1.2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextCustomVidwath(
            textTCV: "Show Less",
            fontSizeTCV: 10,
            textColorTCV: ConstantValuesVLA.blackTextColor,
          ),
          Icon(Icons.arrow_drop_up,
              size: 20, color: ConstantValuesVLA.blackTextColor),
        ],
      ),
    );
  }
}
