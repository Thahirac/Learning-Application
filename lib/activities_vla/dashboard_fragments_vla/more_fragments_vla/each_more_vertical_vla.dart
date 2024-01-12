import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EachMoreVerticalVLA extends StatefulWidget {
  String imageAssetNameBNECV;
  var onPressedBNECV;
  String labelBNECV = "";

  EachMoreVerticalVLA({
    Key? key,
    this.imageAssetNameBNECV = "",
    this.onPressedBNECV,
    this.labelBNECV = "",
  }) : super(key: key);

  @override
  _EachMoreVerticalVLAState createState() => _EachMoreVerticalVLAState();
}

class _EachMoreVerticalVLAState extends State<EachMoreVerticalVLA> {
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onPressedBNECV,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)]),
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(3),
        width: screenWidth / 3.42,
        height: screenWidth / 3.42,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.imageAssetNameBNECV,
              height: 50,
              width: 50,
            ),
            const Divider(
              color: Colors.transparent,
              height: 8,
            ),
            Center(
              child: Text(
                widget.labelBNECV,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
