import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/fonts.dart';

class PropertyInformation extends StatelessWidget {
  final double screenWidth;
  final double padding;
  final double fontSize;

  const PropertyInformation({
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 0,),
          Text(
            'الحالة: ممتازة',
            style: TextStyle(
              color: const Color.fromARGB(255, 143, 143, 143),
              // height: 1.5,
              fontWeight: FontWeight.normal,
              fontSize: 17,
              fontFamily: Fonts.primaryFontFamily,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(height: 5),
          Text(
            'الطابق: الثالث',
            style: TextStyle(
color: const Color.fromARGB(255, 143, 143, 143),              height: 1.5,
              fontWeight: FontWeight.normal,
              fontSize: 17,
              fontFamily: Fonts.primaryFontFamily,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(height: 5),
          Text(
            'الموقع: على الطريق الدائري وبجوار المسجد الكبير',
            style: TextStyle(
color: const Color.fromARGB(255, 143, 143, 143),              height: 1.5,
              fontWeight: FontWeight.normal,
              fontSize: 17,
              fontFamily: Fonts.primaryFontFamily,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}