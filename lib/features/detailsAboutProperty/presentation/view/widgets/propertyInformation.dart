import 'package:flutter/material.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/textFeatureItem.dart';

class PropertyInformation extends StatelessWidget {
  final double screenWidth;
  final double fontSize;
  final double smallFontSize;
  final double padding;

  final Property property;

  const PropertyInformation({
    super.key,
    required this.property,
    required this.screenWidth,
    required this.fontSize, required this.smallFontSize, required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFeatureItem(
            text:'المساحة: ${property.area ?? 0}',
            fontSize: smallFontSize,
          ),
          SizedBox(height: 5),
          TextFeatureItem(
            text: 'الطابق: ${property.floor ?? 0}',
            fontSize: smallFontSize,
          ),
          SizedBox(height: 5),
          TextFeatureItem(
            text: 'الموقع: ${property.location ?? "لم يتم تحديد موقع"}',
            fontSize: smallFontSize,
          ),

        ],
      ),
    );
  }
}
