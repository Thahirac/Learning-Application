import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DividerCustomVidwath extends StatefulWidget {
  double dividerHeight;

  DividerCustomVidwath({Key? key, this.dividerHeight = 15}) : super(key: key);

  @override
  _DividerCustomVidwathState createState() => _DividerCustomVidwathState();
}

class _DividerCustomVidwathState extends State<DividerCustomVidwath> {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: widget.dividerHeight,
      color: Colors.transparent,
    );
  }
}
