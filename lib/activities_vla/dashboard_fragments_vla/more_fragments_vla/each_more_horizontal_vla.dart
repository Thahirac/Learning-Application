import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EachMoreHorizontalVLA extends StatefulWidget {
  String imageAssetNameBNECV;
  var onPressedBNECV;
  String labelBNECV = "";

  EachMoreHorizontalVLA({
    Key? key,
    this.imageAssetNameBNECV = "",
    this.onPressedBNECV,
    this.labelBNECV = "",
  }) : super(key: key);

  @override
  _EachMoreHorizontalVLAState createState() => _EachMoreHorizontalVLAState();
}

class _EachMoreHorizontalVLAState extends State<EachMoreHorizontalVLA> {
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onPressedBNECV,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 3.5, color: Colors.grey)]),
        margin: const EdgeInsets.fromLTRB(3, 9, 3, 9),
        padding: const EdgeInsets.all(10),
        width: screenWidth / 2.25,
        height: 72,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.imageAssetNameBNECV,
              height: 50,
              width: 50,
            ),
            Expanded(
              child: Text(
                widget.labelBNECV,
                textAlign: TextAlign.center,
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
