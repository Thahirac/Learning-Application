import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:http/http.dart' as http;

import '../../../../constants_vla/constant_values_vla.dart';
import '../../../../main.dart';
import '../../../../translation_vla/tr.dart';
import '../../../../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import 'dart:ui' as ui;

class EachTopicEachAttemptMCQResultLikeVLA extends StatefulWidget {
  var thisSetNewScreenFunc;
  String choosenMcq;
  int i;

  EachTopicEachAttemptMCQResultLikeVLA(
      this.thisSetNewScreenFunc, this.choosenMcq, this.i);

  @override
  State<EachTopicEachAttemptMCQResultLikeVLA> createState() =>
      _EachTopicEachAttemptMCQResultLikeVLAState();
}

class _EachTopicEachAttemptMCQResultLikeVLAState
    extends State<EachTopicEachAttemptMCQResultLikeVLA> {
  // TODO COMMENT BELOW LINES
  // int correctAnswerCount = 90, wrongAnswerCount = 5, unAnsweredCount = 5;
  int correctAnswerCount = 0,
      wrongAnswerCount = 0,
      unAnsweredCount = 0,
      totalTimeTaken = 0;
  late Map<String, double> moduleAndTimeMap;
  late Map<String, String> moduleAndNameMap;
  List<Widget> listOfEachTopicWidget = [];

  String titleBasedOnPercentage = "";
  double percentageIs = 0.0;

  double heightIs = 0, widthIs = 0;

  Color greenOrRed = Colors.white;
  bool showModuleMap = false;

  String? actualTestDuration="";

  @override
  void initState() {
    getViewDetailsTopicAnalysis();
    moduleAndTimeMap = {
      "Unanswered": 1,
      "Correct Answer": 1,
      "Wrong Answer": 1,
    };

    super.initState();
  }



  void intToTimeLeft(int value) {
    int h, m, s;

    h = value ~/ 3600;

    m = ((value - h * 3600)) ~/ 60;

    s = value - (h * 3600) - (m * 60);

    String hourLeft = h.toString().length < 2 ? "0" + h.toString() : h.toString();

    String minuteLeft =
    m.toString().length < 2 ? "0" + m.toString() : m.toString();

    String secondsLeft =
    s.toString().length < 2 ? "0" + s.toString() : s.toString();

    actualTestDuration = "$minuteLeft:$secondsLeft";

    // return actualTestDuration;
  }

  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        onWillPop: onBackPressed,
        child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: EdgeInsets.all(9),
                    child: Column(
                      children: [
                        DividerCustomVidwath(dividerHeight: 4,),
                        AnimatedContainer(
                          height: 160,
                          duration: const Duration(seconds: 2),
                          padding: const EdgeInsets.fromLTRB(12, 3, 3, 3),
                          child: showModuleMap
                              ? PieChart(
                            chartType: ChartType.ring,
                            ringStrokeWidth: 25,
                            //chartRadius: MediaQuery.sizeOf(context).width / 2,
                            dataMap: moduleAndTimeMap,
                            colorList: const [
                              Color.fromRGBO(76, 176, 80, 1),
                              Color.fromRGBO(244, 66, 54, 1),
                              Color.fromRGBO(255, 151, 0, 1)
                            ],
                            animationDuration: const Duration(seconds: 3),

                            chartLegendSpacing: 50,
                            //chartRadius: 250,
                            initialAngleInDegree: 0,

                            centerText: "Test \nScore \n" + (percentageIs * 100).toStringAsFixed(0) + "%",
                            centerTextStyle: TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.w400),
                            legendOptions: LegendOptions(
                              showLegendsInRow: false,
                              legendPosition: LegendPosition.right,
                              showLegends: true,
                              legendShape: BoxShape.rectangle,
                              legendTextStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10
                              ),
                            ),


                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: false,
                              showChartValuesOutside: true,
                              showChartValueBackground: true,
                              showChartValues: true,
                              chartValueBackgroundColor: Colors.transparent,
                              decimalPlaces: 0,
                              chartValueStyle: TextStyle(
                                color: ConstantValuesVLA.splashBgColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),

                            ),
                          )
                              : Container(
                            height: 151,
                          ),
                        ),


                        DividerCustomVidwath(dividerHeight: 4,),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 15),
                child: Container(
                  width: widthIs,
                  padding: const EdgeInsets.all(9),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          offset: Offset(3, 3),
                          color: Color.fromRGBO(55, 71, 79, .3))
                    ],
                  ),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              margin: const EdgeInsets.fromLTRB(9, 0, 0, 0),
                              child: TextCustomVidwath(
                                textTCV: TR.evaluation[languageIndex],
                                fontSizeTCV: 15,
                                fontWeightTCV: FontWeight.bold,
                              ))),
                      DividerCustomVidwath(dividerHeight: 3,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(9, 0, 0, 0),
                          child: TextCustomVidwath(
                            textTCV: "${TR.total_time_spent[languageIndex]} $totalTimeTaken Seconds.",
                            fontSizeTCV: 12,
                            textColorTCV: ConstantValuesVLA.splashBgColor,
                            fontWeightTCV: FontWeight.bold,
                          ),
                        ),
                      ),
                      DividerCustomVidwath(dividerHeight: 3,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: widthIs / 3,
                            height: widthIs / 3,
                            padding: const EdgeInsets.all(9),
                            margin: const EdgeInsets.all(9),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Color(0xffe8eeed)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/test.png",
                                  width: widthIs / 8.5,
                                  color: greenOrRed,
                                ),
                                TextCustomVidwath(
                                  textTCV: TR.accuracy_level[languageIndex],
                                  fontSizeTCV: 12,
                                  fontWeightTCV: FontWeight.bold,
                                  textColorTCV: greenOrRed,
                                ),
                                TextCustomVidwath(
                                  textTCV:
                                      (percentageIs * 100).toStringAsFixed(0) +
                                          "%",
                                  fontSizeTCV: 12,
                                  fontWeightTCV: FontWeight.bold,
                                  textColorTCV: greenOrRed,
                                ),

                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(9),
                            width: widthIs / 3,
                            height: widthIs / 3,
                            padding: const EdgeInsets.all(9),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Color(0xffe8eeed)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/mcq_time.png",
                                  width: widthIs / 8.5,
                                  color: greenOrRed,
                                ),
                                TextCustomVidwath(
                                  textTCV: TR.answer_speed[languageIndex],
                                  fontSizeTCV: 12,
                                  fontWeightTCV: FontWeight.bold,
                                  textColorTCV: greenOrRed,
                                ),
                                TextCustomVidwath(
                                  textTCV: (totalTimeTaken / (correctAnswerCount + wrongAnswerCount + unAnsweredCount)).toStringAsFixed(1) + "${TR.secondPerquestion[languageIndex]}",
                                  fontSizeTCV: 8,
                                  fontWeightTCV: FontWeight.bold,
                                  textColorTCV: greenOrRed,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      DividerCustomVidwath(dividerHeight: 8,),
                    ],
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(18),
                  padding: const EdgeInsets.all(9),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          offset: Offset(3, 3),
                          color: Color.fromRGBO(55, 71, 79, .3))
                    ],
                  ),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              margin: const EdgeInsets.fromLTRB(9, 0, 0, 0),
                              child: TextCustomVidwath(
                                textTCV: TR.accuracy[languageIndex],
                                fontWeightTCV: FontWeight.bold,
                                fontSizeTCV: 15,
                              ))),
                      DividerCustomVidwath(),
                      TextCustomVidwath(
                        textTCV:
                            "${TR.accuracy_in_attempted_question[languageIndex]}${(((correctAnswerCount) / (correctAnswerCount + wrongAnswerCount)) * 100).toStringAsFixed(0).replaceAll("NaN", "0")}%",
                        textColorTCV: ConstantValuesVLA.splashBgColor,
                        fontWeightTCV: FontWeight.w600,
                        fontSizeTCV: 12,
                      ),

                      TextCustomVidwath(
                        textTCV: "$correctAnswerCount Correct Answers out of ${correctAnswerCount + wrongAnswerCount} Attempted",
                        textColorTCV: ConstantValuesVLA.splashBgColor,
                        fontWeightTCV: FontWeight.w700,
                        fontSizeTCV: 14,
                      ),
                      DividerCustomVidwath(),
                      ((correctAnswerCount + wrongAnswerCount) > 0)
                          ? LinearProgressBar(
                        maxSteps: (correctAnswerCount + wrongAnswerCount),
                        progressType:
                        LinearProgressBar.progressTypeLinear,
                        currentStep: correctAnswerCount,
                        progressColor: Colors.green,
                        backgroundColor: Colors.red,
                      )
                          : Container(
                        child: TextCustomVidwath(
                          textTCV: "Consider answering some questions.",
                        ),
                      ),
                      DividerCustomVidwath(),



                    ],
                  )),
            ],
          ),
        )),
      ),
    );
  }

  void getViewDetailsTopicAnalysis() {
    print("****************** user_idJsonKey ********** ${prefs.getString(ConstantValuesVLA.user_idJsonKey)}");
    print("****************** IdSubjectMaster ********** ${widget.choosenMcq}");
    http
        .post(
            Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.eachTopicEachAttemptConstant),
            body: jsonEncode({
              ConstantValuesVLA.user_idJsonKey: prefs.getString(ConstantValuesVLA.user_idJsonKey),
              ConstantValuesVLA.topic_idJsonKey: widget.choosenMcq
              // ConstantValuesVLA.topic_idJsonKey: "4844"
            }))
        .then((topicAnalysis) {
      // print("topicAnalysis.body.toString()");
      // print(topicAnalysis.body.toString());

      var decodedJson = jsonDecode(topicAnalysis.body);
      List<dynamic> dynamicList = decodedJson;
      var jsonDecoded = dynamicList[widget.i];
      correctAnswerCount = int.parse(jsonDecoded["correctAnswer"]);
      wrongAnswerCount = int.parse(jsonDecoded["total_incorrect"]);
      unAnsweredCount = int.parse(jsonDecoded["total_skipped"]);
      totalTimeTaken = int.parse(jsonDecoded["totalTimeTaken"]);

      Future.delayed(Duration(seconds: 1), () {
        appBarTitle = "Result";
        widget.thisSetNewScreenFunc(Container(),
            addToQueue: false, changeAppBar: true);
      });

      setState(() {
        correctAnswerCount;
        wrongAnswerCount;
        unAnsweredCount;
        totalTimeTaken;
      });

      moduleAndTimeMap = {
        TR.correct_answer[languageIndex]: correctAnswerCount.toDouble(),
        TR.incorrect_answer[languageIndex]: wrongAnswerCount.toDouble(),
        TR.un_attempted_answer[languageIndex]: unAnsweredCount.toDouble(),
      };
      showModuleMap = true;
      setState(() {
        moduleAndTimeMap;
        showModuleMap;
      });
      percentageIs = correctAnswerCount /
          (correctAnswerCount + wrongAnswerCount + unAnsweredCount);

      if (percentageIs < .5) {
        titleBasedOnPercentage = TR.below_fifty[languageIndex];
      } else if (percentageIs < .75) {
        titleBasedOnPercentage = TR.below_seventy_five[languageIndex];
      } else if (percentageIs < .9) {
        titleBasedOnPercentage = TR.below_ninty[languageIndex];
      } else {
        titleBasedOnPercentage = TR.above_ninty[languageIndex];
      }

      if (correctAnswerCount > wrongAnswerCount) {
        greenOrRed = Colors.green;
      } else {
        greenOrRed = Colors.redAccent;
      }

      setState(() {
        percentageIs;
        titleBasedOnPercentage;
        greenOrRed;
      });
    });

    intToTimeLeft(totalTimeTaken);
  }

  Future<bool> onBackPressed() {
    listOfWidgetForBack.removeLast();
    widget.thisSetNewScreenFunc(
        listOfWidgetForBack[listOfWidgetForBack.length - 2],
        addToQueue: false);
    return Future.value(false);
  }
}



