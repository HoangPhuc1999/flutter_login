import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterlogin/constant.dart';
import 'package:flutterlogin/route.dart';
import 'package:flutterlogin/splashscreen.dart';
import 'package:flutterlogin/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification/notification_screen.dart';
import 'second/home_screen.dart';
import 'firstpage/loginpage.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print(prefs.getString(Constant.fullName));


  runApp(MaterialApp(
    theme: themeData,
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
       Locale('vi', 'VN'), // Vietnam
       Locale('en', 'US'), // English
    ],
    home: SplashScreen(),
    title: 'Named Routes Demo',
    initialRoute: RoutesName.splashscreen,
    onGenerateRoute: (RouteSettings settings) => routeSetting(settings),


  ));
}

MaterialPageRoute<dynamic> routeSetting(RouteSettings settings) {
  final dynamic data = settings.arguments;
  switch (settings.name) {
    case RoutesName.firstpage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext buildercontext) => FirstScreen(),
        settings: const RouteSettings(name: RoutesName.firstpage),
      );
    case RoutesName.splashscreen:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext buildercontext) => SplashScreen(),
        settings: const RouteSettings(name: RoutesName.splashscreen),
      );
    case RoutesName.secondpage:
      return MaterialPageRoute<dynamic>(
        // ignore: non_constant_identifier_names
        builder: (BuildContext buildercontext) => HomeScreen(
          firstpagetext: data['text'] as String,
          firstpagetext1: data['text1'] as String,
          fullname: data['fullname'] as String,
        ),
        settings: const RouteSettings(name: RoutesName.secondpage),
      );
    case RoutesName.notificationpage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext buildercontext) => NotificationPage(),
        settings: const RouteSettings(name: RoutesName.notificationpage),
      );
    default:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext buildercontext) => Container(),
      );
  }
}
