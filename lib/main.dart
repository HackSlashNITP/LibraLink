import 'package:flutter/material.dart';
import 'package:libralink/Screens/Auth/login_screen.dart';
import 'package:libralink/home_screen.dart';
import 'package:libralink/landingPage.dart';
import 'noDuesScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
