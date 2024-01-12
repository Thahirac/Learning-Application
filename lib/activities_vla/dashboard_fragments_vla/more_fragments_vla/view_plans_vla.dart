// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../constants_vla/constant_values_vla.dart';
import '../../../main.dart';
import '../../../models_vla/plans_model_vla.dart';
import '../../../platform_dependent_vla/payment_vla/andr_ios_web_vla/payment_failure_vla.dart';
import '../../../platform_dependent_vla/payment_vla/andr_ios_web_vla/payment_success_vla.dart';
import '../../../platform_dependent_vla/payment_vla/models/paytm_response.dart';
import '../../../platform_dependent_vla/payment_vla/models/paytm_token.dart';
import '../../../platform_dependent_vla/payment_vla/models/subscription_dao.dart';
import '../../../translation_vla/tr.dart';
import '../../../vidwath_custom_widgets/button_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/edittext_label_icon_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/slide_transition_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/text_custom_vidwath.dart';
import 'dart:ui' as ui;


class ViewPlansVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  ViewPlansVLA(this.thisSetNewScreenFunc, {Key? key}) : super(key: key);

  @override
  State<ViewPlansVLA> createState() => _ViewPlansVLAState();
}

int selectedAmout = 0;
late PaymentSuccessResponse paymentSuccessResponseGlobal;
late PaymentFailureResponse paymentFailureResponseGlobal;
late PlansModelVLA selectedPlansModelVLA;

class _ViewPlansVLAState extends State<ViewPlansVLA> {
  List<Widget> plansWidgetList = [];
  String descriptionHTML = "";
  late ScrollController scrollController;
  late PlansModelVLA plansModelVLA;
  int selectedi = 500;
  String promoCodeIs = "";
  String promoCodeStatus = "";
  int discountAmount = 0;
  String totalAmountStringForTextview = "";
  String? totalAmount="";



  /// Old paytm gateway live mode
  bool _isProgressVisiable = false;
  //MoreModuleApi _moreModuleApi = MoreModuleApi();
  //List<SubscriptionPlansDao> listPlans = [];
  String? medium = '';
  String validity='',subjectId='',subjectName='',planId='',classId='',amount='';
  //String midStagingOld = 'Vidwat38090402621011';
  String midOld= 'Vidwat55723139543015';
  String result = "";
  String? callbackUrl;
  bool isStaging = false;
  bool restrictAppInvoke = false;



  /// New paytm Test mode
  // String midTest = "XukURE56516094780738";
  // String txnTokenTest = "";
  // String orderIdTest = "" ;
  // String amountTest = "";
  // String callbackUrlTest= "";
  // bool isStagingTest = true;
  // bool restrictAppInvokeTest = false;
  // bool enableAssistTest = true;
  // String validity='',subjectId='',subjectName='',planId='',classId='',amount='';
  // String? medium = '';


