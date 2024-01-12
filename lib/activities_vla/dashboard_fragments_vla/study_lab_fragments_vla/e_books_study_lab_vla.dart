// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../../../constants_vla/constant_values_vla.dart';
import '../../../main.dart';
import '../../../models_vla/e_books_model_study_lab_vla.dart';
import '../../../vidwath_custom_widgets/image_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/slide_transition_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/text_custom_vidwath.dart';

class EBooksStudyLabVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  EBooksStudyLabVLA(this.thisSetNewScreenFunc, {Key? key}) : super(key: key);

  @override
  State<EBooksStudyLabVLA> createState() => _EBooksStudyLabVLAState();
}

class _EBooksStudyLabVLAState extends State<EBooksStudyLabVLA> {
  List<Widget> beyondTextList = [];

  @override
  void initState() {
    super.initState();
    getEBooksListAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 302,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: beyondTextList,
        ),
      ),
    );
  }

  Future<void> getEBooksListAPI() async {
    var url = Uri.parse(
        ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.eBookConstant);
    http
        .post(url,
            body: jsonEncode({
              // "class_id": "10"
              ConstantValuesVLA.class_idJsonKey:
                  prefs.getString(ConstantValuesVLA.class_idJsonKey)
            }))
        .then((value) {
      List<dynamic> subjectListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < subjectListTemp.length; i++) {
        EBooksModelStudyLabVLA eBooksModelStudyLabVLA =
            EBooksModelStudyLabVLA.fromJson(subjectListTemp[i]);
        beyondTextList.add(
          SlideTransitionCustomVidwath(
            (i + 2),
            Offset(0.0, (1.5 * (i + 2))),
            GestureDetector(
              onTap: () {
                launch(eBooksModelStudyLabVLA.url);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0),),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8,bottom: 8),
                    child: ImageCustomVidwath(
                      imageUrlICV: eBooksModelStudyLabVLA.Thumbnail.trim().replaceAll(" ", ""),
                      widthICV: MediaQuery.of(context).size.width / 3,
                      heightICV: MediaQuery.of(context).size.width / 3,
                      aboveImageICV: eBooksModelStudyLabVLA.SubjectName,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        setState(() {
          beyondTextList;
        });
      }
    });
  }
}
