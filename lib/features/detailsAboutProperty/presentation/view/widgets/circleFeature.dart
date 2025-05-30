import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/fonts.dart';

class CircleFeature extends StatelessWidget {
  final IconData icon;
  final double screenWidth;

  CircleFeature({
    Key? key,
    required this.icon,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final circleSize = screenWidth * 0.1;

    return Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        // color: Colors.grey[600],
        size: circleSize * 0.45,
      ),
    );
  }
}