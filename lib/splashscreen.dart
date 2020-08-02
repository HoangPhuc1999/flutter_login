import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutterlogin/firstpage/firstscreen.dart';
import 'package:flutterlogin/route.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
        () =>  Navigator.pushNamed(
          context,
          RoutesName.firstpage,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF084388),
      body: Center(
        child: Image.asset('images/Anvui.png'),
      ),
    );
  }
}
