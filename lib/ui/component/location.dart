import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:magnaquake/ui/component/toast.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:provider/provider.dart';
import '../../controllers/providers.dart';
import '../utils/styles/color_styles.dart';

class MapLocation{

  static double latitude = 35.6764;
  static double longitude = 139.6500;


  static bool isLocationInJapan(double latitude, double longitude) {
    return latitude >= 20.0 &&
        latitude <= 45.551483 &&
        longitude >= 122.934570 &&
        longitude <= 153.986672;
  }

  static showMap(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20.0.r)),
            height: MediaQuery.of(context).size.height - 120,
            child: OpenStreetMapSearchAndPick(
              hintText: 'Location',
              center: const LatLong(
                  36.2048, 138.2529), // Set initial center to Japan
              buttonColor: ColorStyles.red,
              locationPinIconColor: ColorStyles.red,
              buttonText: 'Pick location',
              locationPinTextStyle: const TextStyle(color: ColorStyles.red),
              locationPinText: 'Location',
              onPicked: (pickedData) {
                Navigator.pop(context);
                List data = pickedData.address.values.toList();
                latitude = pickedData.latLong.latitude;
                longitude = pickedData.latLong.longitude;
                Provider.of<LocationProvider>(context, listen: false)
                    .selectedLocation = data.toString();

                // Check if the picked location is in Japan
                if (!isLocationInJapan(latitude, longitude)) {
                  CustomToast.lightToast(
                    msg: "Please choose a location in Japan.",
                    gravity: ToastGravity.CENTER,
                  );
                  // Optionally, reset the location to the center of Japan
                  latitude = 36.2048;
                  longitude = 138.2529;
                }
              },
            ),
          ),
        );
      },
    );
  }

  static Future getPosition() async {
    bool services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      CustomToast.lightToast(
          msg: "يرجى تفعيل خدمة الموقع", gravity: ToastGravity.CENTER);
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        await getLatAndLng().then((value) {
          latitude = value.latitude;
          longitude = value.longitude;
        });
      }
    }
  }

  static Future<Position> getLatAndLng() async {
    return await Geolocator.getCurrentPosition();
  }

}