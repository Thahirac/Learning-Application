//import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/more_dash_vla.dart';
import 'package:vel_app_online/constants_vla/constant_values_vla.dart';
import 'package:webviewx/webviewx.dart';

import '../../../main.dart';

class CustomWebviewVLA extends StatefulWidget {
  var thisSetNewScreenFunc;
  String urlIs;

  CustomWebviewVLA(this.thisSetNewScreenFunc, this.urlIs, {Key? key})
      : super(key: key);

  @override
  State<CustomWebviewVLA> createState() => _CustomWebviewVLAState();
}

class _CustomWebviewVLAState extends State<CustomWebviewVLA> {
  late WebViewXController webViewXController;

  bool   isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(backgroundColor: Colors.transparent,

        body: Stack(
          children: [
            WebViewX(
              onWebViewCreated: (tempController) {
                webViewXController = tempController;
              },
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .90,
              initialContent: widget.urlIs,
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            isLoading ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.white,),
                      height: 40,
                      width: 40,

                      child: const CupertinoActivityIndicator()),
                  const SizedBox(
                    height: 10.0,
                  ),

                  Directionality(
                      textDirection: (languageIndex == 2)? TextDirection.ltr : TextDirection.ltr,
                      child: const Text('Loading...')),
                  // CheersClubText(
                  //   text: AppLocalizations.of(context).translate(''),fontColor: Colors.black,
                  //   fontSize: 15,
                  // ),

                ],
              ),
            )
                : Stack(),
          ],
        ),
      ),
    );
  }

  Future<bool> onBackPressed() {
    widget.thisSetNewScreenFunc(Directionality(
      textDirection: (languageIndex == 2)? TextDirection.ltr : TextDirection.ltr,
        child: MoreDashVLA(widget.thisSetNewScreenFunc)),
        addToQueue: false);
    return Future.value(false);
  }
}
