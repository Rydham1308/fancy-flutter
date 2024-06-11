import 'package:fancy/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/app_keys.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  // late AnimationController animationController;
  // late Animation colorAnimation;

  @override
  void initState() {
    super.initState();
    // animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    // colorAnimation = ColorTween(begin: Colors.black26, end: Colors.white)
    //     // .animate(animationController)
    //     .animate(CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    //
    // animationController.addListener(() {
    //   setState(() {});
    // });
    // // animationController.repeat();
    // animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    super.dispose();
    // animationController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: colorAnimation.value,
      body: const SafeArea(
        child: Center(
          child: Column(
            children: [
              AnimatedDefaultTextStyle(
                curve: Curves.bounceIn,
                style: TextStyle(fontSize: 26,color: Colors.black),
                duration: Duration(seconds: 1),
                child: Text('UserName : ',style: TextStyle(color: Colors.brown),),
              ),
              Text('Email:'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var sharedPref = await SharedPreferences.getInstance();
          sharedPref.setBool(AppKeys.keyLogin, false);

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