// class DataItem {
//   final double value;
//   final String label;
//   final Color color;
//
//   DataItem({required this.value, required this.label, required this.color});
// }

/*
class DonutChartWidget extends StatefulWidget {
  //final List<DataItem> dataSet;



  const DonutChartWidget(*/
/*this.dataSet,*//*
 {Key? key}) : super(key: key);

  @override
  State<DonutChartWidget> createState() => _DonutChartWidgetState();
}

class _DonutChartWidgetState extends State<DonutChartWidget> {


  final List dataSet = [
    (value: 0.5, label: "40", color: Colors.green),
    (value: 0.4, label: "30", color: Colors.blue),
    (value: 0.1, label: "10", color: Colors.pink)
  ];


  late Timer timer;
  double fullAngle = 0.0;
  double secondsToComplete = 5.0;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ 60), (timer) {
      setState(() {
        fullAngle += 360.0 / (secondsToComplete * 1000 ~/ 60);
        if (fullAngle >= 360.0) {
          fullAngle = 360.0;
          timer.cancel();
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DonutChartPainter(dataSet, fullAngle),
      child: Container(),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final List dataSet;
  final double fullAngle;

  DonutChartPainter(this.dataSet, this.fullAngle);

  static const labelStyle = TextStyle(color: Colors.black, fontSize: 11.0);
  final midPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;
  static const textBigStyle = TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25.0);

  @override
  void paint(Canvas canvas, Size size) {
    final linePath = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final c = Offset(size.width / 2.0, size.height / 2.0);
    final radius = size.width * 0.9;
    final rect = Rect.fromCenter(center: c, width: radius, height: radius);

    var startAngle = 0.0;
    for (var di in dataSet) {
      final sweepAngle = di.value * fullAngle / 180 * pi;
      drawSectors(di, canvas, rect, startAngle, sweepAngle);
      startAngle += sweepAngle;
    }

    startAngle = 0.0;
    for (var di in dataSet) {
      final sweepAngle = di.value * fullAngle / 180 * pi;
      drawLines(radius, startAngle, c, canvas, linePath);
      startAngle += sweepAngle;
    }

    startAngle = 0.0;
    for (var di in dataSet) {
      final sweepAngle = di.value * fullAngle / 180 * pi;
      drawLabels(canvas, c, radius, startAngle, sweepAngle, di.label);
      startAngle += sweepAngle;
    }

    canvas.drawCircle(c, radius * 0.3, midPaint);
    drawTextCentered(canvas, c, "Test Score 10%", textBigStyle,
        radius * 0.5, (Size sz) {});
  }

  TextPainter measureText(String string, TextStyle textStyle, double maxWidth, TextAlign textAlign) {
    final span = TextSpan(text: string, style: textStyle);
    final tp = TextPainter(
        text: span, textAlign: textAlign, textDirection: ui.TextDirection.ltr);
    tp.layout(minWidth: 0, maxWidth: maxWidth);
    return tp;
  }

  Size drawTextCentered(Canvas canvas, Offset position, String text,
      TextStyle textStyle, double maxWidth, Function(Size size) bgCb) {
    final textPainter = measureText(text, textStyle, maxWidth, TextAlign.center);
    final pos = position + Offset(-textPainter.width / 2.0, -textPainter.height / 2.0);
    bgCb(textPainter.size);
    textPainter.paint(canvas, pos);
    return textPainter.size;
  }

  void drawLines(double radius, double startAngle, Offset c, Canvas canvas,
      Paint linePath) {
    final lineLength = radius / 2;
    final dx = lineLength * cos(startAngle);
    final dy = lineLength * sin(startAngle);
    final p2 = c + Offset(dx, dy);
    canvas.drawLine(c, p2, linePath);
  }

  void drawSectors( di, Canvas canvas, Rect rect, double startAngle,
      double sweepAngle) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = di.color;
    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
  }

  void drawLabels(Canvas canvas, Offset c, double radius, double startAngle,
      double sweepAngle, String label) {
    final r = radius * 0.4;
    final dx = r * cos(startAngle + sweepAngle / 2.0);
    final dy = r * sin(startAngle + sweepAngle / 2.0);
    final position = c + Offset(dx, dy);
    drawTextCentered(canvas, position, label, labelStyle, 100.0, (Size size) {
      final rect = Rect.fromCenter(
          center: position, width: size.width + 5, height: size.height + 5);
      final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(5));
      canvas.drawRRect(rrect, midPaint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}*/
