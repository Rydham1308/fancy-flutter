import 'onboarding1.dart';
import 'package:flutter/material.dart';

import 'onboarding2.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  // final controller = PageController();
  //
  // @override
  // void dispose() {
  //   controller.dispose();
  //
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          OnBoarding1(),
          OnBoarding2(),
        ],
      ),
    );
  }
}
