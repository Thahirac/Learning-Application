// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

import '../../constants_vla/constant_values_vla.dart';
import '../../main.dart';
import '../../platform_dependent_vla/webview_vla/andr_ios_web_vla/custom_webview_vla.dart';
import '../../translation_vla/tr.dart';
import '../../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../../vidwath_custom_widgets/text_custom_vidwath.dart';
import '../dashboard_vla.dart';
import '../sign_up_vla.dart';
import 'more_fragments_vla/about_us_vla.dart';
import 'more_fragments_vla/blogs_vla.dart';
import 'more_fragments_vla/check_subscriptions_my_plans_vla.dart';
import 'more_fragments_vla/each_more_horizontal_vla.dart';
import 'more_fragments_vla/each_more_vertical_vla.dart';
import 'more_fragments_vla/faqs_vla.dart';
import 'more_fragments_vla/my_plans_vla.dart';
import 'more_fragments_vla/profile_vla.dart';
import 'more_fragments_vla/switch_course_vla.dart';
import 'more_fragments_vla/switch_grade_vla.dart';
import 'more_fragments_vla/view_plans_vla.dart';

class MoreDashVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  MoreDashVLA(this.thisSetNewScreenFunc, {Key? key}) : super(key: key);

  @override
  State<MoreDashVLA> createState() => _MoreDashVLAState();
}

class _MoreDashVLAState extends State<MoreDashVLA> {
  double screenWidth = 0, screenHeight = 0;
  bool showContactUs = false;
  bool showLogout = false;
  final Uri emailOfContactUs = Uri(
    scheme: 'mailto',
    path: ConstantValuesVLA.vidwathAppEmailId,
    query: 'subject=&body=', //add subject and body here
  );

