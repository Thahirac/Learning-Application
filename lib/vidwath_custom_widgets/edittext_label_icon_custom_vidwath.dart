import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vel_app_online/constants_vla/constant_values_vla.dart';
import 'package:vel_app_online/vidwath_custom_widgets/text_custom_vidwath.dart';

class EdittextLabelIconCustomVidwath extends StatefulWidget {
  String hintTextECV;
  String? titleECV;
  String prefixECV;
  int counterECV;
  int minNumberOfLinesECV;
  int maxNumberOfLinesECV;
  var onChangedECV;
  IconData labelIConECV;
  int maximumCharsECV;
  TextInputType textInputTypeECV;
  String? errortextECV;
  List<TextInputFormatter>? inputFormattersECV;
  int extraCharsCountECV = 0;
  String? initial_value;

  EdittextLabelIconCustomVidwath(
      {Key? key,
      this.hintTextECV = "",
      this.titleECV,
      this.onChangedECV,
      this.minNumberOfLinesECV = 1,
      this.maxNumberOfLinesECV = 504,
      this.labelIConECV = Icons.article_outlined,
      this.prefixECV = "",
      this.counterECV = 0,
      this.maximumCharsECV = 100,
      this.textInputTypeECV = TextInputType.text,
      this.errortextECV = null,
      this.inputFormattersECV = null,
      this.extraCharsCountECV = 0,
      this.initial_value,
      })
      : super(key: key);

  @override
  _EdittextLabelIconCustomVidwathState createState() =>
      _EdittextLabelIconCustomVidwathState();
}

class _EdittextLabelIconCustomVidwathState
    extends State<EdittextLabelIconCustomVidwath> {
  @override
  void initState() {
    super.initState();
    if (widget.inputFormattersECV == null) {
      widget.inputFormattersECV = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       margin: const EdgeInsets.fromLTRB(2, 5, 2, 0),
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: TextFormField(
        initialValue: widget.initial_value,
        style: const TextStyle(fontSize: 16),
        maxLength: widget.maximumCharsECV,
        keyboardType: widget.textInputTypeECV,
        inputFormatters: widget.inputFormattersECV,
        decoration: InputDecoration(
          //hintText: widget.hintTextECV,
          hintText: widget.hintTextECV,
          hintStyle: TextStyle(fontSize: 14),
          /*label: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(
                widget.labelIConECV,
                size: 36,
                color: Colors.grey,
              ),
              const SizedBox(
                width: 27,
                height: 1,
              ),
              TextCustomVidwath(
                textTCV: widget.titleECV,
                textColorTCV: Colors.black,
              )
            ],
          ),*/
          counter: (widget.counterECV > 0)
              ? Text(
                  widget.counterECV.toString() +
                      "/" +
                      (widget.maximumCharsECV - widget.extraCharsCountECV)
                          .toString(),
                  style: TextStyle(
                      color: widget.counterECV ==
                              (widget.maximumCharsECV -
                                  widget.extraCharsCountECV)
                          ? Colors.black
                          : ConstantValuesVLA.splashBgColor,
                      fontWeight: FontWeight.w300),
                )
              : const Text(""),
          prefixText: widget.prefixECV,
          prefixStyle: const TextStyle(color: Colors.blue, fontSize: 16),
          suffixText: widget.prefixECV,
          suffixStyle: const TextStyle(color: Colors.transparent, fontSize: 16),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.blue,
            ),
          ),
          prefixIcon:    Icon(
            widget.labelIConECV,
            size: 30,
            color: ConstantValuesVLA.splashBgColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
          errorText: widget.errortextECV,
        ),
        textAlign: TextAlign.start,
        onChanged: widget.onChangedECV,
        minLines: widget.minNumberOfLinesECV,
        maxLines: widget.maxNumberOfLinesECV,
        autofocus: false,
      ),
    );
  }
}
