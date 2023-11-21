import 'package:flutter/material.dart';
import 'package:libralink/Screens/Auth/login_screen.dart';

import '../../routes/mapping.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final cpasswordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    cpasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Container(
              // width: 400,
              // height: 790,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
            ),
            Container(
                // height: 320,
                // width: 410,
                height: MediaQuery.of(context).size.height * .32,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * .65,
                    bottom: MediaQuery.of(context).size.width * .35,
                    top: MediaQuery.of(context).size.width * .1,
                  ),
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                )),
            Positioned(
              bottom: 0,
              // left: 0,
              // right: 0,
              child: Container(
                // height: 570,
                // width: 450,
                height: MediaQuery.of(context).size.height * .73,
                width: MediaQuery.of(context).size.width,
                child: Card(
                    margin: EdgeInsets.zero,
                    surfaceTintColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45),
                            topRight: Radius.circular(45))),
                    child: SizedBox(
                      width: double.infinity,
                      height: 500,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Text(
                              'CREATE ACCOUNT',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(children: [
                            SizedBox(
                              width: 320,
                              height: 52,
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: ' Username ',
                                  labelStyle:
                                      TextStyle(color: Colors.grey.shade600),

                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black87),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFF0A043C),
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  // border: OutlineInputBorder(
                                  //     borderRadius: BorderRadius.circular(30)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              width: 320,
                              height: 52,
                              child: TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: 'Nitp Official email ',
                                  labelStyle:
                                      TextStyle(color: Colors.grey.shade600),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black87),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFF0A043C),
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              width: 320,
                              height: 52,
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle:
                                      TextStyle(color: Colors.grey.shade600),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black87),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFF0A043C),
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              width: 320,
                              height: 52,
                              child: TextField(
                                controller: cpasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: ' Confirm Password ',
                                  labelStyle:
                                      TextStyle(color: Colors.grey.shade600),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black87),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFF0A043C),
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ]),
                          SizedBox(
                            width: 320,
                            height: 52,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E293B),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, MyRoutes.homeRoute);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10.0),
                                    color: Colors.black,
                                    height: 1.0,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const LoginScreen()));
                                  },
                                  child: const Text(
                                    'Sign in',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      left: 10.0,
                                    ),
                                    color: Colors.black,
                                    height: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
