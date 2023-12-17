import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnaquake/ui/screens/details/details.dart';
import 'package:magnaquake/ui/screens/home/home_screen.dart';
import 'package:magnaquake/ui/screens/onboarding/onboarding.dart';
import 'package:magnaquake/ui/screens/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:  Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          builder: (context, child){
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0 ),
                child: child!
            );
          },
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      },
    );
  }
}
