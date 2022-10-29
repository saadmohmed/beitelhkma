import 'package:book_shop/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
  ].request();
  // set the publishable key for Stripe - this is mandatory

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FirebaseMessaging messaging;
  @override
  void initState() {
    // TODO: implement initState
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

// getLocation();

    super.initState();
    Firebase.initializeApp();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value){

      print('token : $value');
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.data);


    });
    FirebaseMessaging.onBackgroundMessage((message) async{
      print(message.data);

    });


    FirebaseMessaging.onMessageOpenedApp.listen((message) async{
      print(message.data);
      print('Message clicked!');
      var notificationData = message.data;
      var url = notificationData["url"];
      print(notificationData);

    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light, primaryColor: primary,
          pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              }
          )
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: Locale("ar"),
      title: 'معرض الكتاب',
      home:
      Directionality(textDirection: TextDirection.rtl, child: DefaultTextStyle(

          style: new TextStyle(fontFamily: 'cairo',
            fontSize: 25.0,
          ),
          child: Wrapper())),
    );
  }
}





