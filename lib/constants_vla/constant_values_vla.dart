import 'package:flutter/material.dart';

class ConstantValuesVLA {
  static String logoImage = "assets/vidwathLogo.png";

  // @formatter:off

  /// COLOR CONSTANTS  COLOR CONSTANTS  COLOR CONSTANTS  COLOR CONSTANTS  COLOR CONSTANTS
  static Color splashBgColor = const Color.fromRGBO(4, 108, 192, 1);
  static Color splashBgColorHalfOpacity = const Color.fromRGBO(4, 108, 192, .5);
  static Color liteTextColor = const Color.fromRGBO(255, 255, 255, 1);
  static Color whiteColor = const Color.fromRGBO(255, 255, 255, 1);
  static Color greyTextColor = const Color.fromRGBO(126, 126, 126, 1.0);
  static Color themeColor = const Color.fromRGBO(4, 108, 192, 1);
  static var blackTextColor = const Color.fromRGBO(0, 0, 0, 1.0);
  static var assessKitQuizMargin =  const EdgeInsets.fromLTRB(18, 9, 18, 9);
  static var tabColor =  const Color.fromRGBO(175, 175, 175, 1.0);



  /// API URL COMPONENTS - API URL COMPONENTS - API URL COMPONENTS - API URL COMPONENTS
  /// TEST MODE BASEURL
  static String baseURLConstant = "http://";
  /// LIVE MODE BASEURL
  //static String baseURLConstant = "http://";

  /// ENDPOINTS ENDPOINTS ENDPOINTS ENDPOINTS

  static String requestOTPConstant = "Signin6.3.php";
  static String verifyOTPConstant = "otp/otpverification.php";
  static String oldUserAppConfigConstant = "Appconfig6.3.php";
  static String subjectNamesConstant = "subjectnames.php";
  static String virtualClassesConstant = "youtubelinks.php";
  static String whatsNewConstant = "LiveVideosDemo2.0.php";
  static String conceptualVideosConstant = "ConceptualDemo.php";
  static String beyondTextConstant = "Miscalleneous.php";
  static String tutorialsConstant = "Tutorials2.0.php";
  static String eBookConstant = "e_book.php";
  static String evaluateConstant = "evaluate.php";
  static String dashboardAnalyticsConstant = "pt_get_overall_class_analytics_data.php";
  static String eachSingleSubjectdAnalyticsConstant = "pt_get_single_subject-analytics_data.php";
  static String assessKitsConstant = "AssesKits.php";
  static String afterAssessKitsConstant = "assesments.php";
  static String afterAfterAssessKitsConstant = "Asseskits.php";
  static String mcqConstant = "MCQ.php";
  static String switchGradeConstant = "Classlist6.3.php";
  static String faqsConstant = "FAQ.php";
  static String infoConstant = "Info.php";
  static String blogConstant = "Blog.php";
  static String tutorialViewAllConstant = "TutorialsViewAll2.0.php";
  static String switchCourseConstant = "Boards6.3.php";
  static String gradesConstant = "Classlist6.3.php";
  static String profileConstant = "profile.php";
  static String updateProfileConstant = "updatprofile.php";


  static String myPlansConstant = "mysubscriptions.php";
  static String plansConstant = "Plans6.3.php";


  static String testConstant = "test_sessions.php";
  static String subjectListAnalysisConstant = "pt_get_all_subjects_analytics_data.php";
  static String afterTestConstant = "TestSession_Subjects.php";
  static String afterTestConstantpdf = "Test_Session_Pdfs.php";
  static String afterAfterTestConstant = "Test_Session_Data.php";
  static String digibooksConstant = "Digibooks.php";
  static String animationsConstant = "Animations.php";
  static String mindmapsConstant = "mindmaps.php";
  static String pucShowSubjectsListConstant = "PUC/puc_subjectlist.php";
  static String pucDigibooksConstant = "PUC/puc_digibook.php";
  static String pucExerciseConstant = "PUC/puc_chapterlist.php";
  static String pucAfterExerciseConstant = "PUC/puc_contentlist.php";
  static String subjectwiseAnalysis = "Analylics_get_all_subjects_analytics_data.php";
  static String subsubjectwiseAnalysis = "Analytics_get_all_topics_usage_data.php";
  static String singleaftersubjectwiseAnalysis = "Analytics_get_single_topic_usage_data.php";


