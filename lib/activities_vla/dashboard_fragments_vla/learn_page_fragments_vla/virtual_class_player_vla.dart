import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:http/http.dart' as http;

import '../../../constants_vla/constant_values_vla.dart';
import '../../../main.dart';
import '../../../models_vla/virtual_class_model_vla.dart';
import '../../../translation_vla/tr.dart';
import '../../../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/text_custom_vidwath.dart';

class VirtualClassPlayerVLA extends StatefulWidget {
  var thisSetNewScreenFunc;
  VirtualClassModelVLA virtualClassModelVLA;

  VirtualClassPlayerVLA(this.thisSetNewScreenFunc, this.virtualClassModelVLA,
      {Key? key})
      : super(key: key);

  @override
  State<VirtualClassPlayerVLA> createState() => _VirtualClassPlayerVLAState();
}

class _VirtualClassPlayerVLAState extends State<VirtualClassPlayerVLA> {
  late YoutubePlayerController _controller;
  List<Widget> listOfVirtualClassesWidgets = [];
  double heightIs = 0, widthIs = 0;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.virtualClassModelVLA.link,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
    getVirutalClassesAPI();
  }

  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.virtualClassModelVLA.tittle.toString()),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 225,
              child: YoutubePlayerIFrame(
                controller: _controller,
                aspectRatio: 16 / 9,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(9),
                child: Text(
                  widget.virtualClassModelVLA.tittle,
                  style: TextStyle(
                      color: ConstantValuesVLA.splashBgColor, fontSize: 18),
                  maxLines: 3,
                )),
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(3, 3, 18, 3),
                  child: TextCustomVidwath(
                    textTCV: widget.virtualClassModelVLA.status_description,
                    textColorTCV: Colors.orange,
                  ),
                )),
            const Divider(),
            Align(
              alignment: Alignment.center,
              child: TextCustomVidwath(
                textTCV: TR.related_videos[languageIndex],
                fontSizeTCV: 21,
                textDecoration: TextDecoration.underline,
              ),
            ),
            SizedBox(
              width: widthIs,
              height: heightIs - 486,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: listOfVirtualClassesWidgets,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getVirutalClassesAPI() async {
    var url = Uri.parse(ConstantValuesVLA.baseURLConstant +
        ConstantValuesVLA.virtualClassesConstant);

    http
        .post(url,
            body: jsonEncode({
              /*"class_id": "110",
              "classname": "10",
              "medium_id": "2",
              "user_id": "90"*/

              ConstantValuesVLA.class_idJsonKey:
                  prefs.getString(ConstantValuesVLA.class_idJsonKey),
              ConstantValuesVLA.classnameJsonKey:
                  prefs.getString(ConstantValuesVLA.classnameJsonKey),
              ConstantValuesVLA.medium_idJsonKey:
                  prefs.getString(ConstantValuesVLA.boardidJsonKey),
              ConstantValuesVLA.user_idJsonKey:
                  prefs.getString(ConstantValuesVLA.user_idJsonKey)
            }))
        .then((value) {
      List<dynamic> virtualClassesListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < virtualClassesListTemp.length; i++) {
        VirtualClassModelVLA virtualClassModelVLA =
            VirtualClassModelVLA.fromJson(virtualClassesListTemp[i]);
        listOfVirtualClassesWidgets.add(GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return VirtualClassPlayerVLA(
                    widget.thisSetNewScreenFunc, virtualClassModelVLA);
              }),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    offset: Offset(3, 3),
                    blurRadius: 5,
                    color: Color.fromRGBO(55, 71, 79, .5)),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(11.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.network(
                    virtualClassModelVLA.thumbnail,
                    width: widthIs,
                    fit: BoxFit.fitWidth,
                  ),
                  DividerCustomVidwath(
                    dividerHeight: 6,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 27, 0),
                    child: TextCustomVidwath(
                      textTCV: virtualClassModelVLA.tittle,
                      fontSizeTCV: 14,
                      fontWeightTCV: FontWeight.w500,
                      textColorTCV: ConstantValuesVLA.themeColor,
                    ),
                  ),
                  DividerCustomVidwath(
                    dividerHeight: 6,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 27, 0),
                    child: TextCustomVidwath(
                      textTCV: virtualClassModelVLA.status_description +
                          virtualClassModelVLA.date,
                      fontSizeTCV: 9,
                      fontWeightTCV: FontWeight.normal,
                      textColorTCV: Colors.green,
                    ),
                  ),
                  DividerCustomVidwath(
                    dividerHeight: 6,
                  ),
                ],
              ),
            ),
          ),
        ));
      }

      setState(() {
        listOfVirtualClassesWidgets;
      });
    });
  }
}
