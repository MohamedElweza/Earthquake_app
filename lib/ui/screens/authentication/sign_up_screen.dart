import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnaquake/ui/screens/authentication/login_screen.dart';
import 'package:magnaquake/ui/screens/onboarding/onboarding.dart';
import '../../component/Reusable_TextForm_Field_screen.dart';
import '../../utils/styles/color_styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool obscureText = true;
  bool? isLoading = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorStyles.white,
        appBar: AppBar(
            backgroundColor: ColorStyles.background,
            centerTitle: true,
            elevation: 0,
            title: Text(
              'Sign In ',
              style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                  color: ColorStyles.brown),
            )),
        body: SingleChildScrollView(
          reverse: true,
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(20.0.w),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    ReusableTextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.emailAddress,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Name';
                        }
                        return null;
                      },
                      color: ColorStyles.brown,
                      prefixIcon: Icon(Icons.person, color: ColorStyles.red),
                      hintText: " Name",
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    ReusableTextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Email';
                        } else if (!(value.toString().contains(
                              "@",
                            ))) {
                          return 'Enter correct Email';
                        }
                        return null;
                      },
                      color: ColorStyles.brown,
                      prefixIcon: Icon(Icons.email, color: ColorStyles.red),
                      hintText: "Email ",
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    ReusableTextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Phone Number';
                        } else if (value.length <= 10) {
                          return 'Enter Correct Phone Number';
                        }
                        return null;
                      },
                      color: ColorStyles.brown,
                      prefixIcon: Icon(Icons.phone, color: ColorStyles.red),
                      hintText: "Phone Number",
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    ReusableTextFormField(
                      controller: passwordController,
                      obscureText: obscureText,
                      keyboardType: TextInputType.visiblePassword,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                      color: ColorStyles.brown,
                      hintText: "Password",
                      prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: obscureText
                            ? Icon(
                                Icons.remove_red_eye_outlined,
                                size: 30.r,
                                color: ColorStyles.red,
                              )
                            : Icon(
                                Icons.visibility_off_outlined,
                                size: 30.r,
                                color: ColorStyles.red,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    ReusableTextFormField(
                      controller: confirmPasswordController,
                      obscureText: obscureText,
                      keyboardType: TextInputType.visiblePassword,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return ' Confirm The Password';
                        }
                        return null;
                      },
                      color: ColorStyles.brown,
                      hintText: "Confirm Password  ",
                      prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: obscureText
                            ? Icon(
                                Icons.remove_red_eye_outlined,
                                size: 30.r,
                                color: ColorStyles.red,
                              )
                            : Icon(
                                Icons.visibility_off_outlined,
                                size: 30.r,
                                color: ColorStyles.red,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0.r),
                        ),
                        backgroundColor: ColorStyles.brown,
                        minimumSize: Size.fromHeight(50.h),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OnBoarding(),
                        ));
                      },
                      child: Text(
                        ' Sign up ',
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                          color: ColorStyles.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LogInScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  color: ColorStyles.brown,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Tajawal',
                                  fontSize: 19.sp),
                            ),
                          ),
                          Text(
                            "Do you have account?",
                            style: TextStyle(
                                fontFamily: 'Tajawal',
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 19.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
