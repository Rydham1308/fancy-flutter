import 'package:fancy/firebase/firebase_auth_services.dart';
import 'package:fancy/screens/home/profile_screen/swipe_to_example.dart';
import 'package:fancy/screens/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/app_keys.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation _animation;

  // late Animation _resetAnimation;

  String later = 'U';

  List<String> accounts = ['R', 'K', 'H'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 150).animate(
      CurvedAnimation(
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
        parent: _controller,
      ),
    );
    // _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    // animationController;
  }

  bool isAnimated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: colorAnimation.value,
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return SwipeDetectorExample(
                      onSwipeUp: () {
                        print("swipe up");
                        later = 'R';
                        setState(() {
                          _controller.reverse(from: 1).whenComplete(
                            () {
                              _controller.reset();
                            },
                          );
                        });
                      },
                      onSwipeDown: () {
                        print("swipe down");
                        later = 'H';

                        setState(() {
                          _controller.forward().whenComplete(
                            () {
                              _controller.reset();
                            },
                          );
                        });
                      },
                      child: Transform.translate(
                        offset: Offset(0, _animation.value),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 60,
                            child: Text(
                              later,
                              style: const TextStyle(
                                  fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var sharedPref = await SharedPreferences.getInstance();
          sharedPref.setBool(AppKeys.keyLogin, false);
          FirebaseAuth.instance.signOut();
          Future.delayed(Duration.zero).then(
            // (value) => Navigator.pushNamedAndRemoveUntil(
            //     context, '/login', (Route<dynamic> route) => false),
            (value) {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => const LogIn(),
                    transitionsBuilder: (context, animation1, animation2, child) {
                      return FadeTransition(opacity: animation1, child: child);
                    },
                  ),
                  (route) => false);
            },
          );
        },
        elevation: 25,
        child: const Icon(
          Icons.logout,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
