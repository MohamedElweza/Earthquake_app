
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:page_transition/page_transition.dart';

import '../../utils/styles/color_styles.dart';
import '../details/details.dart';

// import '../../component/progress_dialpg.dart';
// import '../../component/toast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List countryName = ['USA', 'Italy', 'France', 'Egypt'];

  final List cityName = ['USA', 'Italy', 'France', 'Egypt'];

  final scrollController = ScrollController();

  // String locationAddress = 'حدد الموقع';
  //
  // double latitude = 21.3891;
  //
  // double longitude = 39.8579;
  //
  // Future getPosition() async {
  //   bool services = await Geolocator.isLocationServiceEnabled();
  //   if (services == false) {
  //     CustomToast.lightToast(
  //         msg: "يرجى تفعيل خدمة الموقع", gravity: ToastGravity.CENTER);
  //   }
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.always ||
  //         permission == LocationPermission.whileInUse) {
  //       await getLatAndLng().then((value) {
  //         latitude = value.latitude;
  //         longitude = value.longitude;
  //       });
  //     }
  //   }
  // }
  //
  // Future<Position> getLatAndLng() async {
  //   return await Geolocator.getCurrentPosition();
  // }

  @override
  Widget build(BuildContext context) {
    String flag = generateCountryFlag();
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorStyles.background,
        appBar: AppBar(
          backgroundColor: ColorStyles.background ,
          centerTitle: true,
          elevation: 0,
          leading: Image.asset('assets/images/logo.png', scale: 5,),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
          title: Text(
            'Earthquake',
            style: TextStyle(
                fontSize: 26.sp,
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
                SizedBox(
                  height: 250.h,
                  // child: InkWell(
                  //   child: Text(
                  //     locationAddress,
                  //     style: TextStyle(color: ColorStyles.white),
                  //   ),
                  //   onTap: () async {
                  //     try {
                  //       {
                  //         bool services =
                  //         await Geolocator.isLocationServiceEnabled();
                  //         if (services == false) {
                  //           CustomToast.lightToast(
                  //               msg: "يرجى تفعيل خدمة الموقع",
                  //               gravity: ToastGravity.CENTER);
                  //         } else {
                  //           LocationPermission permission =
                  //           await Geolocator.checkPermission();
                  //           if (permission == LocationPermission.denied ||
                  //               permission ==
                  //                   LocationPermission.deniedForever) {
                  //             permission =
                  //             await Geolocator.requestPermission();
                  //           }
                  //           if (permission == LocationPermission.always ||
                  //               permission == LocationPermission.whileInUse) {
                  //             if (context.mounted) {
                  //               ShowProgressIndicator(context);
                  //             }
                  //             await getLatAndLng().then((value) {
                  //               Navigator.pop(context);
                  //               latitude = value.latitude;
                  //               longitude = value.longitude;
                  //               _showModal(context);
                  //             });
                  //           }
                  //         }
                  //       }
                  //     } catch(e){
                  //       if (kDebugMode) {
                  //         print(e.toString());
                  //       }
                  //     }
                  //   },
                  // ),
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
                    itemCount: countryName.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                              PageTransition(
                                childCurrent: HomeScreen(),
                                type: PageTransitionType.bottomToTop,
                                alignment: Alignment.topCenter,
                                child: Details(),
                              ),);
                          },
                          child: Container(
                              height: 65.h,
                              decoration: BoxDecoration(
                                  color: ColorStyles.grey,
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
  // void _showModal(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           child: Container(
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(20.r)
  //             ),
  //             height: MediaQuery.of(context).size.height - 120,
  //             child: OpenStreetMapSearchAndPick(
  //               hintText: 'الموقع',
  //               center: LatLong(latitude, longitude),
  //               buttonColor: ColorStyles.green,
  //               locationPinIconColor: ColorStyles.green,
  //               buttonText: 'تـأكيد الموقع',
  //               locationPinTextStyle:
  //               const TextStyle(color: ColorStyles.brown),
  //               locationPinText: 'الموقع',
  //               onPicked: (pickedData) {
  //                 Navigator.pop(context);
  //                 setState(() {
  //                   List data = pickedData.address.values.toList();
  //                   locationAddress = data.toString();
  //                   latitude = pickedData.latLong.latitude;
  //                   longitude = pickedData.latLong.longitude;
  //                 });
  //               },
  //             ),
  //           ),
  //         );
  //       });
  // }
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
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 5.0.h),
      child: Row(

        children: [
          Text(flag, style: const TextStyle(fontSize: 25),),
          SizedBox(
            width: 8.w,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                countryName,
                style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 20.sp,
                    color: ColorStyles.darkBrown,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                cityName,
                style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 15.sp,
                    color: ColorStyles.darkBrown),
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$scale',
                style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 20.sp,
                    color: ColorStyles.red,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                time,
                style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorStyles.darkBrown),
              ),
            ],
          ),
        ],
      ),
    );

  }
}
