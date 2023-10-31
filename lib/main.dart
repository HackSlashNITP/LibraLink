import 'package:flutter/material.dart';
import 'package:libralink/Screens/Auth/notification.dart';
import 'package:libralink/landingPage.dart';

import 'Screens/Auth/login_screen.dart';
import 'Screens/Auth/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}
