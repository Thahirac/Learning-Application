import 'package:flutter/material.dart';
import 'package:vel_app_online/constants_vla/constant_values_vla.dart';
import 'package:vel_app_online/vidwath_custom_widgets/text_custom_vidwath.dart';

class ShowMoreVLA extends StatefulWidget {
  const ShowMoreVLA({Key? key}) : super(key: key);

  @override
  State<ShowMoreVLA> createState() => _ShowMoreVLAState();
}

class _ShowMoreVLAState extends State<ShowMoreVLA> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: 90,
      height: 25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
              color: ConstantValuesVLA.splashBgColor,
              width: 1.2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextCustomVidwath(
            textTCV: "Show More",
            fontSizeTCV: 10,
            textColorTCV: ConstantValuesVLA.blackTextColor,
          ),
          Icon(Icons.arrow_drop_down,
              size: 20,
              color: ConstantValuesVLA.blackTextColor),

        ],
      ),
    );
  }
}
