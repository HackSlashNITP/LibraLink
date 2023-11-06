import 'package:flutter/material.dart';
import 'package:libralink/Screens/Add_books.dart';
import 'package:libralink/Screens/Auth/login_screen.dart';
import 'package:libralink/Screens/notification.dart';
import 'package:libralink/duesScreen.dart';
import 'package:libralink/landingPage.dart';
import 'package:libralink/noDuesScreen.dart';
import 'package:libralink/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}
