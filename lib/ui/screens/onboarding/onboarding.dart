import 'package:earthquake/ui/component/indicator.dart';
import 'package:earthquake/ui/screens/home/home_screen.dart';
import 'package:earthquake/ui/utils/styles/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../component/custom_onBoarding_screen.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController pageController;
  int? pageIndex = 0;

  List onBoardingsTitle = [
    'Latest earthquakes in the world.',
    'View earthquakes on the map.',
    'Set up to 4 alerts'
  ];

  List onBoardingsSubtitle = [
    'Show you all recent earthquakes from around the global.',
    'Information can be filtered by region, magnitude and agency.',
    'On your phone as soon as the data is available from an official source'
  ];

  List onBoardingsImage = [
    'assets/images/earthquake1.png',
    'assets/images/earthquake22.png',
    'assets/images/earthquake3.png'
  ];

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    //GetAllEarthquakes();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.green,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: onBoardingsTitle.length,
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
                itemBuilder: (context, index) => CustomOnBoardingScreen(
                  title: onBoardingsTitle[index],
                  subtitle: onBoardingsSubtitle[index],
                  image: onBoardingsImage[index],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0.w),
              child: Row(
                children: [
                  ...List.generate(
                    3,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                      child: Indicator(
                        isActive: index == pageIndex,
                      ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.r))),
                      onPressed: () {
                        if (pageIndex! == 3 - 1) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        }
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease);
                      },
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward,
                          color: ColorStyles.green,
                          size: 30.r,
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
