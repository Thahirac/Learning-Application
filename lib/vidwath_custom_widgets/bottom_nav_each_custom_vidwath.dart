import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vel_app_online/activities_vla/dashboard_vla.dart';
import 'package:vel_app_online/constants_vla/constant_values_vla.dart';
import 'package:vel_app_online/main.dart';
import 'package:vel_app_online/vidwath_custom_widgets/text_custom_vidwath.dart';

class BottomNavEachCustomVidwath extends StatefulWidget {
  String imageAssetNameBNECV;
  var onPressedBNECV;
  int myIndexBNECV = 0;
  int currentIndexBNECV = 0;
  String labelBNECV = "";

  BottomNavEachCustomVidwath({
    Key? key,
    this.imageAssetNameBNECV = "",
    this.onPressedBNECV,
    this.myIndexBNECV = 0,
    this.currentIndexBNECV = 0,
    this.labelBNECV = "",
  }) : super(key: key);

  @override
  _BottomNavEachCustomVidwathState createState() =>
      _BottomNavEachCustomVidwathState();
}

class _BottomNavEachCustomVidwathState
    extends State<BottomNavEachCustomVidwath> {
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onPressedBNECV,
      child: SizedBox(
        width: screenWidth / 5.1,
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: appBarHeight - 30,
              height: widget.myIndexBNECV == currentIndexOfBottomPressed ? 0
                  : appBarHeight,
              child: Image.asset(
                widget.imageAssetNameBNECV,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: screenWidth / 5.1,
              height: widget.myIndexBNECV == currentIndexOfBottomPressed
                  ? appBarHeight
                  : 0,
              child: Center(
                child: Text(
                  widget.labelBNECV.toString(),
                  style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,fontSize: 12),
                  textAlign: TextAlign.center,
                  /*textAlignTCV: TextAlign.center,
                  fontWeightTCV: FontWeight.bold,
                  textColorTCV: Colors.blue,*/
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