  @override
  void initState() {
    // razorpay = Razorpay();
    //
    // razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    scrollController = ScrollController();
    getTutorialVideoAPI();
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentSuccessResponseGlobal = response;
    widget.thisSetNewScreenFunc(PaymentSuccessVLA(widget.thisSetNewScreenFunc));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    paymentFailureResponseGlobal = response;
    widget.thisSetNewScreenFunc(PaymentFailureVLA(widget.thisSetNewScreenFunc));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
          controller: scrollController,
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                    margin: EdgeInsets.all(9),
                    child: TextCustomVidwath(
                      textTCV: TR.ourPlans[languageIndex],
                      textColorTCV: ConstantValuesVLA.splashBgColor,
                      fontSizeTCV: 27,
                      fontWeightTCV: FontWeight.bold,
                    )),
              ),
              DividerCustomVidwath(),
              /*Container(
                margin: EdgeInsets.all(12),
                child: Text(
                  TR.please_subscribe[languageIndex],
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ConstantValuesVLA.splashBgColor),
                  textAlign: TextAlign.center,
                ),
              ),*/
              DividerCustomVidwath(),
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: plansWidgetList,
              ),
              DividerCustomVidwath(),
              Padding(
                padding: EdgeInsets.all(9),
                child: HtmlWidget(
                  descriptionHTML
                      .replaceAll("\uf0d8&emsp;", "<br><br\/> &#10004;&emsp; ")
                      .replaceAll("<br><br\/>", "<br>")
                      .replaceAll("Interactive Videos",
                          "Interactive Videos".toUpperCase())
                      .replaceAll("Self-Assessment Tools",
                          "Self-Assessment Tools".toUpperCase())
                      .replaceAll("Test Series", "Test Series".toUpperCase())
                      .replaceAll(
                          "Knowledge Hub", "Knowledge Hub".toUpperCase()),
                  textStyle: TextStyle(
                      fontSize: 18, color: ConstantValuesVLA.blackTextColor),
                ),
              ),

              DividerCustomVidwath(),
              descriptionHTML.length > 0
                  ? Column(
                      children: [

                        DividerCustomVidwath(),

                        Row(
                          children: List.generate(300~/5, (index) => Expanded(
                            child: Container(
                              color: index%2==0?Colors.transparent
                                  :Colors.black,
                              height: 1,
                            ),
                          )),
                        ),


                        DividerCustomVidwath(dividerHeight: 30,),
                        Text(
                          TR.doyouhavepromocode[languageIndex],
                          style: TextStyle(
                              color: ConstantValuesVLA.blackTextColor,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                        DividerCustomVidwath(),
                        Directionality(
                          textDirection: (languageIndex == 2)? ui.TextDirection.ltr : ui.TextDirection.ltr,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(45, 0, 45, 0),
                            child: EdittextLabelIconCustomVidwath(
                              onChangedECV: (tempOnChangedText) {
                                promoCodeIs = tempOnChangedText;
                                if (promoCodeIs.length > 6) {
                                  checkPromoCodeAPI();
                                }
                              },
                              maximumCharsECV: 10,
                              textInputTypeECV: TextInputType.name,
                              labelIConECV: Icons.local_offer_outlined,
                              titleECV: TR.promocode[languageIndex],
                              hintTextECV:
                                  TR.kindlyEnterYourPromoCode[languageIndex],
                            ),
                          ),
                        ),
                        DividerCustomVidwath(),
                        Text(
                          "Payment Details",
                          style: TextStyle(
                              color: ConstantValuesVLA.splashBgColor,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                        DividerCustomVidwath(),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Directionality(
                            textDirection: (languageIndex == 2)? ui.TextDirection.ltr : ui.TextDirection.ltr,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextCustomVidwath(
                                  textTCV: TR.actualAmount[languageIndex],
                                  fontSizeTCV: 18,
                                ),
                                TextCustomVidwath(
                                  textTCV: doCommaFormat(
                                      selectedPlansModelVLA.actual_price),
                                  fontSizeTCV: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Directionality(
                            textDirection: (languageIndex == 2)? ui.TextDirection.ltr : ui.TextDirection.ltr,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextCustomVidwath(
                                  textTCV: TR.discountAmount[languageIndex],
                                  fontSizeTCV: 18,
                                ),
                                DefaultTextStyle(
                                  style: const TextStyle(
                                    fontSize: 19,
                                    color: Colors.green,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 7.0,
                                        color: Colors.white,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: AnimatedTextKit(
                                    repeatForever: true,
                                    pause: Duration(seconds: 0),
                                    animatedTexts: [
                                      FlickerAnimatedText(
                                          doCommaFormat((int.parse(
                                                          selectedPlansModelVLA
                                                              .actual_price) -
                                                      int.parse(
                                                          selectedPlansModelVLA
                                                              .class_price))
                                                  .toString())
                                              .replaceAll("₹ ", "₹ - "),
                                          speed: Duration(seconds: 3)),
                                    ],
                                    onTap: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        (discountAmount > 0)
                            ? Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Directionality(
                                textDirection: (languageIndex == 2)? ui.TextDirection.ltr : ui.TextDirection.ltr,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextCustomVidwath(
                                        textTCV: TR.couponSavings[languageIndex],
                                        fontSizeTCV: 18,
                                      ),
                                      DefaultTextStyle(
                                        style: const TextStyle(
                                          fontSize: 19,
                                          color: Colors.orangeAccent,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 7.0,
                                              color: Colors.white,
                                              offset: Offset(0, 0),
                                            ),
                                          ],
                                        ),
                                        child: AnimatedTextKit(
                                          repeatForever: true,
                                          pause: Duration(seconds: 0),
                                          animatedTexts: [
                                            FlickerAnimatedText(
                                                doCommaFormat(
                                                        discountAmount.toString())
                                                    .replaceAll("₹ ", "₹ - "),
                                                speed: Duration(seconds: 3)),
                                          ],
                                          onTap: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                              ),
                            )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Directionality(
                            textDirection: (languageIndex == 2)? ui.TextDirection.ltr : ui.TextDirection.ltr,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextCustomVidwath(
                                  textTCV: TR.totalAmount[languageIndex],
                                  fontSizeTCV: 23,
                                  fontWeightTCV: FontWeight.bold,
                                ),
                                TextCustomVidwath(
                                  textTCV: totalAmountStringForTextview,
                                  fontSizeTCV: 23,
                                  fontWeightTCV: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                        ),
                        DividerCustomVidwath(),
                        DividerCustomVidwath(),
                        (promoCodeStatus.isNotEmpty)
                            ? TextCustomVidwath(
                                textTCV: promoCodeStatus,
                                textColorTCV:
                                    (promoCodeStatus.contains("Invalid"))
                                        ? Colors.red
                                        : Colors.green,
                              )
                            : DividerCustomVidwath(),
                        (promoCodeStatus.isNotEmpty)
                            ? DividerCustomVidwath()
                            : Container(),
                        ButtonCustomVidwath(
                          textBCV: TR.proceedToPay[languageIndex],
                          enabledBgColorBCV: ConstantValuesVLA.splashBgColor,
                          onPressedBCV: () {
                            //makeRazorpayPayment();
                            callPaymentGateway();
                          },
                        ),
                        DividerCustomVidwath(),
                      ],
                    )
                  : Container(),
            ],
          ),
        )),
      ),
    );
  }

  Future<void> getTutorialVideoAPI() async {
    var url = Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.plansConstant);
    var viewPlansJson = {
      ConstantValuesVLA.user_idJsonKey: prefs.getString(ConstantValuesVLA.user_idJsonKey),
      ConstantValuesVLA.class_idJsonKey: prefs.getString(ConstantValuesVLA.class_idJsonKey),
      ConstantValuesVLA.classnameJsonKey: prefs.getString(ConstantValuesVLA.classnameJsonKey)!.replaceAll("11", "Class XI").replaceAll("12", "Class XII"),
      //"Board_id": "2"
    "Board_id": prefs.getString(ConstantValuesVLA.boardidJsonKey)
    };
    // print("viewPlansJson");
    // print(viewPlansJson);
    http.post(url, body: jsonEncode(viewPlansJson)).then((value) {
      List<dynamic> tutorialVideoListTemp = jsonDecode(value.body).toList();
      for (int i = 0; i < tutorialVideoListTemp.length; i++) {
        plansModelVLA = PlansModelVLA.fromJson(tutorialVideoListTemp[i]);
        String tempPlus = "";
        if (plansModelVLA.feature.contains("0")) {
          tempPlus = " ";
        } else {
          tempPlus = " + ";
        }
        plansWidgetList.add(
          SlideTransitionCustomVidwath(
            (i + 2),
            Offset(0.0, (1.5 * (i + 2))),
            GestureDetector(
              onTap: () {
                selectedPlansModelVLA = PlansModelVLA.fromJson(tutorialVideoListTemp[i]);
                selectedAmout = int.parse(selectedPlansModelVLA.class_price);
                paymentAmount = selectedAmout * 100;
                totalAmountStringForTextview = doCommaFormat((paymentAmount ~/ 100).toInt().toString());
                totalAmount = totalAmountStringForTextview.replaceAll(RegExp(r'\D'),'');
                setState(() {
                  totalAmountStringForTextview;
                  totalAmount;
                //  print('********************TOTAL AMOUNT **************************$totalAmount');
                });
                if (promoCodeIs.length > 3) {
                  checkPromoCodeAPI();
                }
                descriptionHTML = selectedPlansModelVLA.description;

                //descriptionHTML = "\r\n\r\n<b style=\"font-size:20px;\"><p style=\"color:#01313;\"></p></b>\r\n\r\nInteractive Videos <br><br/>\r\n<p style=\"color:#ff0000\">\r\n&#10004;&emsp;\tTutorial Videos<br><br/>\r\n&#10004;&emsp;\tAnimated Videos<br><br/>\r\n&#10004;&emsp;\tDigi Books<br><br/>\r\n&#10004;&emsp;\tE-Books<br><br/>\r\n&#10004;&emsp;\tMind Maps<br><br/></p>\r\n <br><br/>\r\n\r\nSelf-Assessment Tools <br><br/>\r\n<p style=\"color:#03DAC5\">\r\n&#10004;&emsp;\tTextbook Solutions<br><br/>\r\n&#10004;&emsp;\tQuestion Bank <br><br/>\r\n&#10004;&emsp;\tWorksheets<br><br/>\r\n&#10004;&emsp;\tLesson Planners <br><br/></p>\r\n <br><br/>\r\nTest Series<br><br/>\r\n<p style=\"color:#f4a620\">\r\n&#10004;&emsp;\tStudy Package <br><br/>\r\n&#10004;&emsp;\tUnit Test <br><br/>\r\n&#10004;&emsp;\tSample Papers<br><br/>\r\n&#10004;&emsp;\tMost Important Questions<br><br/>\r\n&#10004;&emsp;\tAptitude<br><br/><p/>\r\n<br><br/>\r\nKnowledge Hub <br><br/> \r\n<p style=\"color:#4F9EA8\">\r\n&emsp;\tQuotes\r\n&emsp;\tVocabulary\r\n&emsp;\tHumor\r\n&emsp;\tSports\r\n&emsp;\tAchievers\r\n&emsp;\tSocial Facts\r\n&emsp;\tRiddles\r\n&emsp;\tBrain Teasers\r\n&emsp;\tScience Facts\r\n&emsp;\tMath Facts\r\n&emsp;\tScience & Technology <br><br/></p>\r\n";

                setState(() {
                  descriptionHTML;
                });
                selectedi = i;
                setState(() {
                  selectedi;
                });
                scrollToBottom();
              },
              child: Container(
                width: 153,
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(boxShadow: const [
                  BoxShadow(
                    blurRadius: 18,
                    offset: Offset(5, 5),
                    color: Color.fromRGBO(55, 71, 79, .3),
                  )
                ], borderRadius: BorderRadius.all(Radius.circular(27))),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(27.0),
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            DividerCustomVidwath(),
                            DividerCustomVidwath(),
                            TextCustomVidwath(
                              textTCV:
                                  plansModelVLA.class_validity.toUpperCase() +
                                      tempPlus +
                                      plansModelVLA.feature
                                          .replaceAll("0", "")
                                          .toUpperCase(),
                              textColorTCV: ConstantValuesVLA.splashBgColor,
                              fontSizeTCV: 18,
                            ),
                            DividerCustomVidwath(),
                            TextCustomVidwath(
                              textTCV: doCommaFormat(plansModelVLA.class_price),
                              fontSizeTCV: 23,
                              fontWeightTCV: FontWeight.bold,
                              textColorTCV: ConstantValuesVLA.splashBgColor,
                            ),
                            Text(
                              doCommaFormat(plansModelVLA.actual_price),
                              style: TextStyle(
                                  color: ConstantValuesVLA.splashBgColor,
                                  fontSize: 18,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.red),
                            ),
                            DividerCustomVidwath(),
                            Container(
                              color: Colors.red,
                              width: 153,
                              height: 45,
                              child: Center(
                                child: TextCustomVidwath(
                                  textTCV: TR.subscribe_now[languageIndex],
                                  fontSizeTCV: 12,
                                  fontWeightTCV: FontWeight.bold,
                                  textColorTCV: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      (languageIndex == 2)
                          ? Container()
                          : Transform.translate(
                              offset: Offset(-45, -5),
                              child: Transform.rotate(
                                angle: -45,
                                child: Container(
                                  color: ConstantValuesVLA.splashBgColor,
                                  width: 90,
                                  height: 18,
                                  margin: EdgeInsets.fromLTRB(0, 36, 0, 0),
                                  child: Center(
                                    child: TextCustomVidwath(
                                      textTCV: "      " +
                                          "₹ " +
                                          (int.parse(plansModelVLA
                                                      .actual_price) -
                                                  int.parse(plansModelVLA
                                                      .class_price))
                                              .toString() +
                                          "/-" +
                                          " off !!!",
                                      textColorTCV: Colors.white,
                                      fontWeightTCV: FontWeight.bold,
                                      fontSizeTCV: 7,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
      setState(() {
        plansWidgetList;
      });
    });
  }

  Future<bool> onBackPressed() {
    listOfWidgetForBack.removeLast();
    widget.thisSetNewScreenFunc(listOfWidgetForBack.last, addToQueue: false);
    return Future.value(false);
  }

  void scrollToBottom() {
    Future.delayed(Duration(seconds: 1), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(seconds: 9), curve: Curves.decelerate);
    });
  }

  String doCommaFormat(String actual_price) {
    return "₹ " +
        NumberFormat('##,##,000').format(int.parse(actual_price)).toString() +
        "/-";
  }

  void checkPromoCodeAPI() {
    http.post(Uri.parse(ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.promocodeConstant),
            body: jsonEncode({
              "subject_id": "0",
              ConstantValuesVLA.classnameJsonKey: prefs.getString(ConstantValuesVLA.classnameJsonKey),
              ConstantValuesVLA.user_idJsonKey: prefs.getString(ConstantValuesVLA.user_idJsonKey),
              "class_id": prefs.getString(ConstantValuesVLA.class_idJsonKey),
              "Board_id": prefs.getString(ConstantValuesVLA.boardidJsonKey),
              "promocode": promoCodeIs
            }))
        .then((promoCodeResponse) {
      var encodedJson = jsonDecode(promoCodeResponse.body);
      promoCodeStatus = encodedJson["message"];
      if (promoCodeStatus.contains("Successfully")) {
        discountAmount = int.parse(encodedJson["discount_percentage"]) *
            selectedAmout ~/
            100;
        if (discountAmount > int.parse(encodedJson["max_deduction"])) {
          discountAmount = int.parse(encodedJson["max_deduction"]);
        }
        paymentAmount = (selectedAmout - discountAmount) * 100;
        totalAmountStringForTextview =
            doCommaFormat((paymentAmount ~/ 100).toInt().toString());
      } else {
        discountAmount = 0;
        paymentAmount = (selectedAmout - discountAmount) * 100;
        totalAmountStringForTextview =
            doCommaFormat((paymentAmount ~/ 100).toInt().toString());
      }
      //print("totalAmountStringForTextview");
      //print(totalAmountStringForTextview);
      setState(() {
        promoCodeStatus;
        discountAmount;
        paymentAmount;
        totalAmountStringForTextview;
      });
    });
  }


  void callPaymentGateway() async{
    if(plansModelVLA.class_validity != '0'){
      validity = plansModelVLA.class_validity;
      amount = plansModelVLA.actual_subject_price;
    }else {
      validity = plansModelVLA.class_validity;
      amount = plansModelVLA.actual_subject_price;
      subjectId = plansModelVLA.subject_id;
      subjectName = plansModelVLA.subject_name;
    }
    planId = plansModelVLA.plan_id;
    classId = plansModelVLA.class_id;

    PaymentGatewayApi _paymentGatewayApi= PaymentGatewayApi();
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

   // print('**************ORDER ID*******************$orderId');

    await _paymentGatewayApi.generateTokenApiCall('12345',midOld,orderId.toString(),totalAmount!).then((value) {
      Map<String, dynamic> parsed= json.decode(value);
      PaytmToken _paytmToken=   PaytmToken.fromJson(parsed);

      /// For live mode
      String? token = _paytmToken.body!.txnToken;


      _startTransaction(token,orderId);
    }).catchError((e) {
      // _isvisible = false;
      setState(() {});
     // print('***********ERROR**************$e');
    });

  }

  Future _startTransaction(String? token , String orderId) async {

    callbackUrl= 'https://securegw.paytm.in/theia/paytmCallback?ORDER_ID=$orderId';
    //callbackUrlTest= 'https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=$orderId';


    var response = AllInOneSdk.startTransaction(midOld, orderId, totalAmount!, token!, callbackUrl.toString(), isStaging, restrictAppInvoke);

    response.then((value) {

      PaytmResponse paytmResponse = PaytmResponse.fromJson(value!);

      if(paytmResponse.status == 'TXN_SUCCESS'){
       // print('Transaction Successfull');
        callApiSuccessDataCapture(orderId);

      }else if(paytmResponse.status == 'TXN_FAILURE'){
       // print('Transaction Failure');
        callApiFailureDataCapture(paytmResponse.status,orderId);
      }else if(paytmResponse.status == 'PENDING'){
        print('Transaction is in pending status. if any amount is deducted from your account, please make a call with vidwath');
        callApiFailureDataCapture('Pending Status.. Please check after some time',orderId);
      }

    }).catchError((onError){
      if(onError is PlatformException){
        print('Cancelled by user');
        callApiFailureDataCapture(onError.message,orderId);

      }else{
        print('Cancelled by user');
        callApiFailureDataCapture(onError.message,orderId);
      }
    });

  }


  void callApiSuccessDataCapture(String orderId) async{

    PaymentGatewayApi _paymentGatewayApi= PaymentGatewayApi();

    if(subjectId== null || subjectId==''){
      subjectId = '0';
    }


    await _paymentGatewayApi.updateSuccessSubscription(totalAmount!,subjectId,subjectName, selectedPlansModelVLA.class_validity, orderId).then((value) {

      // SubscriptionDao _subscriptionDao = SubscriptionDao.fromJson(value);
      // PreferenceManager.setFullClassSubscription(_subscriptionDao.classSubscribe!);

      subscriptionSuccessBottomSheet();

    }).catchError((e) {
      setState(() {});
      print('*********************$e');
    });
  }


  void callApiFailureDataCapture(String? status,String orderId) async{

    PaymentGatewayApi _paymentGatewayApi= PaymentGatewayApi();

    await _paymentGatewayApi.updateFailureStatus(totalAmount!,status!, selectedPlansModelVLA.class_validity, orderId).then((value) {




    }).catchError((e) {
      setState(() {});
      print('*********************$e');
    });
  }






  subscriptionSuccessBottomSheet() async{
    String? className = await prefs.getString(ConstantValuesVLA.classnameJsonKey);
    String? userName = await prefs.getString(ConstantValuesVLA.usernameJsonKey);
    showModalBottomSheet(
      context: context,
      isDismissible : false,
      enableDrag: false,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      builder: (builder) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/lottie_json/success.json", height: 200, width: 200, repeat: false).center(),
                16.height,
                Text('Congratulations $userName !!', style: TextStyle(color: Color(0xFF065ea4),fontSize: 18, fontWeight: FontWeight.bold)),
                16.height,

                Text('Your subscription for ${prefs.getString(ConstantValuesVLA.BoardNameJsonKey)} Grade $className is successfully done.'
                    , style: TextStyle(color: Color(0xFF065ea4),
                        fontSize: 14, fontWeight: FontWeight.normal)).center(),
                16.height,

                Container(
                  margin: EdgeInsets.only(
                      left: 16, right: 16, top: 5, bottom: 10),
                  alignment: Alignment.center,
                  child: AppButton(
                    color: Color(0xFF065ea4),
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Text("Continue",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontStyle: FontStyle.normal)),
                    ),
                    onTap: () {

                      SystemNavigator.pop();
                      Navigator.pop(context);


                    },
                  ),
                ),
                8.height,
              ],
            ),
          ),
        );
      },
    );
  }



/*  void makeRazorpayPayment() {
    // https://stackoverflow.com/questions/61320329/how-to-use-razorpay-orders-api-in-flutter#:~:text=%27order_id%27%3A%20%27order_EMBFqjDHEEn80l%27%2C%20//%20Generate%20order_id%20using%20Orders%20API

    String username = "rzp_live_Alln5hJEZdeWrH";
    String password = "6TdPgbdGEKzf7IeSUv7U4SLn";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http
        .post(Uri.parse("https://api.razorpay.com/v1/orders"),
            headers: {
              "Content-type": "application/json",
              "Authorization": basicAuth
            },
            body: jsonEncode({
              "amount": paymentAmount,
              "currency": "INR",
              "receipt": "receipt#" +
                  DateFormat('yyyymmddHHmmss').format(DateTime.now()) +
                  prefs.getString(ConstantValuesVLA.useridJsonKey).toString()
            }))
        .then((orderIdResponse) {
      print("orderid");
      print(jsonDecode(orderIdResponse.body)["id"]);
      print("receipt");
      print(DateFormat('yyyymmddHHmmss').format(DateTime.now()) +
          prefs.getString(ConstantValuesVLA.useridJsonKey).toString());
      var options = {
        'key': razorPayKey,
        'amount': paymentAmount,
        'name': 'Vidwath Innovative Solutions Pvt. Ltd.',
        'description': '₹ ' + (paymentAmount ~/ 100).toString() + '/-',
        'order_id': jsonDecode(orderIdResponse.body)["id"],
        'prefill': {
          'contact': prefs.getString(ConstantValuesVLA.mobileJsonKey),
          'email': ConstantValuesVLA.vidwathAppEmailId
        }
      };

      try {
        razorpay.open(options);
      } catch (e) {}
    });
  }*/


}

class PaymentGatewayApi{

  Future<String> generateTokenApiCall(String code,String MID,String orderId,String amount) async {
    String? customerId = await prefs.getString(ConstantValuesVLA.useridJsonKey);
    Map req = {
      'code': code,
      'MID': MID,
      'ORDER_ID': orderId,
      'AMOUNT':amount,
      'CUST_ID': customerId
    };

    return await postRequestPaytm(ConstantValuesVLA.initialtransationPaytm, req);
  }

  Future handleResponse(Response response) async {
    var data ;
    if (response.statusCode.isSuccessful()) {
      data = jsonDecode(response.body);
      return data;
    } else {
      if (response.body.isJson()) {
        data = jsonDecode(response.body);
        throw data;
      } else {
        if (!await isNetworkAvailable()) {
          throw AppUtilsString.no_internet_msg;
        } else {
          throw 'Please try again';
        }
      }
    }
  }

  Future<Response> postRequest(String endPoint, body) async {
    try {
      if (!await isNetworkAvailable()) throw AppUtilsString.no_internet_msg;

      String url = "${ConstantValuesVLA.baseURLConstant}$endPoint";

      print('URL: $url');
      print('Request: $body');

      Response response = await post(Uri.parse(url), body: jsonEncode(body), headers: buildHeader())
          .timeout(Duration(seconds: 70),
          onTimeout: () => throw "Please try again");

      return response;
    } catch (e) {
      print(e);
      if (!await isNetworkAvailable()) {
        throw AppUtilsString.no_internet_msg;
      } else {
        throw "Please try again";
      }
    }
  }



  Future<String> postRequestPaytm(String endPoint, body) async {
    try {
      if (!await isNetworkAvailable()) throw AppUtilsString.no_internet_msg;

      String url = "${ConstantValuesVLA.baseURLConstant}$endPoint";

      print('URL: $url');
      print('Request: $body');

      Response response = await post(Uri.parse(url), body: body, headers: buildHeaderPaytm(),encoding: Encoding.getByName('utf-8'))
          .timeout(Duration(seconds: 70),
          onTimeout: () => throw "Please try again");

      var jsonData= response.body;
      return jsonData;
    } catch (e) {
      print('*************ERROR************$e');
      if (!await isNetworkAvailable()) {
        throw AppUtilsString.no_internet_msg;
      } else {
        throw "Please try again";
      }
    }
  }

  Map<String, String> buildHeader() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
  }


  Map<String, String> buildHeaderPaytm() {
    return {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
  }


  Future updateSuccessSubscription(String amount,String subjectId,String subjectName,String validity,String orderId) async {


    Map req = {
      'txn_amount': amount,
      'subject_id': subjectId,
      'subject_name': subjectName,
      'validity':  validity,
      'order_id': orderId,
      'user_id': prefs.getString(ConstantValuesVLA.user_idJsonKey),
      'user_name':prefs.getString(ConstantValuesVLA.usernameJsonKey).toString(),
      'class_id': prefs.getString(ConstantValuesVLA.class_idJsonKey),
      'board': '',
      'Class': prefs.getString(ConstantValuesVLA.classnameJsonKey),
      'payment_id':'Paytm',
      'email': '',
      'topic_id': '0',
      'gatway': 'Paytm',
      'medium': prefs.getString(ConstantValuesVLA.BoardNameJsonKey),
    };


    return await handleResponse(await postRequest(ConstantValuesVLA.updateAfterPaymentDoneConstantforPaytm, req));
  }


  Future updateFailureStatus(String amount,String reason,String validity,String orderId) async {


    Map req = {
      'amount': amount,
      'failure_rerason': reason,
      'validity': validity,
      'order_id': orderId,
      'user_id': prefs.getString(ConstantValuesVLA.user_idJsonKey),
      'name': prefs.getString(ConstantValuesVLA.usernameJsonKey).toString(),
      'class_id': prefs.getString(ConstantValuesVLA.class_idJsonKey),
      'classname': prefs.getString(ConstantValuesVLA.classnameJsonKey),
      'mobile': prefs.getString(ConstantValuesVLA.mobileJsonKey).toString(),
      'gateway': 'Paytm',
    };


    await handleResponse(await postRequest(ConstantValuesVLA.failureUpdateAfterPaymentDoneConstant, req));
  }

}




