import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnaquake/ui/screens/home/home_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../utils/styles/color_styles.dart';
import '../onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5), // Fade in during the first half (2 seconds)
      ),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(-1.5.w, 0.0.h), end: Offset(0.0.w, 0.0.h)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0),
      ),
    );

    _animationController.forward();

    Timer(const Duration(milliseconds: 4500), () {
      Navigator.of(context).pushReplacement(
        PageTransition(
          childCurrent: const SplashScreen(),
          type: PageTransitionType.fade,
          child: const OnBoarding(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo5.png', // Replace with your splash image path
                width: 350.0.w,
                height: 200.h,
              ),
              SlideTransition(
                position: _slideAnimation,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 3),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        'MAGNAQUAKE',
                        textStyle: TextStyle(
                          fontSize: 50.0.sp,
                          fontFamily: "SplashName",
                          fontWeight: FontWeight.bold,
                        ),
                        colors: [
                          ColorStyles.red,
                          ColorStyles.brown,
                          Colors.deepOrangeAccent,
                          ColorStyles.background,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
