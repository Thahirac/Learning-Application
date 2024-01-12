import 'dart:convert';

import 'package:deep_pick/deep_pick.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../../constants_vla/constant_values_vla.dart';
import '../../../main.dart';
import '../../../translation_vla/tr.dart';
import '../../../vidwath_custom_widgets/divider_custom_vidwath.dart';


class AboutUsVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  AboutUsVLA(this.thisSetNewScreenFunc, {Key? key}) : super(key: key);

  @override
  State<AboutUsVLA> createState() => _AboutUsVLAState();
}

class _AboutUsVLAState extends State<AboutUsVLA> {
  @override
  void initState() {
    super.initState();
    getTutorialVideoAPI();
    Future.delayed(const Duration(seconds: 1), () {
      appBarTitle = TR.about[languageIndex];
      widget.thisSetNewScreenFunc(Container(),
          addToQueue: false, changeAppBar: true);
    });
  }

  String aboutUsHTML = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onBackPressed,
        child: Column(
          children: [
            DividerCustomVidwath(),
            GestureDetector(
              onTap: () {
                launch("https://www.vidwath.com/");
              },
              child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  child: HtmlWidget(aboutUsHTML)),
            ),
            DividerCustomVidwath(),
            DividerCustomVidwath(),
            Text(
              TR.follow_us_on[languageIndex],
              style:
                  TextStyle(fontSize: 18, decoration: TextDecoration.underline),
            ),
            DividerCustomVidwath(
              dividerHeight: 5,
            ),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.all(9),
                  child: GestureDetector(
                      onTap: () {
                        launch("https://m.facebook.com/VidwathApp");
                      },
                      child: Image.asset(
                        "assets/fb.png",
                        height: 36,
                        width: 36,
                      )),
                ),
                Container(
                  margin: const EdgeInsets.all(9),
                  child: GestureDetector(
                      onTap: () {
                        launch("https://www.instagram.com/VidwathApp/");
                      },
                      child: Image.asset(
                        "assets/insta.png",
                        height: 36,
                        width: 36,
                      )),
                ),
                Container(
                  margin: const EdgeInsets.all(9),
                  child: GestureDetector(
                      onTap: () {
                        launch(
                            "https://www.linkedin.com/company/vidwathsolutions/");
                      },
                      child: Image.asset(
                        "assets/linked.png",
                        height: 36,
                        width: 36,
                      )),
                ),
                Container(
                  margin: const EdgeInsets.all(9),
                  child: GestureDetector(
                      onTap: () {
                        launch("https://youtube.com/c/Vidwath");
                      },
                      child: Image.asset(
                        "assets/youtube.png",
                        height: 36,
                        width: 36,
                      )),
                ),
              ],
            )
          ],
        ));
  }

  Future<bool> onBackPressed() {
    //widget.thisSetNewScreenFunc(MoreDashVLA(widget.thisSetNewScreenFunc));
    listOfWidgetForBack.removeLast();
    widget.thisSetNewScreenFunc(listOfWidgetForBack.last, addToQueue: false);
    return Future.value(false);
  }

  Future<void> getTutorialVideoAPI() async {
    var url = Uri.parse(
        ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.infoConstant);
    http.post(url, body: jsonEncode({
      // "user_id": "90"
      ConstantValuesVLA.user_idJsonKey:
      prefs.getString(ConstantValuesVLA.user_idJsonKey)
    })).then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      aboutUsHTML = (tutorialVideoListTemp[0]
          .toString()
          .replaceAll("{info:", "")
          .replaceAll(", Staus: Success}", ""));

      aboutUsHTML = "<h3>" + aboutUsHTML + "</h3>";
      setState(() {
        aboutUsHTML;
      });
    });
  }
}
