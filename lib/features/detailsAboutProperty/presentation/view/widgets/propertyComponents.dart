import 'package:flutter/material.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/textFeatureItem.dart';
import 'package:peron_project/core/helper/fonts.dart';

class PropertyComponents extends StatelessWidget {
  final double screenWidth;
  final double padding;
  final double fontSize;
  final double smallFontSize;

  PropertyComponents({
    Key? key,
    required this.screenWidth,
    required this.padding,
    required this.fontSize,
    required this.smallFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'مكونات الشقة',
            style: TextStyle(
              fontSize: fontSize * 1.2,
              fontWeight: FontWeight.bold,
              fontFamily: Fonts.primaryFontFamily,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(height: 15),
          TextFeatureItem(text: 'غرف: 3', fontSize: smallFontSize),
          TextFeatureItem(text: 'حمام: 2', fontSize: smallFontSize),
          TextFeatureItem(text: 'مطبخ', fontSize: smallFontSize),
          TextFeatureItem(text: 'ريسبشن كبير', fontSize: smallFontSize),
          TextFeatureItem(text: 'بلكونة', fontSize: smallFontSize),
        ],
      ),
    );
  }
}