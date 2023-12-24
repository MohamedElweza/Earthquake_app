import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:magnaquake/data/api/models/data.dart';
import '../../component/map.dart';
import '../../component/progress_dialpg.dart';
import '../../component/toast.dart';
import '../../utils/styles/color_styles.dart';

class Details extends StatefulWidget {
  const Details(this.details, {super.key});
  final Data? details;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late String id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.details!.id!;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorStyles.background,
      appBar: AppBar(
        backgroundColor: ColorStyles.background,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: ColorStyles.white,
            )),
        title: Text(
          'Details',
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal',
              color: ColorStyles.brown),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                height: 300.h,
                child: MapScreen(
                    latitude: double.parse('${widget.details!.latitude}'),
                    longitude: double.parse('${widget.details!.longitude}')),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomData(
                    icon: 'clock.png',
                    data: ' ${widget.details!.date}',
                    title: 'Time',
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  SizedBox(
                      height: 50,
                      width: 2,
                      child: Container(
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 15.w,
                  ),
                  CustomData(
                    icon: 'wave.png',
                    data:
                        ' ${widget.details!.magnitude} ${widget.details!.magType}',
                    title: 'Magnitude',
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  SizedBox(
                      height: 50,
                      width: 2,
                      child: Container(
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 15.w,
                  ),
                  CustomData(
                    icon: 'height.png',
                    data: '     ${widget.details!.depth}',
                    title: 'depth',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 9.h,
            ),
            CustomDetailsListTile(
              title: 'Coordinate',
              data:
                  '${widget.details!.latitude} °N, ${widget.details!.longitude} °E',
              icon: 'coordinate.png',
              scale: 15.sp,
            ),
            CustomDetailsListTile(
              title: 'Location',
              data: '${widget.details!.location}',
              icon: 'placeholder.png',
              scale: 12.sp,
            ),
            CustomDetailsListTile(
              title: 'Source',
              data: ' ${widget.details!.country}',
              icon: 'source.png',
              scale: 12.sp,
            ),
          ],
        ),
      ),
    ));
  }

}

class CustomDetailsListTile extends StatelessWidget {
  const CustomDetailsListTile({
    super.key,
    required this.title,
    required this.data,
    required this.icon,
    required this.scale,
  });

  final String title;
  final String data;
  final String icon;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.0.h),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ColorStyles.grey, // specify border color
              width: 1.0.w, // specify border width
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/icons/$icon',
              scale: scale,
            ),
            SizedBox(
              width: 10.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 14.sp,
                      color: ColorStyles.grey,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  data,
                  style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 19.sp,
                      color: ColorStyles.brown,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomData extends StatelessWidget {
  const CustomData({
    super.key,
    required this.icon,
    required this.data,
    required this.title,
  });
  final String icon;
  final String data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          'assets/icons/$icon',
          scale: 11.sp,
        ),
        SizedBox(height: 10.h),
        SizedBox(
            width: 90,
            child: Text(
              data,
              maxLines: 1,
              style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 20.sp,
                  color: ColorStyles.brown,
                  fontWeight: FontWeight.bold),
            )),
        Text(
          title,
          style: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 15.sp,
              color: Colors.white70,
              fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}
