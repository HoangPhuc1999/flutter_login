import 'package:flutter/material.dart';
import 'package:flutterlogin/route.dart';
import 'package:flutterlogin/splashscreen.dart';
import 'second/secondscreen.dart';
import 'firstpage/firstscreen.dart';


  void main()  {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp (
     home: SplashScreen(),
     title: 'Named Routes Demo',
     initialRoute: RoutesName.splashscreen,
     onGenerateRoute:(RouteSettings settings)=> routeSetting(settings),
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
    default:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext buildercontext) => Container(),
      );
  }
}
