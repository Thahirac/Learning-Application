import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:vel_app_online/activities_vla/dashboard_fragments_vla/more_fragments_vla/check_subscription_view_plans_vla.dart';
import 'package:vel_app_online/main.dart';
import 'package:vel_app_online/models_vla/tutorial_videos_notes_model_study_lab_vla.dart';
import 'package:vel_app_online/platform_dependent_vla/video_player_vla/andr_ios_web_vla/landscape_player_controls.dart';
import 'package:vel_app_online/translation_vla/tr.dart';
import 'package:vel_app_online/vidwath_custom_widgets/text_custom_vidwath.dart';

class CustomVideoPlayerVidwath extends StatefulWidget {
  var thisSetNewScreenFunc;
  String theVideoPath;

  CustomVideoPlayerVidwath(this.thisSetNewScreenFunc, this.theVideoPath,
      {Key? key})
      : super(key: key);

  @override
  _CustomVideoPlayerVidwathState createState() => _CustomVideoPlayerVidwathState();
}

class _CustomVideoPlayerVidwathState extends State<CustomVideoPlayerVidwath> {
  late FlickManager flickManager;
  late Orientation originalOrientation;
  bool showVideoUI = false;

  @override
  void initState() {
    checkForSubscription();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.theVideoPath),
    );
    super.initState();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  void checkForSubscription() {
    String theVideoUrlTopPartIs = widget.theVideoPath;
    theVideoUrlTopPartIs = theVideoUrlTopPartIs.substring(0, theVideoUrlTopPartIs.lastIndexOf("/"));

    if (!isThisUserSubscribed) {
      if (prefs.getStringList("subscriptionCheckPathList") == null) {
        prefs.setStringList("subscriptionCheckPathList", [(theVideoUrlTopPartIs)]);
        showVideo();
      } else {
        List<String> subscriptionCheckPathList = prefs.getStringList("subscriptionCheckPathList")!;
        if (subscriptionCheckPathList.contains(theVideoUrlTopPartIs)) {
          Navigator.pop(context);
          Future.delayed(const Duration(seconds: 1), () {
            // widget.thisSetNewScreenFunc(
            //     CheckSubscriptionViewPlansVLA(widget.thisSetNewScreenFunc));

            widget.thisSetNewScreenFunc(
                Directionality(
                    textDirection: (languageIndex == 2)? TextDirection.rtl : TextDirection.ltr,
                    child:  CheckSubscriptionViewPlansVLA(widget.thisSetNewScreenFunc)));

          });
        } else {
          subscriptionCheckPathList.add(theVideoUrlTopPartIs);
          prefs.setStringList("subscriptionCheckPathList", subscriptionCheckPathList);
          showVideo();
        }
      }
    } else if (isThisUserSubscribed) {
      showVideo();
    }
  }

  Future<bool> onBackPressed() {
    if (originalOrientation == Orientation.portrait) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]).then((value) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.portraitUp,
        ]).then((value) {
          Navigator.pop(context);
        });
      });
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
      ]).then((value) {
        Navigator.pop(context);
      });
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    originalOrientation = MediaQuery.of(context).orientation;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        body: SafeArea(
          child: showVideoUI
              ? FlickVideoPlayer(
                  flickManager: flickManager,
                  preferredDeviceOrientation: const [
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight,
                  ],
                  preferredDeviceOrientationFullscreen: const [
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight,
                  ],
                  systemUIOverlay: [],
                  flickVideoWithControls: const FlickVideoWithControls(
                    controls: LandscapePlayerControls(),
                    videoFit: BoxFit.fitHeight,
                  ),
                )
              : Container(
                  child: Center(
                    child: TextCustomVidwath(
                      textTCV: TR.please_wait[languageIndex],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  void showVideo() {
    showVideoUI = true;
    setState(() {
      showVideoUI;
    });
  }
}
