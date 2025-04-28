import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/fonts.dart';

class TextFeatureItem extends StatelessWidget {
  final String text;
  final double fontSize;

  const TextFeatureItem({
    Key? key,
    required this.text,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Text(
            "-",
            style: TextStyle(
              fontFamily: Fonts.primaryFontFamily,
            ),
          ),

          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: fontSize,
              fontFamily: Fonts.primaryFontFamily,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}