import 'package:earthquake/ui/utils/styles/color_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import '../../component/progress_dialpg.dart';
import '../../component/toast.dart';

class Details extends StatefulWidget {
   Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {


  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
      backgroundColor:  ColorStyles.green,
      appBar: AppBar(
        backgroundColor: ColorStyles.green,
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
        actions: [
          IconButton(onPressed: (){
            _showDialog(context);
          }, icon: const Icon(Icons.read_more,color: Colors.white,))
        ],
        title: Text('Earthquake', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, fontFamily: 'Tajawal', color: ColorStyles.brown),),
      ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 250.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CustomData(icon: 'clock.png', data: '7 Nov 2018', title: 'Time',),
                      SizedBox(width: 15.w,),
                      SizedBox(height: 50, width: 2,child: Container(color: Colors.white,)) ,
                      SizedBox(width: 15.w,),
                      const CustomData(icon: 'wave.png', data: '3.2 SR', title: 'Magnitude',),
                      SizedBox(width: 15.w,),
                      SizedBox(height: 50, width: 2,child: Container(color: Colors.white,)) ,
                      SizedBox(width: 15.w,),
                      const CustomData(icon: 'height.png', data: '10 Km', title: 'depth',),
                    ],
                  ),
                ),
                SizedBox(height: 9.h,),

                CustomListTile(title: 'Coordinate', data: '30.8025° E, 26.8206° N', icon: 'coordinate.png', scale: 15.sp,),

                CustomListTile(title: 'Location', data: 'Zürichberg, a wooded hill in District 7.', icon: 'placeholder.png', scale: 12.sp,),

                CustomListTile(title: 'Source', data: 'US', icon: 'source.png', scale:12.sp ,),


              ],
            ),
          ),
    ));
  }

  Future<void> _showDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorStyles.green,
          shadowColor: Colors.white12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0.r),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                content('What is an Earthquake?' , 'Earthquakes happen when there\'s a sudden release of energy in the Earth\'s crust, causing the ground to shake.'),
                SizedBox(height: 7.h,),
                content('Magnitude:' , 'Earthquakes are measured on a scale called magnitude. The bigger the number, the stronger the quake.'),
                SizedBox(height: 7.h,),
                content('Location Matters:' , 'Some places are more prone to earthquakes. Knowing your area\'s risk helps you prepare better.'),
                SizedBox(height: 7.h,),
                SizedBox(height: 2.h, child: Container(color: ColorStyles.white,)),
                SizedBox(height: 10.h,),
                Text('# Protecting Yourself During an Earthquake:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, fontFamily: 'Tajawal', color: ColorStyles.lightRed2),),
                SizedBox(height: 7.h,),
                content('Drop, Cover, and Hold On:' , 'Drop to the ground, take cover under a sturdy piece of furniture, and hold on until the shaking stops.'),
                SizedBox(height: 7.h,),
                content('Stay Indoors:' , 'If you\'re indoors during an earthquake, stay there. Avoid doorways; instead, take cover under a table or desk.'),
                SizedBox(height: 7.h,),
                content('Stay Away from Windows:' , 'Windows can break during an earthquake. Move away from them to avoid getting hurt.'),
                SizedBox(height: 7.h,),
                content('If Outside:' , 'Move to an open area away from buildings, trees, streetlights, and utility wires. Drop to the ground and cover your head.'),
                SizedBox(height: 7.h,),
                content('If Driving:' , 'Pull over to a safe spot away from overpasses, bridges, and buildings. Stay inside the vehicle until the shaking stops.'),
                SizedBox(height: 7.h,),
                SizedBox(
                    height: 2.h, child: Container(color: ColorStyles.white,)),
                SizedBox(height: 7.h,),
                Text('# Before an Earthquake:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, fontFamily: 'Tajawal',color: ColorStyles.lightRed2 ),),
                SizedBox(height: 10.h,),
                content('Secure Heavy Furniture:' , 'Anchor heavy furniture and appliances to the walls to prevent them from falling during an earthquake.'),
                SizedBox(height: 7.h,),
                content('Emergency Kit:' , 'Prepare an emergency kit with essentials like water, non-perishable food, flashlight, first aid supplies, and important documents.'),
                SizedBox(height: 7.h,),
                content('Family Plan:' , 'Have a family emergency plan. Know where to meet after the quake and how to contact each other.'),
                SizedBox(height: 7.h,),
                content('Practice Drills:' , 'Practice earthquake drills with your family or colleagues, so you know what to do when it happens.'),
                SizedBox(height: 7.h,),
                SizedBox(height: 2.h, child: Container(color: ColorStyles.white,)),
                SizedBox(height: 10.h,),
                Text('# After an Earthquake:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, fontFamily: 'Tajawal', color: ColorStyles.lightRed2),),
                SizedBox(height: 7.h,),
                content('Check for Injuries:' , 'Check yourself and others for injuries. Provide first aid if needed.'),
                SizedBox(height: 7.h,),
                content('Be Cautious of Aftershocks:' , 'Aftershocks may follow the main quake. Be ready for them and move to open areas away from damaged buildings.'),
                SizedBox(height: 7.h,),
                content('Listen for Information:' , 'Listen to emergency broadcasts for updates and information on evacuation if necessary.'),
                SizedBox(height: 7.h,),
                content('Inspect Your Surroundings:' , 'Check for hazards in your surroundings, like gas leaks or damaged electrical wires. Be cautious.'),
                SizedBox(height: 15.h,),
                Text('* Remember, the key is to stay calm, have a plan, and be prepared. Regular drills and simple safety measures can make a significant difference in protecting yourself and others during an earthquake.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp, fontFamily: 'Tajawal', color: ColorStyles.red),),

              ],
            ),
          ),
        );
      },
    );
  }

  Column content(String address,String response ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(address, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp, fontFamily: 'Tajawal', color: ColorStyles.lightRed2),),
                  SizedBox(height: 5.h,),
                  Text(response, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp, fontFamily: 'Tajawal', color: ColorStyles.white),),
                ],
              );
  }


}




class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key, required this.title, required this.data, required this.icon, required this.scale,
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
      ),),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/icons/$icon', scale: scale,),
            SizedBox(width: 10.h,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style:  TextStyle(fontFamily: 'Tajawal', fontSize: 14.sp, color: ColorStyles.grey, fontWeight: FontWeight.bold),maxLines: 1, overflow: TextOverflow.ellipsis, ),
              SizedBox(height: 2.h,),
                Text(data, style:  TextStyle(fontFamily: 'Tajawal', fontSize: 19.sp, color: ColorStyles.brown, fontWeight: FontWeight.bold), ),
                 SizedBox(height: 10.h,),
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
    super.key, required this.icon, required this.data, required this.title,
  });
  final String icon;
  final String data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/icons/$icon', scale: 11.sp,),
        SizedBox(height: 10.h),
        Text(data, style: TextStyle(fontFamily: 'Tajawal', fontSize: 20.sp, color: ColorStyles.brown, fontWeight: FontWeight.bold), ),
        Text(title, style: TextStyle(fontFamily: 'Tajawal', fontSize: 15.sp, color: Colors.white70, fontWeight: FontWeight.w900), ),
      ],
    );
  }
}
