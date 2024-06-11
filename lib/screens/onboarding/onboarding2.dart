import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import '../login/welcomescreen.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //bg images
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/onboarding2i.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/onboarding2ii.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // filter
          Column(
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

          // btn
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
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
                  child: const Text(
                    'Start Shopping',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // line and dots
          Container(
            margin: const EdgeInsets.only(top: 35,left: 25),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    CupertinoButton(
                      onPressed: null,
                      minSize: double.minPositive,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.horizontal_rule_rounded,color: Colors.white,size: 55,),
                    ),
                    CupertinoButton(
                      onPressed: null,
                      minSize: double.minPositive,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.more_horiz_rounded,color: Colors.white,size: 45,),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Upper Text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 220),
                child: const Text(
                  'FANCY',
                  style: TextStyle(
                    fontFamily: 'Raleway-Bold',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    fontSize: 55,
                    color: Colors.white70,
                      // fromARGB(213, 255, 183, 206),
                  ),
                ),
              ),
            ],
          ),

          //Lower Text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 550),
                child: const Text(
                  'Shop the \nmost modern \nessentials.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Raleway-Bold',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
