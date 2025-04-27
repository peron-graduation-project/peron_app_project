import 'package:flutter/material.dart';

class FeatureItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final double screenWidth;

  const FeatureItem({
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
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: featureFontSize,
            ),
          ),
          SizedBox(width: featurePadding * 0.3),
          Icon(icon, size: featureIconSize, color: Colors.grey),
        ],
      ),
    );
  }
}
