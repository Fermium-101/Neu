import 'package:flutter/material.dart';
import 'dart:async';

import 'package:new_money/wrapper.dart'; // Import for using Future and Timer
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Add a delay before navigating to the home screen
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Wrapper()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
     double ws = MediaQuery.of(context).size.width / 428;
    double hs = MediaQuery.of(context).size.height / 926;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset('assets/splash.png',height: 237*((ws+hs)/2),width: 228*((ws+hs)/2),)),
    );
  }
}
