import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:libralink/Screens/Auth/login_screen.dart';
import 'package:libralink/home_screen.dart';
import 'package:libralink/profile.dart';
import 'package:libralink/DB-models/user.dart' as model;
import '../../routes/mapping.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final cpasswordController = TextEditingController();
  final String allowedDomain = "nitp.ac.in";
  //signup user
  Future<void> _signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //checking the email and other signup credential
      if (userCredential.user != null && userCredential.user!.email != null) {
        if (userCredential.user!.email!.endsWith("@" + allowedDomain)) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()));
          String name = usernameController.text;

          showToast("$name Signed Up Successfully");
        } else {
          await userCredential.user!.delete();
          _showErrorDialog("Please use an email from $allowedDomain.");
        }
      }
      //add user to our database
      model.user user = model.user(
          username: usernameController.text,
          uid: userCredential.user!.uid,
          name: "",
          contact: "",
          roll: "",
          email: emailController.text,
          IdURL: "",
          profileURL: "");

      await _firestore
          .collection("user")
          .doc(userCredential.user!.uid)
          .set(user.tojson());
    } catch (e) {
      _showErrorDialog("Error during sign-up: $e");
    }
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // Future<void> _signUp() async {
  //   try {
  //     UserCredential userCredential =
  //         await _auth.createUserWithEmailAndPassword(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );
  //     print("User registered: ${userCredential.user!.email}");
  //     Navigator.pushNamed(context, MyRoutes.homeRoute);
  //     showToast("User is successfully signed up");
  //     // You can navigate to another screen or perform additional actions after registration.
  //   } catch (e) {
  //     print("Error during registration: $e");
  //     showToast("Error during registration : $e");
  //     // Handle registration errors here (e.g., display an error message).
  //   }
  // }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
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
                                controller: usernameController,
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
                                _signUp();
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
