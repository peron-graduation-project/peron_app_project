import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:location/location.dart';
import 'package:peron_project/core/helper/images.dart';

import '../../../core/helper/colors.dart';
import '../../../core/widgets/custom_button.dart';
import 'map_screen.dart';


class LocationDialog extends StatefulWidget {
  const LocationDialog({super.key});

  @override
  State<LocationDialog> createState() => _LocationDialogState();
}

class _LocationDialogState extends State<LocationDialog> {
  final String _location = "Unknown";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final buttonHeight = screenHeight * 0.06;
    var theme=Theme.of(context).textTheme;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
      ),
      child: Container(
        width: screenWidth * 0.85,
        padding: EdgeInsets.all(screenWidth * 0.05),
        decoration: BoxDecoration(
          color: AppColors.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
Images.selectLocation,
              fit: BoxFit.contain,
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              "هل تريد تحديد الموقع؟",
              style: theme.labelLarge?.copyWith(color: Color(0xff292828)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "إلغاء",
                    backgroundColor: AppColors.scaffoldBackgroundColor,
                    borderColor: AppColors.primaryColor,
                    textColor: AppColors.primaryColor,
                    side: BorderSide(
                      color: AppColors.primaryColor
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: CustomButton(
                    text: "تحديد",
                    backgroundColor: AppColors.primaryColor,
                    borderColor: AppColors.primaryColor,
                    textColor: AppColors.scaffoldBackgroundColor,
                    side: BorderSide(color: AppColors.primaryColor),
                    onPressed: () async {
                      await enableGPS();
                      print(" الموقع الحالي: $_location");
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapScreen(
                          ),
                        ),
                      );

                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> enableGPS() async {
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      bool userConfirmed = await location.requestService();
      if (!userConfirmed) {
        print(" المستخدم رفض تشغيل الـ GPS");
        return;
      }
    }

    print(" تم تشغيل الـ GPS بنجاح");
  }

  Future<Position?> getUserLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print(" تم رفض إذن الموقع");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print(" لا يمكن طلب الإذن مرة أخرى");
      return null;
    }

    try {
      geolocator.LocationSettings locationSettings = const geolocator.LocationSettings(
        accuracy: geolocator.LocationAccuracy.high,
        distanceFilter: 10,
      );

      geolocator.Position position = await geolocator.Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      return position;
    } catch (e) {
      print(" خطأ في تحديد الموقع: $e");
      return null;
    }
  }
}
