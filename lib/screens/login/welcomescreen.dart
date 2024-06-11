import 'package:fancy/constants/app_keys.dart';
import 'package:fancy/screens/login/signup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

import 'login.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Future<void> isObWatched() async {
    final sp = await SharedPreferences.getInstance();
    sp.setBool(AppKeys.obKey, true);
    sp.setBool(AppKeys.keyLogin, false);
  }

  @override
  void initState() {
    isObWatched();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // bg
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/welcomescreen.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.black54.withOpacity(0.35),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          //Sign In btn
          Container(
            margin: const EdgeInsets.only(top: 60, left: 270),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LogIn(),
                  ),
                );
              },
              child: const Text(
                'Log In',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Raleway',
                  fontSize: 18,
                ),
              ),
            ),
          ),

          // logo and text
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'FANCY',
                  style: TextStyle(
                    fontFamily: 'Raleway-Bold',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    fontSize: 75,
                    color: Colors.white70,
                    //fromARGB(200, 65, 211, 245)
                  ),
                ),
                Text(
                  'A Fashion Shopping App',
                  style: TextStyle(
                    fontFamily: 'Raleway-Bold',
                    fontSize: 15,
                    color: Color.fromARGB(216, 255, 255, 255),
                  ),
                ),
              ],
            ),
          ),

          // Sign Up buttons
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // foregroundColor: Colors.white70,
                      // animationDuration: const Duration(milliseconds: 1000),
                      backgroundColor: Colors.white,
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: const Size(250, 50),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUp(),
                        ),
                      );
                      // Navigator.pushReplacement(
                      //   context,
                      //   PageRouteBuilder(
                      //     pageBuilder: (context, animation1, animation2) => const WelcomeScreen(),
                      //     transitionDuration: const Duration(seconds: 0),
                      //   ),
                      // );
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.email,
                          size: 18,
                        ),
                        Text(
                          '  Sign Up with Email',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.grey,
                      animationDuration: const Duration(milliseconds: 1000),
                      backgroundColor: Colors.grey.shade900,
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: const Size(250, 50),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const WelcomeScreen(),
                      //   ),
                      // );
                      // Navigator.pushReplacement(
                      //   context,
                      //   PageRouteBuilder(
                      //     pageBuilder: (context, animation1, animation2) => const WelcomeScreen(),
                      //     transitionDuration: const Duration(seconds: 0),
                      //   ),
                      // );
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.facebook,
                          size: 18,
                          color: Colors.white,
                        ),
                        Text(
                          '  Continue with Facebook',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
