import 'package:flutter/material.dart';
import 'package:libralink/routes/mapping.dart';

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
          Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
            left: MediaQuery.of(context).size.width * 0.1,
            child: Text(
              'HOLA!',
              style: TextStyle(
                letterSpacing: 2.0,
                fontSize: 0.13 * MediaQuery.of(context).size.width,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.16,
            left: MediaQuery.of(context).size.width * 0.1,
            child: Text(
              'We are here to make your\nlife easy ',
              style: TextStyle(
                fontSize: 0.043 * MediaQuery.of(context).size.width,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.62,
            left: MediaQuery.of(context).size.width * 0.57,
            child: Image.asset(
              'assets/images/logo.png',
              height: 0.13 * MediaQuery.of(context).size.width,
              width: 0.15 * MediaQuery.of(context).size.width,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.74,
            left: MediaQuery.of(context).size.width * 0.16,
            child: Container(
              width: 0.70 * MediaQuery.of(context).size.width,
              height: 0.07 * MediaQuery.of(context).size.height,
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
                    Navigator.pushNamed(context, MyRoutes.signinRoute);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 0.05 * MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.83,
            left: MediaQuery.of(context).size.width * 0.16,
            child: Container(
              width: 0.70 * MediaQuery.of(context).size.width,
              height: 0.07 * MediaQuery.of(context).size.height,
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
                    Navigator.pushNamed(context, MyRoutes.signupRoute);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color(0xFF1E293B),
                        fontSize: 0.05 * MediaQuery.of(context).size.width,
                        fontWeight: FontWeight.w600,
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
