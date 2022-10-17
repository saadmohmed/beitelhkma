import 'package:book_shop/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Wrapper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
  ].request();
  // set the publishable key for Stripe - this is mandatory
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

