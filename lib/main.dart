import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:libralink/Screens/Auth/login_screen.dart';
import 'package:libralink/firebase_api.dart';
import 'package:libralink/firebase_options.dart';
import 'package:libralink/home_screen.dart';
import 'package:libralink/Screens/Add_books.dart';
import 'package:libralink/Screens/Auth/login_screen.dart';
import 'package:libralink/Screens/notification.dart';
import 'package:libralink/duesScreen.dart';
import 'package:libralink/issued_book.dart';
import 'package:libralink/landingPage.dart';
import 'package:libralink/noDuesScreen.dart';
import 'package:libralink/profile.dart';
import 'package:libralink/routes/mapping.dart';

import 'Screens/Auth/signup_screen.dart';

// Instantiate navigatorKey
final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      routes: {
        "/": (context) => LandingPage(),
        MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.issuedBooksRoute: (context) => IssuedBookPage(),
        MyRoutes.pDuesRoute: (context) => DuesScreen(),
        MyRoutes.nDuesRoute: (context) => noDues(),
        MyRoutes.notifRoute: (context) => NotificationScreen(),
        MyRoutes.profileRoute: (context) => ProfilePage(),
        MyRoutes.signinRoute: (context) => LoginScreen(),
        MyRoutes.signupRoute: (context) => SignUpScreen(),
      },
    );
  }
}
