import 'package:flutter/material.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/textFeatureItem.dart';
import 'package:peron_project/core/helper/fonts.dart';

class PropertyComponents extends StatelessWidget {
  final double screenWidth;
  final double padding;
  final double fontSize;
  final double smallFontSize;
  final Property property;

  PropertyComponents({
    Key? key,
    required this.property,
    required this.screenWidth,
    required this.padding,
    required this.fontSize,
    required this.smallFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'مكونات الشقة',
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize * 1.2,
              fontWeight: FontWeight.w500,
              fontFamily: Fonts.primaryFontFamily,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(height: 15),
          TextFeatureItem(
            text: 'غرف: ${property.bedrooms}',
            fontSize: smallFontSize,
          ),
          TextFeatureItem(
            text: 'حمام: ${property.bathrooms}',
            fontSize: smallFontSize,
          ),
          // TextFeatureItem(text: 'مطبخ', fontSize: smallFontSize),
          // TextFeatureItem(text: 'ريسبشن كبير', fontSize: smallFontSize),
          if (property.hasBalcony != null)
            TextFeatureItem(text: 'بلكونة', fontSize: smallFontSize),
        ],
      ),
    );
  }
}
