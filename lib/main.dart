import 'package:flutter/material.dart';
import 'package:libralink/landingPage.dart';
import 'package:libralink/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: LandingPage()
        home: SplashScreen(),
    );
  }
}
