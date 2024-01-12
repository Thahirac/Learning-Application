// ignore_for_file: prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'activities_vla/splash_vla.dart';
import 'constants_vla/constant_values_vla.dart';
import 'notification/widgets/firebase_options.dart';
import 'package:hexcolor/hexcolor.dart';

bool isThisUserSubscribed = false;
String singleSubjectSubscriptionIdIs = "";
String appBarTitle = "";
late SharedPreferences prefs;
late Razorpay razorpay;

List<Color> the5Colors = [
  Color.fromRGBO(203, 246, 241, 1.0),
  Color.fromRGBO(252, 245, 233, 1.0),
  Color.fromRGBO(250, 237, 229, 1.0),
  Color.fromRGBO(225, 226, 252, 1.0),
  Color.fromRGBO(248, 221, 243, 1.0),
];



List<Color> the6Colors = [
  HexColor("#ff5346"),
  HexColor("#5a4db7"),
  HexColor("#41adc7"),
  HexColor("#81d252"),
  HexColor("#cac245"),
  HexColor("#fe9d4e"),
];




Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  //print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  var initialzationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings = InitializationSettings(android: initialzationSettingsAndroid);
  flutterLocalNotificationsPlugin.initialize(initializationSettings,);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: channel.description,
            icon: android.smallIcon,
            importance: Importance.max,
            playSound: true,
            showProgress: true,
            priority: Priority.high,
            ticker: 'test ticker',
            fullScreenIntent: true),
      ),
    );
  }
  //android?.imageUrl;
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(name: 'Vidwath-App-Online',
      options: DefaultFirebaseOptions.currentPlatform);
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  runApp(MyApp());
}

/// Entry point for the example application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: ConstantValuesVLA.splashBgColor,
          fontFamily: (languageIndex == 2) ? "Jameel Noori Nastaleeq" : "Roboto"),
      scrollBehavior: CustomClicks(),
      home: SplashVLA(),
      debugShowCheckedModeBanner: (ConstantValuesVLA.baseURLConstant.contains("Android_Online_2.0.6.4_TEST") ? true : false),
    );
  }
}

double appBarHeight = 54;
late bool showAssessKit;
Widget DASHBOARDMAINWIDGET = Container();
List<Widget> listOfWidgetForBack = [];
int studyLabDashTabInitialIndex = 0, assessKitQuizTabInitialIndex = 0, digiAniMindTabInitialIndex = 0, pucTabInitialIndex = 0;
// CHECK BEFORE LIVE
String razorPayKey = "rzp_live_Alln5hJEZdeWrH";
// String razorPayKey = "rzp_test_TH2a1wkkz3KcMI";
int paymentAmount = 90;

int languageIndex = 0;

class CustomClicks extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
