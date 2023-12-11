// ignore_for_file: dead_code

import 'package:earthquake/ui/screens/details/details.dart';
import 'package:earthquake/ui/utils/styles/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  List countryName = ['USA', 'Italy', 'France', 'Egypt'];
  List cityName = ['USA', 'Italy', 'France', 'Egypt'];
  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    String flag = generateCountryFlag();
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorStyles.green,
        appBar: AppBar(
          backgroundColor: ColorStyles.green,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
              )),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
          title: Text(
            'Earthquake',
            style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal',
                color: ColorStyles.brown),
          ),
        ),
        body: SingleChildScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(

                    child: Text(
                      'Recent  earthquakes',
                      style: TextStyle(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Tajawal',
                          color: ColorStyles.white),
                    )),
                SizedBox(
                  height: 250.h,
                ),
                ListView.builder(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: countryName.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                              PageTransition(
                                childCurrent: HomeScreen(),
                                type: PageTransitionType.bottomToTop,
                                alignment: Alignment.topCenter,
                                child: const Details(),
                              ),);
                          },
                          child: Container(
                              height: 65.h,
                              decoration: BoxDecoration(
                                  color: ColorStyles.brown,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: CustomListTile(
                                countryName: countryName[index],
                                cityName: cityName[index],
                                time: 'Two hours ago',
                                scale: 3.1,
                                flag: flag,
                              )),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String generateCountryFlag() {
    String countryCode = 'eg';

    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return flag;
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.countryName,
      required this.cityName,
      required this.flag,
      required this.time,
      required this.scale,
      S});

  final String countryName;
  final String cityName;
  final String flag;
  final String time;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(flag),
          SizedBox(
            width: 8.w,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                countryName,
                style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 20.sp,
                    color: ColorStyles.background,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                cityName,
                style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 15.sp,
                    color: ColorStyles.red),
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$scale',
                style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 20.sp,
                    color: ColorStyles.background,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                time,
                style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorStyles.background),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
