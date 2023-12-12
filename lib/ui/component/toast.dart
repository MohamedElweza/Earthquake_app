import 'package:earthquake/ui/utils/styles/color_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static darkToast({
    required String msg,
    ToastGravity? gravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorStyles.green,
      textColor: ColorStyles.brown,
      fontSize: 16.0.sp,
    );
  }

  static lightToast({
    required String msg,
    ToastGravity? gravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorStyles.green,
      textColor: ColorStyles.brown,
      fontSize: 16.0.sp,
    );
  }
}