import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:vel_app_online/vidwath_custom_widgets/divider_custom_vidwath.dart';

import '../../../../constants_vla/constant_values_vla.dart';
import '../../../../main.dart';
import '../../../../models_vla/subject_wise_analysis_model_vla.dart';
import '../../../../translation_vla/tr.dart';
import '../../../../vidwath_custom_widgets/image_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import 'each_subject_analysis_vla.dart';

class SubjectWiseAnalysisVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  SubjectWiseAnalysisVLA(this.thisSetNewScreenFunc, {Key? key});

  @override
  State<SubjectWiseAnalysisVLA> createState() => _SubjectWiseAnalysisVLAState();
}

late SubjectWiseAnalysisModelVLA subjectWiseAnalysisModelVLA;

class _SubjectWiseAnalysisVLAState extends State<SubjectWiseAnalysisVLA> {
  List<SubjectWiseAnalysisModelVLA> evaluateSubjectList = [];
  var rng = Random();
  double screenWidth = 0, screenHeight = 0;

  @override
  void initState() {
    super.initState();
    getTutorialVideoAPI();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: appBarHeight,
                child: Center(
                  child: TextCustomVidwath(
                    textTCV: TR.subject_wise_analysis[languageIndex],
                    fontSizeTCV: 18,
                    textColorTCV: ConstantValuesVLA.blackTextColor,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight - 198,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                    itemCount: evaluateSubjectList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (evaluateSubjectList[index]
                              .notes[0]
                              .progress
                              .toString()
                              .contains("0.0")) {


                      /*      var snackBar = const SnackBar(
                                content: Text(
                                    "Please take the quiz first to view progress."),
                                backgroundColor: Colors.red);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);*/



                            showDialog(context: context, builder: (context){
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(0))),
                                  title:  TextCustomVidwath(
                                    textTCV: 'Oops!!',
                                    fontWeightTCV: FontWeight.w800,
                                    textColorTCV: Colors.redAccent.shade700,
                                 fontSizeTCV: 22,
                                  ),
                                  content:  Text(
                                    "Please take the quiz to view progress.",
                                    style: TextStyle(color: Colors.black,fontSize: 13,overflow: TextOverflow.clip),
                                  ),
                                  actions: <Widget>[




                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                          backgroundColor: ConstantValuesVLA.splashBgColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onPressed: (){
                                          Navigator.pop(context);
                                        }, child:
                                        TextCustomVidwath(
                                          textTCV: 'OK',
                                          textColorTCV:Colors.white,
                                          fontWeightTCV: FontWeight.w500,
                                          fontSizeTCV: 18,
                                        ),

                                        ),
                                      ],
                                    ),

                                   SizedBox(height: 10,),



                                  ],
                                );

                            });



                          } else {
                            subjectWiseAnalysisModelVLA =
                                evaluateSubjectList[index];
                            widget.thisSetNewScreenFunc(EachSubjectAnalysisVLA(
                                widget.thisSetNewScreenFunc));
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.all(12),
                          height: 97,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 5,
                                    offset: Offset(3, 3),
                                    color: Color.fromRGBO(55, 71, 79, .3))
                              ],
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ImageCustomVidwath(
                                imageUrlICV: evaluateSubjectList[index].image,
                                widthICV: 72,
                                heightICV: 72,
                                aboveImageICV:
                                    evaluateSubjectList[index].SubjectName,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: screenWidth / 2,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            TextCustomVidwath(
                                              textTCV:
                                                  evaluateSubjectList[index]
                                                      .SubjectName,
                                              fontSizeTCV: 12.5,
                                              fontWeightTCV: FontWeight.w600,
                                            ),
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            TextCustomVidwath(
                                              textTCV: "Total Chapters: " +
                                                  evaluateSubjectList[index]
                                                      .notes[0]
                                                      .counts
                                                      .toString(),
                                              fontSizeTCV: 9.5,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 8,
                                    color: Colors.transparent,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(
                                      width: screenWidth / 2,
                                      child: LinearProgressBar(
                                        maxSteps: 100,
                                        progressType: LinearProgressBar
                                            .progressTypeLinear,
                                        currentStep: double.parse(
                                                evaluateSubjectList[index]
                                                    .notes[0]
                                                    .progress)
                                            .toInt(),
                                        progressColor: Colors.green,
                                        backgroundColor: Colors.grey.shade400,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 8,
                                    color: Colors.transparent,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextCustomVidwath(
                                      textTCV: "Progress(" +
                                          evaluateSubjectList[index]
                                              .notes[0]
                                              .progress +
                                          "%) ",
                                      fontSizeTCV: 11.5,
                                    ),
                                  ),
                                ],
                              ),

                              Icon(Icons.arrow_forward_ios_rounded,color: ConstantValuesVLA.splashBgColor,size: 17,)
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {
    var url = Uri.parse(ConstantValuesVLA.baseURLConstant +
        ConstantValuesVLA.subjectListAnalysisConstant);
    http
        .post(url,
            body: jsonEncode({
              ConstantValuesVLA.class_idJsonKey:
                  prefs.getString(ConstantValuesVLA.class_idJsonKey),
              ConstantValuesVLA.user_idJsonKey:
                  prefs.getString(ConstantValuesVLA.user_idJsonKey)
            }))
        .then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        evaluateSubjectList.add(
            SubjectWiseAnalysisModelVLA.fromJson(tutorialVideoListTemp[i]));
        //print(tutorialVideoListTemp[i]);
      }
      setState(() {
        evaluateSubjectList;
      });
    });
  }

  getDSERTorNCERT(String classIDStr, String subjcets) {
    int classid = int.parse(classIDStr);
    String strDSERTorNCERT = "";

    if (classid == 210 ||
        classid == 209 ||
        classid == 208 ||
        classid == 207 ||
        classid == 206 ||
        classid == 205 ||
        classid == 204 ||
        classid == 203 ||
        classid == 202 ||
        classid == 201) {
      if (subjcets.contains("English") || subjcets.contains("ಕನ್ನಡ")) {
        strDSERTorNCERT = TR.evaluate_ncert[languageIndex];
        //holder.types.setText(R.string.evaluate_ncert);
      } else {
        strDSERTorNCERT = TR.evaluate_pdfs[languageIndex];
        //holder.types.setText(R.string.evaluate_pdfs);
      }
    } else {
      if (subjcets.contains("English") ||
          subjcets.contains("ಕನ್ನಡ") ||
          subjcets.contains("اُردو  ") ||
          subjcets.contains("हिंदी 03")) {
        strDSERTorNCERT = TR.evaluate_dsert[
            languageIndex]; //holder.types.setText(R.string.evaluate_dsert);
      } else {
        strDSERTorNCERT = TR.evaluate_dsrt_pdfs[
            languageIndex]; //holder.types.setText(R.string.evaluate_dsrt_pdfs);
      }
    }
    return Row(
      children: [
        Container(
            width: MediaQuery.of(context).size.width - 117,
            margin: EdgeInsets.all(5),
            child: TextCustomVidwath(
              textTCV: strDSERTorNCERT,
              fontSizeTCV: 10,
              textColorTCV: ConstantValuesVLA.greyTextColor,
              textAlignTCV: TextAlign.center,
            )),
      ],
    );
  }

  Future<bool> onBackPressed() {
    /*widget.thisSetNewScreenFunc(AssessKitQuizVLA(widget.thisSetNewScreenFunc));
      widget.changeToAfterAssess;*/
    listOfWidgetForBack.removeLast();
    widget.thisSetNewScreenFunc(listOfWidgetForBack.last, addToQueue: false);
    return Future.value(false);
  }
}
