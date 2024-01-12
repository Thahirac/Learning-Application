import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:vel_app_online/constants_vla/constant_values_vla.dart';
import 'package:vel_app_online/vidwath_custom_widgets/text_custom_vidwath.dart';

class EachMCQOptionCustomVidwath extends StatefulWidget {
  var onpressed;
  Color? selectionContainerColor, selectionTextColor;
  String? optionString;
  String? abcdText;

  EachMCQOptionCustomVidwath(
      {this.onpressed,
      this.selectionContainerColor,
      this.selectionTextColor,
      this.abcdText,
      this.optionString});

  @override
  _EachMCQOptionCustomVidwathState createState() =>
      _EachMCQOptionCustomVidwathState();
}

class _EachMCQOptionCustomVidwathState
    extends State<EachMCQOptionCustomVidwath> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onpressed,
      child: Container(
        margin: const EdgeInsets.fromLTRB(9, 0, 9, 9),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0.0),
            color: Colors.white,
            border: Border.all(
                width: 2, color: const Color.fromRGBO(157, 196, 203, 1.0))),
        child: Row(
          children: [
            ClipOval(
              child: Container(
                color: widget.selectionContainerColor,
                padding: const EdgeInsets.fromLTRB(9, 5, 9, 5),
                child: TextCustomVidwath(
                  textTCV: widget.abcdText!,
                  textColorTCV: widget.selectionTextColor!,
                ),
              ),
            ),
            Container(
              color: const Color.fromRGBO(157, 196, 203, 1.0),
              width: 2,
              height: 54,
              margin: const EdgeInsets.fromLTRB(3, 0, 5, 0),
            ),
            Flexible(
              child: HtmlWidget(
                widget.optionString!,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
