import 'package:flutter/material.dart';

class SlideTransitionCustomVidwath extends StatefulWidget {
  Widget childIs;
  int durationIs;
  Offset offset;

  SlideTransitionCustomVidwath(this.durationIs, this.offset, this.childIs,
      {Key? key})
      : super(key: key);

  @override
  State<SlideTransitionCustomVidwath> createState() =>
      _SlideTransitionCustomVidwathState();
}

class _SlideTransitionCustomVidwathState
    extends State<SlideTransitionCustomVidwath> with TickerProviderStateMixin {

  late AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.durationIs.abs() * 100));
    animationController.forward();

    Animation<Offset> slideTranisitionAnimation = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    ));
    return SlideTransition(
      position: slideTranisitionAnimation,
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
