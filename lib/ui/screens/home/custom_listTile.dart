import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/styles/color_styles.dart';
class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
        required this.countryName,
        required this.cityName,
        required this.flag,
        required this.scale,
        S});

  final String countryName;
  final String cityName;
  final String flag;
  final String scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 5.0.h),
      child: Row(
        children: [
          Text(
            flag,
            style: TextStyle(fontSize: 25.sp),
          ),
          SizedBox(
            width: 15.w,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                countryName == "" ? 'United States of America' : countryName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 15.sp,
                    color: ColorStyles.darkBrown,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                  cityName == "" ? 'Texas' : cityName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: true,
                style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 15.sp,
                    color: ColorStyles.darkBrown),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 20.0.w),
            child: Text(
              scale,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 15.sp,
                  color: ColorStyles.red,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}