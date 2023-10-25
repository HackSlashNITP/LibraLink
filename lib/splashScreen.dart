import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF0F172A),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 131.29,
                  width: 103.0,
                ),
              ),
              SizedBox(height: 38,),
              const Text('LIBRA LINK', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.white,
              letterSpacing: 1.8, wordSpacing: 2.5),)
            ],
          ),
        ),
      ),
    );
  }
}
