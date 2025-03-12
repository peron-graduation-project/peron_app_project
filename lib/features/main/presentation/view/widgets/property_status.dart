import 'package:flutter/material.dart';


class PropertyStats extends StatelessWidget {
  final Map<String, dynamic> property;
  final double iconSize;
  final double textSize;

  const PropertyStats({super.key, required this.property, required this.iconSize, required this.textSize});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        buildPropertyInfoRow(Icons.chair, "${property["rooms"]} غرف", iconSize, textSize),
        buildPropertyInfoRow(Icons.bathtub, "${property["bathrooms"]} حمام", iconSize, textSize),
        buildPropertyInfoRow(Icons.bed, "${property["beds"]} سرير", iconSize, textSize),
        buildPropertyInfoRow(Icons.square_foot, "${property["area"]} م²", iconSize, textSize),
      ],
    );
  }

  Widget buildPropertyInfoRow(IconData icon, dynamic value, double iconSize, double textSize) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      children: [
        Icon(icon, size: iconSize, color: Colors.grey),
        Text("$value", style: TextStyle(fontSize: textSize * 0.8)),
      ],
    );
  }
}
