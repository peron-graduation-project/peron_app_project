import 'package:flutter/material.dart';

class CircleFeature extends StatelessWidget {
  final IconData icon;
  final double screenWidth;

  const CircleFeature({
    super.key,
    required this.icon,
    required this.screenWidth,
  });

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