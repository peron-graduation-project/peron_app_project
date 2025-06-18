import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/textFeatureItem.dart';

class PropertyFeatures extends StatelessWidget {
  final double screenWidth;
  final double padding;
  final double fontSize;
  final double smallFontSize;

  const PropertyFeatures({
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'مميزات الشقة',
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize * 1.2,
              fontWeight: FontWeight.w500,
              fontFamily: Fonts.primaryFontFamily,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(height: 15),
          TextFeatureItem(text: 'أمن وحراسة 24 ساعة', fontSize: smallFontSize),
          TextFeatureItem(text: 'مناظر طبيعية', fontSize: smallFontSize),
          TextFeatureItem(
              text: 'مواقف سيارات خاصة بالسكان', fontSize: smallFontSize),
          TextFeatureItem(
              text: 'تحتوي على خدمات ترفيهية مثل (واى فاى/ مصعد)',
              fontSize: smallFontSize),
        ],
      ),
    );
  }
}