// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../constants_vla/constant_values_vla.dart';
import '../../../main.dart';
import '../../../models_vla/beyond_text_model_vla.dart';
import '../../../vidwath_custom_widgets/image_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import 'beyond_text_details_learn_vla.dart';


class BeyondTextLearnVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  BeyondTextLearnVLA(this.thisSetNewScreenFunc, {Key? key}) : super(key: key);

  @override
  State<BeyondTextLearnVLA> createState() => _BeyondTextLearnVLAState();
}

class _BeyondTextLearnVLAState extends State<BeyondTextLearnVLA> {
  List<Widget> beyondTextList = [];

  @override
  void initState() {
    super.initState();
    getBeyondTextListAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: beyondTextList,
    );
  }

  Future<void> getBeyondTextListAPI() async {
    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.beyondTextConstant);
    http.post(url, body: jsonEncode({
      ConstantValuesVLA.medium_idJsonKey: prefs.getString(ConstantValuesVLA.boardidJsonKey),
    })).then((value) {
      List<dynamic> subjectListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < subjectListTemp.length; i++) {
        BeyondTextModelVLA beyondTextModelVLA = BeyondTextModelVLA.fromJson(subjectListTemp[i]);
        beyondTextList.add(GestureDetector(
          onTap: () {
            widget.thisSetNewScreenFunc(BeyondTextDetailsLearnVLA(
                widget.thisSetNewScreenFunc,
                beyondTextModelVLA.name,
                beyondTextModelVLA.path,
                beyondTextModelVLA.filename,
            )
            );
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(1,1,1,1),
            width: MediaQuery.of(context).size.width/4.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageCustomVidwath(
                  imageUrlICV: beyondTextModelVLA.thumbnail,
                  heightICV: 90,
                  widthICV: 90,
                  aboveImageICV: beyondTextModelVLA.name,
                ),
                TextCustomVidwath(
                  textTCV: beyondTextModelVLA.name,
                  fontSizeTCV: 10,
                )
              ],
            ),
          ),
        ));
        setState(() {
          beyondTextList;
        });
      }
    });
  }
}
