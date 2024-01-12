import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../constants_vla/constant_values_vla.dart';
import '../../../main.dart';
import '../../../models_vla/blogs_model_vla.dart';
import '../../../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/text_custom_vidwath.dart';


class BlogsVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  BlogsVLA(this.thisSetNewScreenFunc, {Key? key}) : super(key: key);

  @override
  State<BlogsVLA> createState() => _BlogsVLAState();
}

class _BlogsVLAState extends State<BlogsVLA> {
  List<BlogsModelVLA> assessKitsList = [];

  @override
  void initState() {
    super.initState();
    getTutorialVideoAPI();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onBackPressed,
        child: Container(
          color: Color.fromRGBO(225, 225, 225, 1.0),
          child: ListView.builder(
              itemCount: assessKitsList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        color: ConstantValuesVLA.whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    margin: const EdgeInsets.all(9),
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                assessKitsList[index].tittle,
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            TextCustomVidwath(
                              textTCV: assessKitsList[index].date,
                              textColorTCV: Colors.red,
                              fontSizeTCV: 14,
                            ),
                          ],
                        ),
                        DividerCustomVidwath(
                          dividerHeight: 9,
                        ),
                        Text(
                          assessKitsList[index].discription,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        DividerCustomVidwath(
                          dividerHeight: 9,
                        ),
                        Image.network(assessKitsList[index].image),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }

  Future<void> getTutorialVideoAPI() async {
    var url = Uri.parse(
        ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.blogConstant);
    http.post(url, body: jsonEncode({
      // "user_id": "90"
      ConstantValuesVLA.user_idJsonKey:
      prefs.getString(ConstantValuesVLA.user_idJsonKey)
    })).then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        assessKitsList.add(BlogsModelVLA.fromJson(tutorialVideoListTemp[i]));
      }
      setState(() {
        assessKitsList;
      });
    });
  }

  Future<bool> onBackPressed() {
    //widget.thisSetNewScreenFunc(MoreDashVLA(widget.thisSetNewScreenFunc));
    listOfWidgetForBack.removeLast();
    widget.thisSetNewScreenFunc(listOfWidgetForBack.last, addToQueue: false);
    return Future.value(false);
  }
}
