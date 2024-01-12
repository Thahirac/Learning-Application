import 'package:flutter/material.dart';
import 'package:vel_app_online/constants_vla/constant_values_vla.dart';
import 'package:vel_app_online/vidwath_custom_widgets/text_custom_vidwath.dart';

class EachTabCustomVidwath extends StatefulWidget {
  bool conditionForColor = false;
  String tabText = "";

  EachTabCustomVidwath(this.tabText, this.conditionForColor, {Key? key})
      : super(key: key);

  @override
  State<EachTabCustomVidwath> createState() => _EachTabCustomVidwathState();
}

class _EachTabCustomVidwathState extends State<EachTabCustomVidwath> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 36,
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: (widget.conditionForColor)
              ? ConstantValuesVLA.splashBgColor
              : ConstantValuesVLA.tabColor,
          borderRadius: const BorderRadius.all(Radius.circular(9))),
      duration: const Duration(milliseconds: 1530),
      child: Center(
        child: TextCustomVidwath(
          textTCV: widget.tabText,
          textColorTCV: ConstantValuesVLA.whiteColor,
          fontSizeTCV: 12,
        ),
      ),
    );
  }
}
