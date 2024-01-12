import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../../translation_vla/tr.dart';
import '../../../../vidwath_custom_widgets/button_custom_vidwath.dart';
import '../../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import '../../more_fragments_vla/check_subscription_view_plans_vla.dart';



///advance_pdf_viewer2

class PDFViewerVLA extends StatefulWidget {
  var thisSetNewScreenFunc;
  String urlIs, titleIs;

  PDFViewerVLA(this.thisSetNewScreenFunc, this.urlIs, this.titleIs, {Key? key}) : super(key: key);

  @override
  State<PDFViewerVLA> createState() => _PDFViewerVLAState();
}

class _PDFViewerVLAState extends State<PDFViewerVLA> {
  late PDFDocument document;
  double screenHeight = 0, screenWidth = 0;
  bool showPDF = false;

  @override
  void initState() {
   checkForSubscription();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: TextCustomVidwath(
            textTCV: widget.titleIs,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
              size: 36,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              showPDF
                  ? PDFViewer(
                      lazyLoad: false,
                      document: document,
                      scrollDirection: Axis.vertical,
                      indicatorBackground: Colors.grey,
                      // numberPickerConfirmWidget: ButtonCustomVidwath(
                      //   textBCV: TR.okay[languageIndex],
                      //   iconBCV: Icons.swipe_right,
                      // ),
                      numberPickerConfirmWidget: ButtonCustomVidwath(
                       textBCV: TR.okay[languageIndex],
                      ),
                      showPicker: false,
                      indicatorPosition: IndicatorPosition.bottomRight,
                    )
                  : Center(
                      child: TextCustomVidwath(
                        textTCV: "Loading. . .",
                      ),
                    ),
            ],
          ),
        ));
  }

  void checkForSubscription() {
    String thePdfUrlTopPartIs = widget.urlIs;
    thePdfUrlTopPartIs =
        thePdfUrlTopPartIs.substring(0, thePdfUrlTopPartIs.lastIndexOf("/"));
    if (!isThisUserSubscribed) {
      if (prefs.getStringList("subscriptionCheckPathList") == null) {
        prefs.setStringList("subscriptionCheckPathList", [(thePdfUrlTopPartIs)]);
        loadPDF();
      } else {
        List<String> subscriptionCheckPathList =
            prefs.getStringList("subscriptionCheckPathList")!;
        if (subscriptionCheckPathList.contains(thePdfUrlTopPartIs)) {
          Future.delayed(const Duration(seconds: 1), () {

            // widget.thisSetNewScreenFunc(
            //     CheckSubscriptionViewPlansVLA(widget.thisSetNewScreenFunc));

            widget.thisSetNewScreenFunc(
                Directionality(
                    textDirection: (languageIndex == 2)? TextDirection.rtl : TextDirection.ltr,
                    child:  CheckSubscriptionViewPlansVLA(widget.thisSetNewScreenFunc)));

            Navigator.pop(context);
          });
        } else {
          subscriptionCheckPathList.add(thePdfUrlTopPartIs);
          prefs.setStringList(
              "subscriptionCheckPathList", subscriptionCheckPathList);
          loadPDF();
        }
      }
    } else if (isThisUserSubscribed) {
      loadPDF();
    }
  }

  void loadPDF() {
    PDFDocument.fromURL(
      widget.urlIs,
    ).then((value) {
      // print("widget.urlIs");
      // print(widget.urlIs);
      document = value;
      showPDF = true;
      setState(() {
        showPDF;
      });
    });
  }
}




///flutter_cached_pdfviewer
/*class PDFViewerVLA extends StatefulWidget {
   PDFViewerVLA(this.thisSetNewScreenFunc,this.urlIs,this.titleIs,{Key? key}) : super(key: key);

  var thisSetNewScreenFunc;
  String urlIs, titleIs;

  @override
  State<PDFViewerVLA> createState() => _PDFViewerVLAState();
}

class _PDFViewerVLAState extends State<PDFViewerVLA> {


  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  late PDFViewController _pdfViewController;

  bool loaded = false;
  bool? permissionGranted;



  bool showPDF = false;

  Future<void> securescreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }


  Future<void> checkInternetConnection() async {
    bool result = await SimpleConnectionChecker.isConnectedToInternet();
    if (result == true) {
    } else {
      Fluttertoast.showToast(
          msg: "No Internet connection",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 5,
          fontSize: 16.0);
    }
  }

  void checkForSubscription() {
    String thePdfUrlTopPartIs = widget.urlIs;
    thePdfUrlTopPartIs =
        thePdfUrlTopPartIs.substring(0, thePdfUrlTopPartIs.lastIndexOf("/"));
    if (!isThisUserSubscribed) {
      if (prefs.getStringList("subscriptionCheckPathList") == null) {
        prefs
            .setStringList("subscriptionCheckPathList", [(thePdfUrlTopPartIs)]);
        loadPDF();
      } else {
        List<String> subscriptionCheckPathList =
        prefs.getStringList("subscriptionCheckPathList")!;
        if (subscriptionCheckPathList.contains(thePdfUrlTopPartIs)) {
          Future.delayed(const Duration(seconds: 1), () {
            widget.thisSetNewScreenFunc(
                CheckSubscriptionViewPlansVLA(widget.thisSetNewScreenFunc));
            Navigator.pop(context);
          });
        } else {
          subscriptionCheckPathList.add(thePdfUrlTopPartIs);
          prefs.setStringList(
              "subscriptionCheckPathList", subscriptionCheckPathList);
          loadPDF();
        }
      }
    } else if (isThisUserSubscribed) {
      loadPDF();
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    securescreen();
    //checkForSubscription();
    checkInternetConnection();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    var weburl = Uri.parse(widget.urlIs.toString());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '${widget.titleIs}',
            style: TextStyle(color: Colors.black,fontSize: 12),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: Colors.black,
            ),
          ),
        ),

        body: Center(
          child: PDF(
            fitEachPage: true,
            autoSpacing: false,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: false,
            nightMode: false,
            onRender: (_pages) {
              setState(() {
                _totalPages = _pages!;
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController vc) {
              setState(() {
                _pdfViewController = vc;
              });
            },
            onPageChanged: (page, total) {
              setState(() {
                _currentPage = page!;
              });
            },
            onPageError: (page, e) {},
          ).fromUrl(
            '$weburl',
            placeholder: (dynamic progress) => Center(child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.white,),
                    height: 40,
                    width: 40,

                    child: const CupertinoActivityIndicator()),
                const SizedBox(
                  height: 10.0,
                ),

                const Text('Loading...'),

              ],
            ),),
            errorWidget: (dynamic error) => Center(child: Text('$error')),
          ),
        ),
        bottomNavigationBar: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                iconSize: 25,
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    if (_currentPage > 0) {
                      _currentPage--;
                      _pdfViewController.setPage(_currentPage);
                    }
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                iconSize: 25,
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    if (_currentPage < _totalPages - 1) {
                      _currentPage++;
                      _pdfViewController.setPage(_currentPage);
                    }
                  });
                },
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                child: Text(
                  "${_currentPage + 1}/$_totalPages",
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



}*/