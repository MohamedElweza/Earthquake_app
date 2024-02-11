import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnaquake/data/api/models/main_data.dart';
import 'package:magnaquake/data/api/request/api_request.dart';
import 'package:magnaquake/ui/screens/chatgpt/chatgpt.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import '../../../data/api/models/data.dart';
import '../../utils/styles/color_styles.dart';
import '../ai/ai.dart';
import '../details/details.dart';
import 'custom_listTile.dart';
import 'generate_flag.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String title = 'Click to Predict You Data';
  static ScrollController scrollController = ScrollController();

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: ColorStyles.background,
      centerTitle: true,
      elevation: 0,
      leading: Image.asset(
        'assets/images/logo3.png',
        height: 25.h,
        width: 25.w,
      ),
      actions: [
        GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ChatGPT()));
            },
            child: Image.asset('assets/images/chatgpt.png')),
      ],
      title: Text(
        'Earthquake',
        style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Tajawal',
            color: ColorStyles.brown),
      ),
    );
  }

  Widget buildShimmerBody() {
    return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Colors.red,
                            ColorStyles.brown,
                            ColorStyles.darkBrown
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15.0.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Image.asset(
                            'assets/images/earthquake.png',
                            height: 100.h,
                            width: 100.w,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          AnimatedTextKit(
                            animatedTexts: [
                              ColorizeAnimatedText(
                                'Click to predict.',
                                textStyle: TextStyle(
                                  fontSize: 32.0.sp,
                                  fontFamily: "Tajawal",
                                  fontWeight: FontWeight.bold,
                                ),
                                colors: [
                                  ColorStyles.grey,
                                  ColorStyles.white,
                                  Colors.deepOrangeAccent,
                                ],
                              ),
                            ],
                            onTap: () {},
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    ListView.builder(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: GestureDetector(
                              child: Container(
                                  height: 65.h,
                                  decoration: BoxDecoration(
                                      color: ColorStyles.grey,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: const ListTile()),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ));

  }

  Widget detailsBody(model) {
    return SingleChildScrollView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.h,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Colors.red,
                    ColorStyles.brown,
                    ColorStyles.darkBrown
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15.0.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Image.asset(
                    'assets/images/earthquake.png',
                    height: 100.h,
                    width: 100.w,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        'Click to predict',
                        textStyle: TextStyle(
                          fontSize: 32.0.sp,
                          fontFamily: "Tajawal",
                          fontWeight: FontWeight.bold,
                        ),
                        colors: [
                          ColorStyles.grey,
                          ColorStyles.white,
                          Colors.deepOrangeAccent,
                        ],
                      ),
                    ],
                    onTap: () {
                      Navigator.of(context).push(PageTransition(
                          child: const AiScreen(),
                          childCurrent: const HomeScreen(),
                          type: PageTransitionType.topToBottom));
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              'Recent\nEarthquakes',
              style: TextStyle(
                  fontSize: 35.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                  color: ColorStyles.brown),
            ),
            ListView.builder(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: model.data?.length,
                itemBuilder: (context, index) {
                  Data details = model.data![index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            childCurrent: const HomeScreen(),
                            type: PageTransitionType.bottomToTop,
                            alignment: Alignment.topCenter,
                            child: Details(details),
                          ),
                        );
                      },
                      child: Container(
                          height: 70.h,
                          decoration: BoxDecoration(
                              color: ColorStyles.lightRed,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: CustomListTile(
                            countryName: model.data![index].country.toString(),
                            cityName: model.data![index].city.toString(),
                            scale: model.data![index].magnitude.toString(),
                            flag: generateCountryFlag(),
                          )),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorStyles.background,
        appBar: buildAppBar(),
        body: FutureBuilder<Autogenerated>(
          future: EarthquakeRequests.GetAllEarthquakes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildShimmerBody();
            } else if (snapshot.hasData) {
              return detailsBody(snapshot.data!,);
            } else {
              return const Center(child: Text('There is an error. Try again!!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),));
            }
          },
        ),
      ),
    );
  }
}
