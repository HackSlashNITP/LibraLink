import 'package:flutter/material.dart';
import 'package:libralink/Screens/Auth/login_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LoginScreen(),
        // body: Text('Hello!'),
      ),
    );
  }
}
