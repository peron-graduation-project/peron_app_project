import 'package:flutter/material.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/circleFeature.dart';
import 'package:peron_project/core/helper/fonts.dart';

class AdditionalFeatures extends StatelessWidget {
  final double screenWidth;
  final double padding;
  final double fontSize;

  AdditionalFeatures({
    Key? key,
    required this.screenWidth,
    required this.padding,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'ميزات اضافية',
            style: TextStyle(
              fontSize: fontSize * 1.2,
              fontWeight: FontWeight.bold,
              fontFamily: Fonts.primaryFontFamily,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "مواقف مغطاه للسيارات",
                    style: TextStyle(
                      fontFamily: Fonts.primaryFontFamily,
                    ),
                  ),
                  SizedBox(width: 8),
                  CircleFeature(
                      icon: Icons.car_crash, screenWidth: screenWidth),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "مسموح بالحيوانات الاليفة",
                    style: TextStyle(
                      fontFamily: Fonts.primaryFontFamily,
                    ),
                  ),
                  SizedBox(width: 8),
                  CircleFeature(icon: Icons.pets, screenWidth: screenWidth),
                ],
              ),
              Divider()
            ],
          ),
        ],
      ),
    );
  }
}