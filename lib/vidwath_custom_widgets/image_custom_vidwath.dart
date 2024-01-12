import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vel_app_online/vidwath_custom_widgets/text_custom_vidwath.dart';

class ImageCustomVidwath extends StatefulWidget {
  String imageUrlICV;
  double heightICV, widthICV;
  BoxFit boxFit;
  String aboveImageICV;

  ImageCustomVidwath(
      {this.imageUrlICV = "",
      this.heightICV = 0,
      this.widthICV = 0,
      this.boxFit = BoxFit.contain,
      this.aboveImageICV = ""});

  @override
  _ImageCustomVidwathState createState() => _ImageCustomVidwathState();
}

class _ImageCustomVidwathState extends State<ImageCustomVidwath> {
  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      image: NetworkImage(widget.imageUrlICV),
      placeholder: const AssetImage("assets/allplaceholder.png"),
      fadeOutDuration: const Duration(milliseconds: 108),
      fadeInDuration: const Duration(milliseconds: 108),
      height: widget.heightICV,
      width: widget.widthICV,
      fit: widget.boxFit,
      imageErrorBuilder: (c, a, u) {
        return Image.asset(
          "assets/allplaceholder.png",
          height: widget.heightICV,
          fit: BoxFit.fitHeight,
        );
      },
    );
  }
}