  @override
  void initState() {
    currentIndexOfBottomPressed = 4;
    setState(() {
      currentIndexOfBottomPressed;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(9),
              child: Column(
                children: [
                  DividerCustomVidwath(),
                  // PROFILE PROFILE  PROFILE PROFILE  PROFILE PROFILE
                  GestureDetector(
                    onTap: () {
                      widget.thisSetNewScreenFunc(
                          Directionality(
                             textDirection: (languageIndex == 2)? TextDirection.ltr : TextDirection.ltr,
                              child: ProfileVLA(widget.thisSetNewScreenFunc)));

                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/ic_profile_new.png",
                            height: 65,
                            width: 65,
                          ),
                          SizedBox(width: 5,),
                          TextCustomVidwath(
                            textTCV: prefs.getString(ConstantValuesVLA.usernameJsonKey).toString(),
                          ),
                          Expanded(child: SizedBox()),
                          Icon(
                            Icons.chevron_right,
                            color: ConstantValuesVLA.splashBgColor,
                            size: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                  // VIEW PLANS SWITCH GRADE AND COURSE // VIEW PLANS SWITCH GRADE AND COURSE
                  DividerCustomVidwath(),
                  Container(
                    width: screenWidth,
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        EachMoreVerticalVLA(
                          imageAssetNameBNECV: "assets/ic_plans_new.png",
                          onPressedBNECV: () {
                            // if (isThisUserSubscribed) {


                              // widget.thisSetNewScreenFunc(
                              //     CheckSubscriptionMyPlansVLA(
                              //         widget.thisSetNewScreenFunc));

                            //   widget.thisSetNewScreenFunc(
                            //       Directionality(
                            //           textDirection: (languageIndex == 2)? TextDirection.ltr : TextDirection.ltr,
                            //           child: CheckSubscriptionMyPlansVLA(widget.thisSetNewScreenFunc)));
                            //
                            // } else {

                              // widget.thisSetNewScreenFunc(
                              //     ViewPlansVLA(widget.thisSetNewScreenFunc));
                              //
                              widget.thisSetNewScreenFunc(
                                  Directionality(
                                      textDirection: (languageIndex == 2)? TextDirection.rtl : TextDirection.ltr,
                                      child: ViewPlansVLA(widget.thisSetNewScreenFunc)));

                           // }
                          },
                          labelBNECV: TR.view_plans[languageIndex],
                        ),
                        EachMoreVerticalVLA(
                          imageAssetNameBNECV: "assets/ic_switch_grade_new.png",
                          onPressedBNECV: () {

                            widget.thisSetNewScreenFunc(
                                Directionality(
                                    textDirection: (languageIndex == 2)? TextDirection.ltr : TextDirection.ltr,
                                    child: SwitchGradeVLA(widget.thisSetNewScreenFunc)));

                            // widget.thisSetNewScreenFunc(
                            //     SwitchGradeVLA(widget.thisSetNewScreenFunc));
                          },
                          labelBNECV: TR.switch_class[languageIndex],
                        ),
                        EachMoreVerticalVLA(
                          imageAssetNameBNECV: "assets/ic_switch_class.png",
                          onPressedBNECV: () {

                            widget.thisSetNewScreenFunc(
                                Directionality(
                                    textDirection: (languageIndex == 2)? TextDirection.ltr : TextDirection.ltr,
                                    child: SwitchCourseVLA(widget.thisSetNewScreenFunc)));


                            // widget.thisSetNewScreenFunc(
                            //     SwitchCourseVLA(widget.thisSetNewScreenFunc));
                          },
                          labelBNECV: TR.switch_medium[languageIndex],
                        ),
                      ],
                    ),
                  ),
                  // MY PLANS FAQS ABOUT US PRIVACY POLICY ETC// MY PLANS FAQS ABOUT US PRIVACY POLICY ETC
                  DividerCustomVidwath(),
                  SizedBox(
                    width: screenWidth,
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        EachMoreHorizontalVLA(
                          imageAssetNameBNECV: "assets/ic_my_plans.png",
                          onPressedBNECV: () {


                            // widget.thisSetNewScreenFunc(
                            //     MyPlansVLA(widget.thisSetNewScreenFunc));


                            widget.thisSetNewScreenFunc(
                                Directionality(
                                    textDirection: (languageIndex == 2)? TextDirection.ltr : TextDirection.ltr,
                                    child: MyPlansVLA(widget.thisSetNewScreenFunc)));


                          },
                          labelBNECV: TR.my_plan[languageIndex],
                        ),
                        EachMoreHorizontalVLA(
                          imageAssetNameBNECV: "assets/ic_faq_new.png",
                          onPressedBNECV: () {

                            // widget.thisSetNewScreenFunc(
                            //     FAQsVLA(widget.thisSetNewScreenFunc));

                            widget.thisSetNewScreenFunc(
                                Directionality(
                                    textDirection: (languageIndex == 2)? TextDirection.ltr : TextDirection.ltr,
                                    child: FAQsVLA(widget.thisSetNewScreenFunc)));

                          },
                          labelBNECV: TR.faqs[languageIndex],
                        ),
                        EachMoreHorizontalVLA(
                          imageAssetNameBNECV: "assets/ic_about_new.png",
                          onPressedBNECV: () {

                            // widget.thisSetNewScreenFunc(
                            //     AboutUsVLA(widget.thisSetNewScreenFunc));


                            widget.thisSetNewScreenFunc(
                                Directionality(
                                    textDirection: (languageIndex == 2)? TextDirection.ltr : TextDirection.ltr,
                                    child:  AboutUsVLA(widget.thisSetNewScreenFunc)));

                          },
                          labelBNECV: TR.about[languageIndex],
                        ),
                        EachMoreHorizontalVLA(
                          imageAssetNameBNECV: "assets/ic_contact_us_new.png",
                          onPressedBNECV: () {
                            showContactUs = true;
                            setState(() {
                              showContactUs;
                            });
                          },
                          labelBNECV: TR.contact[languageIndex],
                        ),
                        EachMoreHorizontalVLA(
                          imageAssetNameBNECV: "assets/ic_privacy_policy_new.png",
                          onPressedBNECV: () {

                            widget.thisSetNewScreenFunc(CustomWebviewVLA(
                                widget.thisSetNewScreenFunc,
                                "https://vidwath.com/privacy-policy.html"));

                          },
                          labelBNECV: TR.privacy_policy2[languageIndex],
                        ),
                        EachMoreHorizontalVLA(
                          imageAssetNameBNECV: "assets/ic_refund_policy_new.png",
                          onPressedBNECV: () {

                            widget.thisSetNewScreenFunc(CustomWebviewVLA(
                                widget.thisSetNewScreenFunc,
                                "https://vidwath.com/refund-policy.html"));
                          },
                          labelBNECV: TR.refund_policy[languageIndex],
                        ),
                        EachMoreHorizontalVLA(
                          imageAssetNameBNECV: "assets/ic_terms_condition_new.png",
                          onPressedBNECV: () {
                            widget.thisSetNewScreenFunc(CustomWebviewVLA(
                                widget.thisSetNewScreenFunc,
                                "https://vidwath.com/tnc.html"));
                          },
                          labelBNECV: TR.terms_amp_conditions[languageIndex],

                        ),
                        EachMoreHorizontalVLA(
                          imageAssetNameBNECV: "assets/ic_share_new.png",
                          onPressedBNECV: () {
                            Share.share(
                                'Take a break, chill and study, Download Vidwath Learning App Today! https://vidwathlearning.page.link/2xaqvDpxGWfqhALX9',
                                subject: "Vidwath Application");
                          },
                          labelBNECV: TR.share_app[languageIndex],
                        ),
                        EachMoreHorizontalVLA(
                          imageAssetNameBNECV: "assets/ic_blogs_new.png",
                          onPressedBNECV: () {


                            // widget.thisSetNewScreenFunc(
                            //     BlogsVLA(widget.thisSetNewScreenFunc));


                            widget.thisSetNewScreenFunc(
                                Directionality(
                                    textDirection: (languageIndex == 2)? TextDirection.ltr : TextDirection.ltr,
                                    child: BlogsVLA(widget.thisSetNewScreenFunc)));
                          },
                          labelBNECV: TR.blogs[languageIndex],
                        ),
                        EachMoreHorizontalVLA(
                          imageAssetNameBNECV: "assets/ic_logout_new.png",
                          onPressedBNECV: () {
                            showLogout = true;
                            setState(() {
                              showLogout;
                            });
                          },
                          labelBNECV: TR.logout[languageIndex],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          showContactUs
              ? Container(
                  color: Color.fromRGBO(149, 149, 149, 0.5019607843137255),
                  height: screenHeight,
                  width: screenWidth,
                  child: Center(
                    child: Container(
                      color: ConstantValuesVLA.whiteColor,
                      margin: EdgeInsets.all(18),
                      height: 261,
                      child: Column(
                        children: [
                          Container(
                            color: ConstantValuesVLA.splashBgColor,
                            width: MediaQuery.of(context).size.width,
                            height: 54,
                            child: Center(
                              child: Stack(
                                children: [
                                  Align(
                                      alignment: Alignment.center,
                                      child: TextCustomVidwath(
                                        textTCV:
                                            ConstantValuesVLA.contactInCapital,
                                        textColorTCV:
                                            ConstantValuesVLA.whiteColor,
                                        fontSizeTCV: 32,
                                      )),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      onPressed: () {
                                        showContactUs = false;
                                        setState(() {
                                          showContactUs;
                                        });
                                      },
                                      icon: const Icon(Icons.close),
                                      color: ConstantValuesVLA.whiteColor,
                                      iconSize: 23,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          DividerCustomVidwath(),
                          Flexible(
                              child: Text(
                            TR.msg_contact_header[languageIndex],
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          )),
                          DividerCustomVidwath(),
                          GestureDetector(
                            onTap: () {
                              launch("tel://" + ConstantValuesVLA.vidwathTollFreeNumber);
                            },
                            child: Directionality(
                              textDirection: (languageIndex == 2)? TextDirection.ltr : TextDirection.ltr,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.call,
                                    color: ConstantValuesVLA.splashBgColor,
                                    size: 23,
                                  ),
                                  TextCustomVidwath(
                                    textTCV: ConstantValuesVLA.vidwathTollFreeNumber,
                                    textColorTCV: ConstantValuesVLA.splashBgColor,
                                    fontSizeTCV: 18,
                                  )
                                ],
                              ),
                            ),
                          ),
                          TextCustomVidwath(
                            textTCV: "(Toll-free Number)",
                          ),
                          DividerCustomVidwath(),
                          GestureDetector(
                            onTap: () {
                              launch(emailOfContactUs.toString());
                            },
                            child: Directionality(
                              textDirection: (languageIndex == 2)? TextDirection.ltr : TextDirection.ltr,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.email,
                                    color: ConstantValuesVLA.splashBgColor,
                                    size: 36,
                                  ),
                                  TextCustomVidwath(
                                    textTCV: ConstantValuesVLA.vidwathAppEmailId,
                                    textColorTCV: ConstantValuesVLA.splashBgColor,
                                    fontSizeTCV: 18,
                                  )
                                ],
                              ),
                            ),
                          ),
                          DividerCustomVidwath(),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
          showLogout
              ? Container(
                  color: Color.fromRGBO(149, 149, 149, 0.5019607843137255),
                  height: screenHeight,
                  width: screenWidth,
                  child: Center(
                    child: Container(
                      color: ConstantValuesVLA.whiteColor,
                      margin: EdgeInsets.all(18),
                      height: 207,
                      child: Column(
                        children: [
                          Container(
                            color: ConstantValuesVLA.splashBgColor,
                            width: MediaQuery.of(context).size.width,
                            height: 54,
                            child: Center(
                              child: Stack(
                                children: [
                                  Align(
                                      alignment: Alignment.center,
                                      child: TextCustomVidwath(
                                        textTCV: TR.logout[languageIndex],
                                        textColorTCV:
                                            ConstantValuesVLA.whiteColor,
                                        fontSizeTCV: 32,
                                      )),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      onPressed: () {
                                        showLogout = false;
                                        setState(() {
                                          showLogout;
                                        });
                                      },
                                      icon: const Icon(Icons.close),
                                      color: ConstantValuesVLA.whiteColor,
                                      iconSize: 36,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          DividerCustomVidwath(),
                          Directionality(
                            textDirection: (languageIndex == 2)? TextDirection.ltr : TextDirection.ltr,
                            child: TextCustomVidwath(
                                textTCV: TR.areYouSure[languageIndex]),
                          ),
                          DividerCustomVidwath(),
                          Directionality(
                            textDirection: (languageIndex == 2)? TextDirection.ltr : TextDirection.ltr,
                            child: ElevatedButton.icon(
                                onPressed: () {
                                  removeAllSharedPreference();
                                },
                                icon: Icon(Icons.logout),
                                label: TextCustomVidwath(
                                  textTCV: TR.logout[languageIndex],
                                  textColorTCV: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Future<bool> onBackPressed() {
    //widget.thisSetNewScreenFunc(LearnDashVLA(widget.thisSetNewScreenFunc));
    listOfWidgetForBack.removeLast();
    widget.thisSetNewScreenFunc(listOfWidgetForBack.last, addToQueue: false);
    return Future.value(false);
  }

  void removeAllSharedPreference() {
    prefs.clear().then((value) {
      listOfWidgetForBack = [];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignUpVLA()),
      );
    });
  }
}
