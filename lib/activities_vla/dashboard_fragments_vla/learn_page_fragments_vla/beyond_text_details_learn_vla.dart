import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
//import 'package:image_downloader/image_downloader.dart';
import '../../../constants_vla/constant_values_vla.dart';
import '../../../main.dart';
import '../../../translation_vla/tr.dart';
import '../../../vidwath_custom_widgets/image_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import '../learn_dash_vla.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class BeyondTextDetailsLearnVLA extends StatefulWidget {
  var thisSetNewScreenFunc;
  String name, path, filename;

  BeyondTextDetailsLearnVLA(
      this.thisSetNewScreenFunc, this.name, this.path, this.filename, {Key? key}) : super(key: key);

  @override
  State<BeyondTextDetailsLearnVLA> createState() =>
      _BeyondTextDetailsLearnVLAState();
}

class _BeyondTextDetailsLearnVLAState extends State<BeyondTextDetailsLearnVLA> {




  Future<bool> checkGalleryPermission() async {
    PermissionStatus permission = await Permission.storage.status;
    if (permission != PermissionStatus.granted) {
      Map<Permission, PermissionStatus> permissionStatus = await [Permission.storage].request();
      return permissionStatus[Permission.storage] == PermissionStatus.granted;
    } else {
      return true;
    }
  }



  void saveImage() async {
    bool hasPermission = await checkGalleryPermission();
    if (hasPermission) {
      String path ="https://vidwathapp.b-cdn.net/Android_Online/application/" + widget.path + "/" + widget.filename;
      final result = await GallerySaver.saveImage(path);

      if(result == true){
        var snackBar = SnackBar(
          content: Text("Downloaded Successfully!" + TR.doShareItWithYourFriendsAndFamily[languageIndex]),
          backgroundColor: Colors.indigoAccent,
          duration: const Duration(seconds: 9),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      else {
        var snackBar = SnackBar(
          content: Text("Failed to save image."),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 9),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }

    } else {
      // Handle permission not granted error
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Permission Required'),
          content: Text('This app requires storage permission to save images, please allow your storage permission'),
          actions: <Widget>[
            TextButton(
              child: Text('Open Settings'),
              onPressed: () {
                openAppSettings();
              },
            ),
          ],
        ),
      );
    }
  }







/*  Future<void> _getrequestPermissions() async {

    var status = await Permission.storage.status;

     if (status == PermissionStatus.granted) {
      setState(() {
        _ispermision=true;
      });
      print('Permission granted');
      _saveNetworkImage();
    }
    if (status != PermissionStatus.granted) {
      await Permission.storage.request();
      setState(() {
        _ispermision=false;
      });
      print('Permission granted checking');
    }
    if (status == PermissionStatus.denied) {
      setState(() {
        _ispermision=false;
      });
      print('Permission denied. Show a dialog and again ask for the permission');
      await openAppSettings();
    }
     if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');

      await openAppSettings();
    }

  }*/


  void _saveNetworkImage() async {
    String path ="https://vidwathapp.b-cdn.net/Android_Online/application/" + widget.path + "/" + widget.filename;
    GallerySaver.saveImage(path).then((fileName) {
            var snackBar = SnackBar(
              content: Text("Downloaded Successfully!" + TR.doShareItWithYourFriendsAndFamily[languageIndex]),
              backgroundColor: Colors.indigoAccent,
              duration: const Duration(seconds: 9),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: ConstantValuesVLA.splashBgColor,
          onPressed: () {

            saveImage();


           // _getrequestPermissions();


            // ImageDownloader.downloadImage("https://cdn.vidwathinfra.com/Android_Online/application/" + widget.path + "/" + widget.filename)
            //     .then((imageId) {
            //   ImageDownloader.findName(imageId!).then((fileName) {
            //     ImageDownloader.findPath(imageId).then((filePath) {
            //       var snackBar = SnackBar(
            //         content: Text(fileName! +
            //             TR.isSavedTo[languageIndex] +
            //             filePath! +
            //             TR.doShareItWithYourFriendsAndFamily[languageIndex]),
            //         backgroundColor: Colors.indigoAccent,
            //         duration: const Duration(seconds: 9),
            //       );
            //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
            //     });
            //   });
            // });
          },
          child: Icon(
            Icons.download,
          ),
        ),
        body: SingleChildScrollView(
          physics:  BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextCustomVidwath(
                textTCV: widget.name,
                fontSizeTCV: 23,
                textColorTCV: ConstantValuesVLA.splashBgColor,
                fontWeightTCV: FontWeight.bold,
              ),
              ImageCustomVidwath(
                imageUrlICV:
                    "https://vidwathapp.b-cdn.net/Android_Online/application/" +
                        widget.path +
                        "/" +
                        widget.filename,
                heightICV: MediaQuery.of(context).size.height * .72,
                widthICV: MediaQuery.of(context).size.width,
                aboveImageICV: widget.name,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onBackPressed() {
    //widget.thisSetNewScreenFunc(LearnDashVLA(widget.thisSetNewScreenFunc));
    scrollLearnToBottom = true;
    listOfWidgetForBack.removeLast();
    widget.thisSetNewScreenFunc(listOfWidgetForBack.last, addToQueue: false);
    return Future.value(false);
  }
}
