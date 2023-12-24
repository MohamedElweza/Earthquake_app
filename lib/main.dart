import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnaquake/ui/screens/details/details.dart';
import 'package:magnaquake/ui/screens/home/home_screen.dart';
import 'package:magnaquake/ui/screens/onboarding/onboarding.dart';
import 'package:magnaquake/ui/screens/splash/splash.dart';
import 'package:provider/provider.dart';

import 'controllers/providers.dart';

void main() {
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => HomeProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => MagnitudeTypesDropdownState(),
      ),
      ChangeNotifierProvider(
        create: (context) => MagnitudeSourcesDropdownState(),
      ),
      ChangeNotifierProvider(
        create: (context) => LocationProvider(),
      ),
      ],
    child: const MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:  const Size(390, 844),
    builder: (context, child) {
      return MaterialApp(
        builder: (context, child) {
          return MediaQuery(data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.0)),
              child: child!);
        },
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      );
    }
    );
  }
}
