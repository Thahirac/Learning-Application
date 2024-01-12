import 'package:flutter/material.dart';

class VideoPlayerTutorialStudyLabVLA extends StatefulWidget {
  var thisSetNewScreenFunc;
  String path, filename, duration;

  VideoPlayerTutorialStudyLabVLA(
      this.thisSetNewScreenFunc, this.path, this.filename, this.duration,
      {Key? key})
      : super(key: key);

  @override
  State<VideoPlayerTutorialStudyLabVLA> createState() =>
      _VideoPlayerTutorialStudyLabVLAState();
}

class _VideoPlayerTutorialStudyLabVLAState
    extends State<VideoPlayerTutorialStudyLabVLA> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/*
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:vidwath_e_learning_app/constants_vla/constant_values_vla.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:vidwath_e_learning_app/vidwath_custom_widgets/text_custom_vidwath.dart';

class VideoPlayerTutorialStudyLab extends StatefulWidget {
  var thisSetNewScreenFunc;
  String path, filename, duration;

  VideoPlayerTutorialStudyLab(
      this.thisSetNewScreenFunc, this.path, this.filename, this.duration,
      {Key? key})
      : super(key: key);

  @override
  State<VideoPlayerTutorialStudyLab> createState() =>
      _VideoPlayerTutorialStudyLabState();
}

class _VideoPlayerTutorialStudyLabState
    extends State<VideoPlayerTutorialStudyLab> {
  late VideoPlayerController videoController;
  var playOrPause = Icons.pause;
  bool videoIsPlaying = true;
  double volumeIs = 1;
  double speedIs = 1;
  int totalDuration = 0;
  int progressDuration = 0;
  bool showControls = true;

  @override
  void initState() {
    super.initState();
    setVideoController();
    totalDuration =
        (int.parse(widget.duration.replaceAll(" MINS", "").trim()) * 60);
    setState(() {
      totalDuration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.transparent,
      floatingActionButton: showControls
          ? FabCircularMenu(
              ringWidth: 54,
              ringDiameter: 360,
              fabOpenIcon: Icon(
                Icons.menu,
                color: ConstantValuesVLA.whiteColor,
              ),
              fabCloseIcon: Icon(
                Icons.close,
                color: ConstantValuesVLA.whiteColor,
              ),
              fabColor: ConstantValuesVLA.splashBgColor,
              children: <Widget>[
                  // REWIND
                  IconButton(
                    icon: const Icon(Icons.undo),
                    onPressed: () {
                      rewindVideo();
                    },
                    color: ConstantValuesVLA.whiteColor,
                  ),
                  // SPEED
                  IconButton(
                    icon: const Icon(Icons.shutter_speed),
                    onPressed: () {
                      speedIs = speedIs - 0.25;
                      videoController.setPlaybackSpeed(speedIs);
                      if (speedIs > 5) speedIs = 5;
                      if (speedIs < 0.25) speedIs = 0;
                    },
                    color: ConstantValuesVLA.whiteColor,
                  ),
                  // VOLUME
                  IconButton(
                    icon: const Icon(Icons.volume_down),
                    onPressed: () {
                      volumeIs = volumeIs - 0.054;
                      videoController.setVolume(volumeIs);
                      if (volumeIs > 1) volumeIs = 1;
                      if (volumeIs < 0) volumeIs = 0;
                    },
                    color: ConstantValuesVLA.whiteColor,
                  ),
                  // PLAY OR PAUSE
                  IconButton(
                    icon: Icon(playOrPause),
                    onPressed: () {
                      pauseOrPlayVideo();
                    },
                    color: ConstantValuesVLA.whiteColor,
                  ),
                  // VOLUME UP
                  IconButton(
                    icon: const Icon(Icons.volume_up),
                    onPressed: () {
                      volumeIs = volumeIs + 0.054;
                      videoController.setVolume(volumeIs);
                      if (volumeIs > 1) volumeIs = 1;
                      if (volumeIs < 0) volumeIs = 0;
                    },
                    color: ConstantValuesVLA.whiteColor,
                  ),
                  // SPEED UP
                  IconButton(
                    icon: const Icon(Icons.speed),
                    onPressed: () {
                      speedIs = speedIs + 0.25;
                      videoController.setVolume(speedIs);
                      if (speedIs > 5) speedIs = 5;
                      if (speedIs < 0.25) speedIs = 0;
                    },
                    color: ConstantValuesVLA.whiteColor,
                  ),
                  // FORWARD
                  IconButton(
                    icon: const Icon(Icons.redo),
                    onPressed: () {
                      forwardVideo();
                    },
                    color: ConstantValuesVLA.whiteColor,
                  ),
                ])
          : Container(),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              showControls = (!showControls);
              setState(() {
                showControls;
              });
            },
            child: Container(
              color: ConstantValuesVLA.blackTextColor,
              child: Center(
                child: videoController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: videoController.value.aspectRatio,
                        child: VideoPlayer(videoController),
                      )
                    : Container(),
              ),
            ),
          ),
          showControls
              ? Align(
                  alignment: Alignment.centerRight,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(3),
                        padding: EdgeInsets.all(3),
                        width: 27,
                        height: MediaQuery.of(context).size.height * .54,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: VideoProgressIndicator(
                            videoController,
                            allowScrubbing: true,
                            colors: VideoProgressColors(
                              playedColor: ConstantValuesVLA.splashBgColor,
                              bufferedColor: Color.fromRGBO(153, 153, 153, 1.0),
                              backgroundColor: ConstantValuesVLA.greyTextColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(3),
                        padding: EdgeInsets.all(3),
                        width: 32,
                        height: MediaQuery.of(context).size.height * .54,
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Center(
                            child: TextCustomVidwath(
                              textTCV: _printDuration(
                                  Duration(seconds: progressDuration)),
                              fontWeightTCV: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          showControls
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 27,
                    width: 405,
                    color: Color.fromRGBO(255, 255, 255, 0.5),
                    margin: EdgeInsets.all(3),
                    padding: EdgeInsets.all(3),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.volume_up),
                              Container(
                                  width: 63,
                                  child: LinearProgressIndicator(
                                    value: volumeIs,
                                  )),
                            ],
                          ),
                          TextCustomVidwath(
                            textTCV: _printDuration(
                                Duration(seconds: progressDuration)),
                            fontWeightTCV: FontWeight.bold,
                          ),
                          TextCustomVidwath(
                            textTCV: (speedIs).toString() + " X",
                            fontWeightTCV: FontWeight.bold,
                          ),
                          Container(
                            height: 2,
                            width: 54,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  void rewindVideo() {
    videoController.position.then((value) {
      print(value!.inSeconds.toString());
      videoController.seekTo(Duration(seconds: ((value.inSeconds) - 10)));
    });
  }

  void setVolume() {}

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void pauseOrPlayVideo() {
    if (videoIsPlaying) {
      videoController.pause();
      videoIsPlaying = false;
      playOrPause = Icons.play_arrow;
      setState(() {
        playOrPause;
      });
    } else {
      videoController.play();
      videoIsPlaying = true;
      playOrPause = Icons.pause;
      setState(() {
        playOrPause;
      });
    }
  }

  void enableVideoSeeking() {}

  void forwardVideo() {
    videoController.position.then((value) {
      print(value!.inSeconds.toString());
      videoController.seekTo(Duration(seconds: ((value.inSeconds) + 10)));
    });
  }

  void hideContols() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      showControls = false;
      setState(() {
        showControls;
      });
    });
  }

  void setVideoController() {
    videoController = VideoPlayerController.network(
        "https://cdn.vidwathinfra.com/Android_Online/application/" +
            widget.path +
            "/" +
            widget.filename +
            ".m4v",
        videoPlayerOptions: VideoPlayerOptions(
            allowBackgroundPlayback: true, mixWithOthers: true))
      ..initialize().then((_) {
        videoController.addListener(() {
          videoController.position.then((value) {
            progressDuration = value!.inSeconds;
            setState(() {
              progressDuration;
            });
          });
        });
        setState(() {
          videoController;
          videoController.play();
        });
        hideContols();
      });
  }
}
*/
