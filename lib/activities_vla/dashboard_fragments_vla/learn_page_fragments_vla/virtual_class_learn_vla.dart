import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/learn_page_fragments_vla/virtual_class_player_vla.dart';

import '../../../constants_vla/constant_values_vla.dart';
import '../../../main.dart';
import '../../../models_vla/virtual_class_model_vla.dart';
import '../../../translation_vla/tr.dart';
import '../../../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/image_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/text_custom_vidwath.dart';

class VirtualClassLearnVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  VirtualClassLearnVLA(this.thisSetNewScreenFunc, {Key? key}) : super(key: key);

  @override
  State<VirtualClassLearnVLA> createState() => _VirtualClassLearnVLAState();
}

class _VirtualClassLearnVLAState extends State<VirtualClassLearnVLA> {
  List<Widget> listOfVirtualClassesWidgets = [];

  @override
  void initState() {
    super.initState();
    getVirutalClassesAPI();
  }

  @override
  Widget build(BuildContext context) {
    return (listOfVirtualClassesWidgets.isNotEmpty)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextCustomVidwath(
                  // textTCV: TR.view[1],
                  textTCV: TR.virtual_class[languageIndex],
                  fontWeightTCV: FontWeight.w400,
                  fontSizeTCV: 14,
                ),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: listOfVirtualClassesWidgets,
                ),
              ),
            ],
          )
        : Container();
  }

  Future<void> getVirutalClassesAPI() async {
    print(
        '****** CLASS ID ***********${prefs.getString(ConstantValuesVLA.class_idJsonKey)}');

    print(
        '****** CLASS NAME ***********${prefs.getString(ConstantValuesVLA.classnameJsonKey)}');

    print(
        '****** MEDIUM ID ***********${prefs.getString(ConstantValuesVLA.boardidJsonKey)}');

    print(
        '****** USER ID ***********${prefs.getString(ConstantValuesVLA.user_idJsonKey)}');

    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.virtualClassesConstant);

    http
        .post(url,
            body: jsonEncode({
              ConstantValuesVLA.class_idJsonKey: prefs.getString(ConstantValuesVLA.class_idJsonKey),
              ConstantValuesVLA.classnameJsonKey: prefs.getString(ConstantValuesVLA.classnameJsonKey),
              ConstantValuesVLA.medium_idJsonKey: prefs.getString(ConstantValuesVLA.boardidJsonKey),
              ConstantValuesVLA.user_idJsonKey: prefs.getString(ConstantValuesVLA.user_idJsonKey)
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
            height: 125,
            width: 200,
            margin: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    offset: Offset(3, 3),
                    blurRadius: 5,
                    color: Color.fromRGBO(55, 71, 79, .5)),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageCustomVidwath(
                    imageUrlICV: virtualClassModelVLA.thumbnail,
                    heightICV: 75.8,
                    widthICV: 234,
                    aboveImageICV: virtualClassModelVLA.tittle,
                    boxFit: BoxFit.fill,
                  ),
                  DividerCustomVidwath(
                    dividerHeight: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 5),
                    child: Text(
                      virtualClassModelVLA.tittle,
                      style: TextStyle(
                          color: ConstantValuesVLA.splashBgColor,
                          fontSize: 12,
                          fontFamily: (languageIndex == 2)
                              ? 'Jameel Noori Nastaleeq'
                              : 'Roboto',
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                    width: 234,
                    height: 16,
                    margin: const EdgeInsets.fromLTRB(0, 0, 9, 0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextCustomVidwath(
                        textTCV: virtualClassModelVLA.status_description,
                        fontSizeTCV: 8.5,
                        fontWeightTCV: FontWeight.w400,
                        textColorTCV: Colors.green,
                      ),
                    ),
                  ),
                  DividerCustomVidwath(
                    dividerHeight: 5,
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
