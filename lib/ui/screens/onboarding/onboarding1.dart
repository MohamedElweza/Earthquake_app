import 'package:earthquake/ui/utils/styles/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../component/custom_onBoarding_screen.dart';

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorStyles.background,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
          child: const CustomOnBoardingScreen(title: 'Latest earthquakes in the world.', subtitle: 'Show you all recent earthquakes from around the global.', image: 'assets/images/earthquake1.png',),
        ),
      ),
    );
  }
}

