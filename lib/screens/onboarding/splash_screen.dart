import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_keys.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void whereToGO() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(AppKeys.keyLogin);
    var isVisited = sharedPref.getBool(AppKeys.obKey);

    Timer(const Duration(milliseconds:1000), () {
      if (isLoggedIn != null || isVisited != null) {
        if (isLoggedIn ?? false) {
          Navigator.popAndPushNamed(context, '/home');
        } else {
          Navigator.popAndPushNamed(context, '/login');
        }
      } else {
        Navigator.popAndPushNamed(context, '/onboarding');
      }
    });
  }
@override
  void initState() {
    whereToGO();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // bg image && two partitions
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/page.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.grey.shade700.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // logo
          Container(
            margin: const EdgeInsets.only(top: 65, left: 25),
            child: const Text(
              'FANCY',
              style: TextStyle(
                  fontFamily: 'Raleway-Bold',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  fontSize: 35,
                  color: Colors.white70
                // fromARGB(255, 185, 153, 137)
              ),
            ),
          ),

          // Text
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(text: 'Shop the \nmost modern \nessentials.\n', style: TextStyle(
                              fontFamily: 'Raleway-Bold',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0,
                              fontSize: 45,
                              color: Colors.white,
                            ),),
                            WidgetSpan(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                child: Icon(Icons.arrow_forward_sharp,color: Colors.white,
                                  size: 40,),
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }
}
