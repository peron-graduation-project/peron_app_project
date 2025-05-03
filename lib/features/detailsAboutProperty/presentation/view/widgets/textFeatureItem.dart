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
color: const Color.fromARGB(255, 143, 143, 143),              height: 1.5,
              fontWeight: FontWeight.w100,
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