  /// Paytm
  static String initialtransationPaytm = "paytmallinone/live/init_Transaction.php";
  static String updateAfterPaymentDoneConstantforPaytm = "Class_subscription.php";
  static String failureUpdateAfterPaymentDoneConstant = "payment_failure.php";

  static String topicAnalysisListAfterViewDetailsConstant = "pt_get_topics_analytics_data.php";
  static String eachTopicEachAttemptConstant = "pt_get_singletopic_all_pt_data.php";
  static String sendMCQcorrecWrongToDatabaseConstant = "pt_insert_practice_test_data.php";
  static String promocodeConstant = "PromoCodes6.3.php";
  static String updateUserDetailsToDatabase = "Userdetails.php";
  static String scienceLab = "ScienceLab.php";
  static String extraResource = "ExtraResources2.2.php";






  /// Razorpay
  static String updateAfterPaymentDoneConstantforRazorpay = "Vidwath_Plans_subscriptions.php";


  /// API JSON REQUEST KEYS - API JSON REQUEST KEYS - API JSON REQUEST KEYS - API JSON REQUEST KEYS - API JSON REQUEST KEYS -
  static String mobileJsonKey = "mobile";
  static String deviceJsonKey = "device";
  static String activeJsonKey = "active";
  static String demo_viewsJsonKey = "demo_views";
  static String device_verificationJsonKey = "device_verification";
  static String emailJsonKey = "email";
  static String dobJsonKey  = "DOB";
  static String otpJsonKey = "otp";
  static String statusJsonKey = "status";
  static String userJsonKey = "user";
  static String useridJsonKey = "userid";
  static String usernameJsonKey = "username";
  static String modelJsonKey = "model";
  static String idJsonKey = "id";
  static String deviceIDJsonKey = "deviceID";
  static String coupen_codeJsonKey = "coupen_code";
  static String districtJsonKey = "district";
  static String refferedJsonKey = "reffered";
  static String verifiedJsonKey = "verified";
  static String user_idJsonKey = "user_id";
  static String regionJsonKey = "region";
  static String boardidJsonKey = "boardid";
  static String boardidJsonKey2 = "board_id";
  static String BoardNameJsonKey = "BoardName";
  static String BoardThumbnailJsonKey = "thumbnail";
  static String class_idJsonKey = "class_id";
  static String classnameJsonKey = "classname";
  static String medium_idJsonKey = "medium_id";
  static String mediumJsonKey = "medium";
  static String subject_idJsonKey = "subject_id";
  static String subjectJsonKey = "subject";
  static String tool_idJsonKey = "tool_id";
  static String topic_idJsonKey = "topic_id";
  static String typeJsonKey = "type";
  static String Subject_idJsonKey = "Subject_id";
  static String session_idJsonKey = "session_id";
  static String JsonKey = "";

// @formatter:on


  static String vidwathAppEmailId = "vidwathapp@vidwath.com";
  static String vidwathTollFreeNumber = "1800 121 223322";
  static String contactInCapital = "CONTACT";
  //static String videoPlayerBaseURL = "https://cdn.vidwathinfra.com/Android_Online/application/";
  static String videoPlayerBaseURL = "https://vidwathapp.b-cdn.net/Android_Online/application/";
}

class AppUtilsString{
  static const String no_internet_msg='It seems no internet connection is available please try again later' ;
  static const String something_went_wrong='Something went wrong..please try again' ;
  static const String entered_wrong_otp=' You entered Wrong OTP ,Please re-enter the OTP ' ;
  static const String otp_resend='One time password has been sent to your registered mobile number' ;
  static const String enter_valid_otp='Please enter valid OTP' ;
  static const String thanks_registration='Thank You For Registering with Vidwath' ;
  static const String about_us_content='Vidwath Offers you an exciting platform for learning. Learning concepts has never been easier & more fun! \n\n This app provides you with customized modules from Grades 1-10. Our visual rich content helps in engaging and enhancing a childs intellectual capability.'  ;
}