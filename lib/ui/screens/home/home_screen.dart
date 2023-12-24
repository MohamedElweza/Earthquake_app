import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:magnaquake/data/api/models/data.dart';
import 'package:magnaquake/data/api/models/main_data.dart';
import 'package:magnaquake/data/api/request/api_request.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../controllers/providers.dart';
import '../../component/toast.dart';
import '../../utils/styles/color_styles.dart';
import '../details/details.dart';
import '../home/custom_listTile.dart';
import 'generate_flag.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();
  String title = 'Click to Predict You Data';
  double latitude = 35.6764;
  double longitude = 139.6500;

  final TextEditingController magErrorController = TextEditingController();
  final TextEditingController horizontalErrorController = TextEditingController();
  final TextEditingController dmin = TextEditingController();
  final TextEditingController magNst = TextEditingController();
  final TextEditingController nst = TextEditingController();
  final TextEditingController depthError = TextEditingController();
  final TextEditingController depth = TextEditingController();
  final TextEditingController gap = TextEditingController();
  final TextEditingController rms = TextEditingController();
  final TextEditingController magType_mb = TextEditingController();
  final TextEditingController magType_mb_lg = TextEditingController();
  final TextEditingController magType_ml = TextEditingController();
  final TextEditingController magType_ms = TextEditingController();
  final TextEditingController magType_mwb = TextEditingController();
  final TextEditingController magType_mwc = TextEditingController();
  final TextEditingController magType_mwr = TextEditingController();
  final TextEditingController magType_mww = TextEditingController();
  final TextEditingController magSource_gcmt = TextEditingController();
  final TextEditingController magSource_nied = TextEditingController();
  final TextEditingController magSource_official = TextEditingController();
  final TextEditingController magSource_us = TextEditingController();

  String predictionResult = '';

  Future getPosition() async {
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

  Future<Position> getLatAndLng() async {
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getPrediction() async {
    // Extract values from input controllers
    double magError = double.tryParse(magErrorController.text) ?? 0.0;
    double horizontalError = double.tryParse(horizontalErrorController.text) ?? 0.0;
    double depthErrorValue = double.tryParse(depthError.text) ?? 0.0;
    int nstValue = int.tryParse(nst.text) ?? 0;
    double magNstValue = double.tryParse(magNst.text) ?? 0.0;
    double dminValue = double.tryParse(dmin.text) ?? 0.0;
    double depthValue = double.tryParse(depth.text) ?? 0.0;
    double gapValue = double.tryParse(gap.text) ?? 0.0;
    double rmsValue = double.tryParse(rms.text) ?? 0.0;

    String selectedMagType = Provider.of<MagnitudeTypesDropdownState>(context, listen: false).selectedOption;
    String selectedMagSource = Provider.of<MagnitudeSourcesDropdownState>(context, listen:  false).selectedOption;

    // Make a request to FastAPI server
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/predict'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "magError": magError,
        "horizontalError": horizontalError,
        "depthError": depthErrorValue,
        "nst": nstValue,
        "magNst": magNstValue,
        "dmin": dminValue,
        "gcmt": selectedMagSource == 'gcmt' ? 1 : 0,
        "nied": selectedMagSource == 'nied' ? 1 : 0,
        "official": selectedMagSource == 'official' ? 1 : 0,
        "us": selectedMagSource == 'us' ? 1 : 0,
        "mb": selectedMagType == 'mb' ? 1 : 0,
        "mb_lg": selectedMagType == 'mb_lg' ? 1 : 0,
        "ml": selectedMagType == 'ml' ? 1 : 0,
        "ms": selectedMagType == 'ms' ? 1 : 0,
        "mwb": selectedMagType == 'mwb' ? 1 : 0,
        "mwc": selectedMagType == 'mwc' ? 1 : 0,
        "mwr": selectedMagType == 'mwr' ? 1 : 0,
        "mww": selectedMagType == 'mww' ? 1 : 0,
        "lat": latitude,
        "lon": longitude,
        "depth": depthValue,
        "gap": gapValue,
        "rms": rmsValue,
      }),
    );


    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      double prediction = responseData['prediction'];

      print(prediction);

      // Update the UI with the prediction result
      setState(() {
        predictionResult = 'Prediction: $prediction';
      });
    } else {
      // Handle errors
      print('Failed to get prediction. Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    String flag = generateCountryFlag();
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
          actions: [
            IconButton(
                onPressed: () {
                  _showDialog(context);
                },
                icon: const Icon(
                  Icons.read_more,
                  color: Colors.white,
                ))
          ],          title: Text(
            'Earthquake',
            style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal',
                color: ColorStyles.brown),
          ),
        ),
        body: FutureBuilder<Autogenerated>(
          future: EarthquakeRequests.GetAllEarthquakes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
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
                                            borderRadius: BorderRadius.circular(10.r)),
                                        child: const ListTile()),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              Autogenerated model = snapshot.data!;
              return dataSection(model, flag);
            } else {
              return const Text('No data available');
            }
          },
        ),
      ),
    );
  }

  Future<void> _showDialog(BuildContext context) async {
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

  Column content(String address, String response) {
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

  SingleChildScrollView dataSection(Autogenerated model, String flag) {
    final scrollController = ScrollController();
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
                gradient:  const LinearGradient(
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
                      Provider.of<HomeProvider>(context, listen: false)
                          .aiDialogShown = true;
                      customDialog(context, onClosed: (_) {
                        Provider.of<HomeProvider>(context, listen: false)
                            .aiDialogShown = false;
                      });
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
                            flag: flag,
                          )),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Future<Object?> customDialog(BuildContext context, {required ValueChanged onClosed}) {
    return showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: 'AI Model',
        context: context,
        transitionDuration: const Duration(milliseconds: 400),
        transitionBuilder: (_, animation, __, child) {
          Tween<Offset> tween;
          tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
          return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child,
          );
        },
        pageBuilder: (context, _, __) => Center(
            child: Container(
              height: 620.h,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.94),
                  borderRadius: BorderRadius.all(Radius.circular(40.r))),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(clipBehavior: Clip.none, children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'AI Prediction',
                          style: TextStyle(
                              fontSize: 34.sp,
                              fontFamily: 'Tajawal',
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0.h),
                          child: const Text(
                            'This AI model predicts earthquake magnitudes in Japan using advanced machine learning, offering crucial insights for early warning systems and disaster preparedness.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Tajawal'),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 5.w),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  strokeAlign: BorderSide.strokeAlignInside,
                                  width: 1.w),
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.r))),
                          child: GestureDetector(
                            child: Text(
                              textAlign: TextAlign.center,
                              Provider.of<LocationProvider>(context).selectedLocation,
                              style: TextStyle(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold,
                                  color: ColorStyles.red),
                            ),
                            onTap: () {
                              _showModal(context);
                            },
                          ),
                        ),
                        SizedBox(height: 20.h),
                        dataInput(context),
                      ],
                    ),
                  ),
                  Positioned(
                      left: 0.w,
                      right: 0.w,
                      bottom: -70.h,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CircleAvatar(
                          radius: 16.r,
                          backgroundColor: Colors.white,
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      ))
                ]),
              ),
            ))).then(onClosed);
  }

  void _showModal(BuildContext context) {
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
                  if (!_isLocationInJapan(latitude, longitude)) {
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

  bool _isLocationInJapan(double latitude, double longitude) {
    return latitude >= 20.0 &&
        latitude <= 45.551483 &&
        longitude >= 122.934570 &&
        longitude <= 153.986672;
  }

  Form dataInput(BuildContext context) {
    final List<String> magTypes = [
      'mww',
      'mwr',
      'mwc',
      'mwb',
      'ms',
      'ml',
      'mb',
      'mb_lg'
    ];
    final List<String> magSources = [
      'us',
      'official',
      'nied',
      'gcmt',
    ];
    return Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                inputData('RMS', rms ),
                SizedBox(
                  width: 15.w,
                ),
                inputData('MagError', magErrorController),
              ],
            ),
            Row(
              children: [
                inputData('Depth', depth),
                SizedBox(
                  width: 15.w,
                ),
                inputData('DepthError', depthError),
              ],
            ),
            Row(
              children: [
                inputData('D-min', dmin),
                SizedBox(
                  width: 15.w,
                ),
                inputData('HorizontalError', horizontalErrorController),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  value: Provider.of<MagnitudeTypesDropdownState>(context).selectedOption,
                  onChanged: (value) {
                    Provider.of<MagnitudeTypesDropdownState>(context, listen: false).selectedOption = value!;
                  },
                  items: magTypes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: Provider.of<MagnitudeSourcesDropdownState>(context).selectedOption,
                  onChanged: (value) {
                    Provider.of<MagnitudeSourcesDropdownState>(context, listen: false).selectedOption = value!;
                  },
                  items: magSources.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 25.0.h, bottom: 20.h),
              child: ElevatedButton.icon(
                  onPressed: () async{
                    await getPrediction();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorStyles.red,
                      minimumSize: Size(double.infinity, 56.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            topRight: Radius.circular(25.r),
                            bottomRight: Radius.circular(25.r),
                            bottomLeft: Radius.circular(25.r),
                          ))),
                  icon: const Icon(CupertinoIcons.chart_bar_alt_fill, color: Colors.white,),
                  label: Text('Predict', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Tajawl', fontSize: 18.sp),)),
            )
          ],
        ));
  }

  Column inputData(title, input) {
    return Column(

      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.0.h, bottom: 8.h),
          child: SizedBox(height: 40.h, width: 140.w,
              child: TextFormField(
                  controller: input,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: Text(title),
                      hintText: title,
                      border: const OutlineInputBorder()))),
        ),
      ],
    );
  }
}



