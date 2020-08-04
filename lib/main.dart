import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterlogin/example.dart';
import 'package:flutterlogin/route.dart';
import 'package:flutterlogin/splashscreen.dart';
import 'notification/notification_screen.dart';
import 'second/secondscreen.dart';
import 'firstpage/firstscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
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
  //home: MyExample(),

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
        builder: (BuildContext buildercontext) => SecondScreen(
          firstpagetext: data['text'] as String,
          firstpagetext1: data['text1'] as String,
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
