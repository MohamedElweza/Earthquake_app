import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomOnBoardingScreen extends StatelessWidget {
  const CustomOnBoardingScreen({
    super.key, required this.title, required this.subtitle, required this.image,
  });

  final String title;
  final String subtitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50.h,),
          Text(title, style: TextStyle(fontSize: 45.sp, fontWeight: FontWeight.w800, fontFamily: 'Tajawal', color: Colors.white),),
          SizedBox(height: 5.h,),
          Text(subtitle, style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.normal, color: Colors.white),),
          SizedBox(height: 5.h,),
          SizedBox(width: 95.w,height: 40.h, child: ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)), backgroundColor: Colors.red, ), child: Text('Next', style:TextStyle(color: Colors.white, fontFamily: 'Tajawal',fontWeight: FontWeight.bold, fontSize: 20.sp) ),)),
          SizedBox(height: 30.h,),
          Image.asset(image),
        ],
      ),
    );
  }
}