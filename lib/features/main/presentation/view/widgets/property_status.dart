import 'package:flutter/material.dart';

import '../../../../../core/helper/colors.dart';

class PropertyStats extends StatelessWidget {
  final Map<String, dynamic> property;
  const PropertyStats({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildPropertyInfoRow(Icons.chair, property["rooms"]),
        buildPropertyInfoRow(Icons.bed, "${property["beds"]}"),
        buildPropertyInfoRow(Icons.bathtub, property["bathrooms"]),
        buildPropertyInfoRow(Icons.swap_horiz, "${property["area"]} م²"),
      ],
    );
  }

  Widget buildPropertyInfoRow(IconData icon, dynamic value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.inActiveColor),
        SizedBox(width: 6),
        Text("$value"),
      ],
    );
  }
}
