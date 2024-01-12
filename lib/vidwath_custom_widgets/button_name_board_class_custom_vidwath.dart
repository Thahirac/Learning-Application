import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vel_app_online/constants_vla/constant_values_vla.dart';

class ButtonNameBoardClassCustomVidwath extends StatefulWidget {
  String textBCV;
  IconData iconBCV;
  double textSizeBCV;
  var onPressedBCV;
  bool enabledBCV;

  ButtonNameBoardClassCustomVidwath(
      {Key? key,
      this.textBCV = "",
      this.iconBCV = Icons.smart_button,
      this.onPressedBCV,
      this.textSizeBCV = 18,
      this.enabledBCV = false})
      : super(key: key);

  @override
  _ButtonNameBoardClassCustomVidwathState createState() =>
      _ButtonNameBoardClassCustomVidwathState();
}

class _ButtonNameBoardClassCustomVidwathState
    extends State<ButtonNameBoardClassCustomVidwath> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ElevatedButton(
        child: Container(
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.fromLTRB(3, 5, 5, 5),
            child: Text(widget.textBCV,
                style: TextStyle(fontSize: widget.textSizeBCV))),
        style: ButtonStyle(
            foregroundColor: widget.enabledBCV
                ? MaterialStateProperty.all<Color>(ConstantValuesVLA.whiteColor)
                : MaterialStateProperty.all<Color>(
                    ConstantValuesVLA.blackTextColor),
            backgroundColor: MaterialStateProperty.all<Color>(widget.enabledBCV
                ? ConstantValuesVLA.splashBgColor
                : ConstantValuesVLA.whiteColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(color: ConstantValuesVLA.splashBgColor)))),
        onPressed: widget.onPressedBCV,
      ),
    );
  }
}
