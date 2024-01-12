import 'package:flutter/material.dart';

class FaqAnimationCustomVidwath extends StatefulWidget {
  Widget childIs;
  int durationIs;

  FaqAnimationCustomVidwath(this.durationIs, this.childIs, {Key? key})
      : super(key: key);

  @override
  State<FaqAnimationCustomVidwath> createState() =>
      _FaqAnimationCustomVidwathState();
}

class _FaqAnimationCustomVidwathState extends State<FaqAnimationCustomVidwath>
    with TickerProviderStateMixin {

  late AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    AnimationController animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.durationIs));
    animationController.forward();
    return FadeTransition(
      opacity: animationController,
      child: widget.childIs,
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose

    animationController.dispose();
    super.dispose();
  }

}
