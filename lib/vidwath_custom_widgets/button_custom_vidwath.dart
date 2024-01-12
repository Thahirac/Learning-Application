import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonCustomVidwath extends StatefulWidget {
  String textBCV;
  Color enabledBgColorBCV;
  Color disabledBgColorBCV;
  Color textColorBCV;
  double textSizeBCV;
  var onPressedBCV;
  bool enabledBCV;

  ButtonCustomVidwath(
      {Key? key,
      this.textBCV = "",
      this.onPressedBCV,
      this.textSizeBCV = 18,
      this.enabledBgColorBCV = Colors.blue,
      this.textColorBCV = Colors.white,
      this.enabledBCV = true,
      this.disabledBgColorBCV = Colors.grey})
      : super(key: key);

  @override
  _ButtonCustomVidwathState createState() => _ButtonCustomVidwathState();
}

class _ButtonCustomVidwathState extends State<ButtonCustomVidwath> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(9, 0, 9, 9),
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        child: Container(
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.fromLTRB(5, 9, 9, 9),
            child: Text(widget.textBCV, style: TextStyle(fontSize: widget.textSizeBCV))),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(widget.textColorBCV),
            backgroundColor: MaterialStateProperty.all<Color>(widget.enabledBCV ? widget.enabledBgColorBCV : widget.disabledBgColorBCV),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),side: BorderSide(color: widget.textColorBCV,)))),
        onPressed: widget.onPressedBCV,
      ),
    );
  }
}
