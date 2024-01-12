import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EachLearnBeyondCustomVidwath extends StatefulWidget {
  String textTCV;
  Color textColorTCV;
  TextAlign textAlignTCV;
  double fontSizeTCV;
  FontWeight fontWeightTCV;

  EachLearnBeyondCustomVidwath(
      {this.textTCV = "",
      this.textColorTCV = Colors.black,
      this.textAlignTCV = TextAlign.center,
      this.fontSizeTCV = 16,
      this.fontWeightTCV = FontWeight.normal});

  @override
  _EachLearnBeyondCustomVidwathState createState() =>
      _EachLearnBeyondCustomVidwathState();
}

class _EachLearnBeyondCustomVidwathState
    extends State<EachLearnBeyondCustomVidwath> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(""),
      ],
    );
  }
}
