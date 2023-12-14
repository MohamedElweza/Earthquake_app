import 'dart:async';
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
        curve: const Interval(0.5, 1.0), // Slide in from the left during the second half (2 seconds)
      ),
    );

    // Start the animation after the widget is built
    _animationController.forward();

    // Navigate to the next screen after the animation completes
    Timer(const Duration(milliseconds: 4000), () {
      Navigator.of(context).pushReplacement(
        PageTransition(
          childCurrent: const SplashScreen(),
          type: PageTransitionType.fade,
          child: const HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.background,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png', // Replace with your splash image path
                width: 350.0.w,
                height: 200.h,
              ),
              SlideTransition(
                position: _slideAnimation,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 3),
                  child: Text(
                    'MAGNAQUAKE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50.sp,
                      fontFamily: 'SplashName',
                      color: ColorStyles.white,
                    ),
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
