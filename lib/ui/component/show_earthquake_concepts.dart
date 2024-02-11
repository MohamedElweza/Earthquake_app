import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/styles/color_styles.dart';

class ShowEarthquakeConcepts{

  static Future<void> earthquakeConcepts(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorStyles.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0.r),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                content('What is an Earthquake?',
                    'Earthquakes happen when there\'s a sudden release of energy in the Earth\'s crust, causing the ground to shake.'),
                SizedBox(
                  height: 7.h,
                ),
                content('Magnitude:',
                    'Earthquakes are measured on a scale called magnitude. The bigger the number, the stronger the quake.'),
                SizedBox(
                  height: 7.h,
                ),
                content('Location Matters:',
                    'Some places are more prone to earthquakes. Knowing your area\'s risk helps you prepare better.'),
                SizedBox(
                  height: 7.h,
                ),
                SizedBox(
                    height: 2.h,
                    child: Container(
                      color: ColorStyles.white,
                    )),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  '# Protecting Yourself During an Earthquake:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      fontFamily: 'Tajawal',
                      color: ColorStyles.brown),
                ),
                SizedBox(
                  height: 7.h,
                ),
                content('Drop, Cover, and Hold On:',
                    'Drop to the ground, take cover under a sturdy piece of furniture, and hold on until the shaking stops.'),
                SizedBox(
                  height: 7.h,
                ),
                content('Stay Indoors:',
                    'If you\'re indoors during an earthquake, stay there. Avoid doorways; instead, take cover under a table or desk.'),
                SizedBox(
                  height: 7.h,
                ),
                content('Stay Away from Windows:',
                    'Windows can break during an earthquake. Move away from them to avoid getting hurt.'),
                SizedBox(
                  height: 7.h,
                ),
                content('If Outside:',
                    'Move to an open area away from buildings, trees, streetlights, and utility wires. Drop to the ground and cover your head.'),
                SizedBox(
                  height: 7.h,
                ),
                content('If Driving:',
                    'Pull over to a safe spot away from overpasses, bridges, and buildings. Stay inside the vehicle until the shaking stops.'),
                SizedBox(
                  height: 7.h,
                ),
                SizedBox(
                    height: 2.h,
                    child: Container(
                      color: ColorStyles.white,
                    )),
                SizedBox(
                  height: 7.h,
                ),
                Text(
                  '# Before an Earthquake:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      fontFamily: 'Tajawal',
                      color: ColorStyles.brown),
                ),
                SizedBox(
                  height: 10.h,
                ),
                content('Secure Heavy Furniture:',
                    'Anchor heavy furniture and appliances to the walls to prevent them from falling during an earthquake.'),
                SizedBox(
                  height: 7.h,
                ),
                content('Emergency Kit:',
                    'Prepare an emergency kit with essentials like water, non-perishable food, flashlight, first aid supplies, and important documents.'),
                SizedBox(
                  height: 7.h,
                ),
                content('Family Plan:',
                    'Have a family emergency plan. Know where to meet after the quake and how to contact each other.'),
                SizedBox(
                  height: 7.h,
                ),
                content('Practice Drills:',
                    'Practice earthquake drills with your family or colleagues, so you know what to do when it happens.'),
                SizedBox(
                  height: 7.h,
                ),
                SizedBox(
                    height: 2.h,
                    child: Container(
                      color: ColorStyles.white,
                    )),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  '# After an Earthquake:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      fontFamily: 'Tajawal',
                      color: ColorStyles.brown),
                ),
                SizedBox(
                  height: 7.h,
                ),
                content('Check for Injuries:',
                    'Check yourself and others for injuries. Provide first aid if needed.'),
                SizedBox(
                  height: 7.h,
                ),
                content('Be Cautious of Aftershocks:',
                    'Aftershocks may follow the main quake. Be ready for them and move to open areas away from damaged buildings.'),
                SizedBox(
                  height: 7.h,
                ),
                content('Listen for Information:',
                    'Listen to emergency broadcasts for updates and information on evacuation if necessary.'),
                SizedBox(
                  height: 7.h,
                ),
                content('Inspect Your Surroundings:',
                    'Check for hazards in your surroundings, like gas leaks or damaged electrical wires. Be cautious.'),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  '* Remember, the key is to stay calm, have a plan, and be prepared. Regular drills and simple safety measures can make a significant difference in protecting yourself and others during an earthquake.',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp,
                      fontFamily: 'Tajawal',
                      color: ColorStyles.red),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Column content(String address, String response) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          address,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              fontFamily: 'Tajawal',
              color: ColorStyles.red),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          response,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
              fontFamily: 'Tajawal',
              color: ColorStyles.white),
        ),
      ],
    );
  }

}