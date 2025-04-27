import 'package:flutter/material.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/textFeatureItem.dart';

class PropertyComponents extends StatelessWidget {
  final double screenWidth;
  final double padding;
  final double fontSize;
  final double smallFontSize;

  const PropertyComponents({
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
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 15),
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
