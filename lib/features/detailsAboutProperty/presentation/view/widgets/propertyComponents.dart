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

  const PropertyComponents({
    super.key,
    required this.property,
    required this.screenWidth,
    required this.padding,
    required this.fontSize,
    required this.smallFontSize,
  });

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
            text: 'غرف: ${property.bedrooms??0}',
            fontSize: smallFontSize,
          ),
          TextFeatureItem(
            text: 'حمام: ${property.bathrooms??0}',
            fontSize: smallFontSize,
          ),
          if (property.hasBalcony != null)
            TextFeatureItem(text: 'بلكونة', fontSize: smallFontSize),
        ],
      ),
    );
  }
}
