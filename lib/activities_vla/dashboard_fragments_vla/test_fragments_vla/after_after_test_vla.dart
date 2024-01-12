import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vel_app_online/vidwath_custom_widgets/slide_transition_custom_vidwath.dart';

import '../../../constants_vla/constant_values_vla.dart';
import '../../../main.dart';
import '../../../models_vla/after_after_test_model_vla.dart';
import '../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import '../evaluate_page_fragments_vla/assess_kit_quiz_fragments_vla/pdf_viewer_vla.dart';

class AfterAfterTestVLA extends StatefulWidget {
  var thisSetNewScreenFunc;
  String subject_idSelected = "", session_idSelected = "",SubjectName="";

  AfterAfterTestVLA(this.thisSetNewScreenFunc, this.subject_idSelected,
      this.session_idSelected,this.SubjectName,
      {Key? key});

  @override
  State<AfterAfterTestVLA> createState() => _AfterAfterTestVLAState();
}

class _AfterAfterTestVLAState extends State<AfterAfterTestVLA> {
  List<Widget> widgetLists = [];
  var rng = Random();
  double screenWidth = 0, screenHeight = 0;

  @override
  void initState() {
    super.initState();
    getTutorialVideoAPI();

    Future.delayed(Duration(seconds: 1), () {
      appBarTitle = widget.SubjectName.toString();
      widget.thisSetNewScreenFunc(Container(),
          addToQueue: false, changeAppBar: true);
    });

  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: screenWidth,
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: widgetLists,
          ),
        ),
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {


    print('**************SUBJECT ID***************${widget.subject_idSelected}');

    print('**************SESSION ID***************${widget.session_idSelected}');

    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.afterAfterTestConstant);
    http
        .post(url,
            body: jsonEncode({
              // "topic_id": "2001", "type": "4"
              ConstantValuesVLA.subject_idJsonKey: widget.subject_idSelected,
              ConstantValuesVLA.session_idJsonKey: widget.session_idSelected
            }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        // https://cdn.vidwathinfra.com/Android_Online/application/Vidwath/CBSE/G10/Maths/NCERT/CG10MNC1.1.pdf
        AfterAfterTestModelVLA temp =
            AfterAfterTestModelVLA.fromJson(tutorialVideoListTemp[i]);
        widgetLists.add(SlideTransitionCustomVidwath(
          (i + 2),
          Offset(0.0, (1.5 * (i + 2))),
          Container(
            height: 185,
            width: 143,
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(2),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return PDFViewerVLA(
                        widget.thisSetNewScreenFunc,
                        "https://vidwathapp.b-cdn.net/Android_Online/application/" +
                            temp.ContentPath.trim() +
                            "/" +
                            temp.FileName.trim() +
                            ".pdf",
                        temp.concept);
                  }),
                );
              },
              child: Card(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/pdf.png",
                     width: 180,
                    ),
                    TextCustomVidwath(
                      textTCV: temp.concept,
                      fontSizeTCV: 12.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
      }
      setState(() {
        widgetLists;
      });
    });
  }

  Future<bool> onBackPressed() {
    /*widget.thisSetNewScreenFunc(AssessKitQuizVLA(widget.thisSetNewScreenFunc));
    widget.changeToAfterAssess;*/
    listOfWidgetForBack.removeLast();
    widget.thisSetNewScreenFunc(listOfWidgetForBack.last, addToQueue: false);
    return Future.value(false);
  }
}
