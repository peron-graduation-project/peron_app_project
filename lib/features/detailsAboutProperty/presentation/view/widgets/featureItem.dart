import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/fonts.dart';

class FeatureItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final double screenWidth;

  FeatureItem({
    Key? key,
    required this.text,
    required this.icon,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final featureFontSize = screenWidth * 0.035;
    final featureIconSize = screenWidth * 0.04;
    final featurePadding = screenWidth * 0.03;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: featurePadding,
        vertical: featurePadding * 0.65,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 87, 86, 86)!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
                    Icon(icon, size: featureIconSize, color: Colors.grey),
          SizedBox(width: featurePadding * 0.3),

          Text(
            text,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 126, 126, 126),
              fontSize: featureFontSize,
              fontFamily: Fonts.primaryFontFamily,
            ),
          ),
        ],
      ),
    );
  }
}