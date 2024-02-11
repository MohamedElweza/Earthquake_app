import 'package:magnaquake/ui/screens/authentication/sign_up_screen.dart';
import 'package:magnaquake/ui/screens/onboarding/onboarding.dart';
import '../../component/Reusable_TextForm_Field_screen.dart';
import '../../utils/styles/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogInScreen extends StatefulWidget {
  @override
  State<LogInScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LogInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorStyles.background,
        appBar: AppBar(
          backgroundColor: ColorStyles.background,
          centerTitle: true,
          elevation: 0,
           leading: Image.asset(
            'assets/images/logo3.png',
            height: 25.h,
            width: 25.w,
          ),
          title: Text(
            'Sign In ',
            style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal',
                color: ColorStyles.brown),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(20.0.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      ReusableTextFormField(
                        onChange: (value) {
                          formKey.currentState!.validate();
                        },
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
                        hintText: " Email ",
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      ReusableTextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscureText,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter password';
                          }
                          return null;
                        },
                        onChange: (value) {
                          formKey.currentState!.validate();
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
                          ' Confirm',
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp,
                            color: ColorStyles.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ));
                            },
                            child: Text(
                              "Don't have account?",
                              style: TextStyle(
                                  color: ColorStyles.brown,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Tajawal',
                                  fontSize: 19.sp),
                            ),
                          ),
                          Text(
                            'Forget password?',
                            style: TextStyle(
                                fontFamily: 'Tajawal',
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 19.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
