import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/styles/color_styles.dart';

class ReusableTextFormField extends StatelessWidget {
  // final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  IconButton? suffixIcon;
  final bool obscureText;
  String? Function(String?)? validate;
  void Function(String)? onChange;
  TextEditingController? controller = TextEditingController();
  double? fieldElevation;
  Color? color;
  TextInputType? keyboardType;

  ReusableTextFormField({
    super.key,
    this.color,
    this.suffixIcon,
    // this.labelText,
    this.hintText,
    this.keyboardType,
    this.prefixIcon,
    this.validate,
    this.obscureText = false,
    this.onChange,
    this.controller,
    this.fieldElevation = 6,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChange,
      keyboardType: keyboardType,
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: ColorStyles.white),
      cursorColor: Colors.black,
      cursorWidth: 1.5,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        fillColor: ColorStyles.darkBrown,
        filled: true,
        errorStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Tajawal',
          color: ColorStyles.red,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0.r),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0.r),
        ),
        hoverColor: ColorStyles.red,
        prefixIconColor: ColorStyles.red,
        contentPadding:
            EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.w),
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: ColorStyles.white),
        prefixIcon: prefixIcon,
        focusColor: ColorStyles.brown,
        suffixIcon: suffixIcon,
        border: InputBorder.none,
      ),
      obscureText: obscureText,
      validator: validate,
    );
  }
}
