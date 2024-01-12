import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vel_app_online/main.dart';

class TextCustomVidwath extends StatefulWidget {
  String textTCV;
  Color textColorTCV;
  TextAlign textAlignTCV;
  double fontSizeTCV;
  FontWeight fontWeightTCV;
  TextDecoration textDecoration;
  int maxLines;



  TextCustomVidwath(
      {this.textTCV = "",
      this.textColorTCV = Colors.black,
      this.textAlignTCV = TextAlign.center,
      this.fontSizeTCV = 16,
      this.fontWeightTCV = FontWeight.normal,
      this.textDecoration = TextDecoration.none,
      this.maxLines = 1,});

  @override
  _TextCustomVidwathState createState() => _TextCustomVidwathState();
}

class _TextCustomVidwathState extends State<TextCustomVidwath> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(1),
      child: Text(
        widget.textTCV,
        style: TextStyle(
            fontFamily: (languageIndex == 2) ? 'Jameel Noori Nastaleeq' : 'Roboto',
            fontSize: (languageIndex == 2) ? widget.fontSizeTCV + 2 : widget.fontSizeTCV,
            color: widget.textColorTCV,
            fontWeight: widget.fontWeightTCV,
            overflow: TextOverflow.ellipsis,
            decoration: widget.textDecoration,
        ),
        textAlign: widget.textAlignTCV,
        maxLines: widget.maxLines,
        softWrap: false,
      ),
    );
  }
}
