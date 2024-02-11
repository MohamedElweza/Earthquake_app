import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnaquake/ui/component/location.dart';
import 'package:provider/provider.dart';
import '../../../controllers/providers.dart';
import '../../component/progress_dialpg.dart';
import '../../utils/styles/color_styles.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  @override
  Widget build(BuildContext context) {


    final TextEditingController magErrorController = TextEditingController();
    final TextEditingController horizontalErrorController = TextEditingController();
    final TextEditingController dmin = TextEditingController();
    final TextEditingController magNst = TextEditingController();
    final TextEditingController nst = TextEditingController();
    final TextEditingController depthError = TextEditingController();
    final TextEditingController depth = TextEditingController();
    final TextEditingController gap = TextEditingController();
    final TextEditingController rms = TextEditingController();


    Future<double> getPrediction() async {

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

      try{
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
            "lat": MapLocation.latitude,
            "lon": MapLocation.longitude,
            "depth": depthValue,
            "gap": gapValue,
            "rms": rmsValue,
          }),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          double predictionResult = responseData['prediction'];

          print(predictionResult);

          // Update the UI with the prediction result
          // setState(() {
          //   predictionResult = 'Prediction: $prediction';
          // });

          return predictionResult;
        } else {
          print('Failed to get prediction. Error: ${response.statusCode}');
          return 0.0;
        }
      } catch (error){
        print('Error: $error');
        return 0.0;
      }}

    Widget predictionButton(){
      return Padding(
        padding: EdgeInsets.only(top: 25.0.h, bottom: 20.h),
        child: ElevatedButton.icon(
            onPressed: () async {
              final Completer<void> completer = Completer<void>();
              ShowProgressIndicator(context);

              // Wait for a short delay to ensure the progress indicator is displayed
              await Future.delayed(const Duration(milliseconds: 300));

              double result;
              try {
                result = await getPrediction();
              } finally {
                // Complete the completer to close the progress indicator
                if (!completer.isCompleted) {
                  completer.complete();
                }
              }

              // Show the result in a dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Prediction Result'),
                    content: Text('Prediction: $result'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
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
      );
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
              predictionButton(),
            ],
          ));
    }


    return SafeArea(
      child: Scaffold(
        body: Container(
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
                          MapLocation.showMap(context);
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
        ),
      ),
    );
  }
}
