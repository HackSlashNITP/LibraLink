import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/backgroundImg.png',
              fit: BoxFit.fill,
            ),
          ),
          const Positioned(
              top: 82,
              left: 38,
              child: Text('HOLA!', style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),)),
          const Positioned(
              top: 158,
              left: 38,
              child: Text('We are here to make your\nlife easy ', style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),)),
          Positioned(
            top: 521, // Set the Y coordinate here
            left: 297, // Set the X coordinate here
            child: Image.asset(
              'assets/images/logo.png',
              height: 58,
              width: 67,
            ),
          ),
          Positioned(
            top: 632, // Set the Y coordinate for the button
            left: 70, // Set the X coordinate for the button
            child: Container(
              width: 285,
              height: 52,
              decoration: BoxDecoration(
                color: Color(0xFF1E293B),
                border: Border.all(color: Colors.white70),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Add your onPressed action here
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: const Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 701, // Set the Y coordinate for the button
            left: 70, // Set the X coordinate for the button
            child: Container(
              width: 285,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white70),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Add your onPressed action here
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: const Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color(0xFF1E293B),
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
