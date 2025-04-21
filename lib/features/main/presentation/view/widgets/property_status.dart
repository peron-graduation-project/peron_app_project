import 'package:flutter/material.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';

import '../../../../../core/helper/colors.dart';
import '../../../../../core/helper/fonts.dart';


class PropertyStats extends StatelessWidget {
  final RecommendedProperty property;
  final double iconSize;
  final double textSize;

  const PropertyStats({super.key, required this.property, required this.iconSize, required this.textSize});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 9,
      runSpacing: 4,
      children: [
        buildPropertyInfoRow(Icons.chair, "${property.bedrooms} غرف", iconSize, textSize),
        buildPropertyInfoRow(Icons.bathtub, "${property.bathrooms} حمام", iconSize, textSize),
        buildPropertyInfoRow(Icons.bed, "${property.bedrooms} سرير", iconSize, textSize),
        buildPropertyInfoRow(Icons.square_foot, "${property.area} م²", iconSize, textSize),
      ],
    );
  }

  Widget buildPropertyInfoRow(IconData icon, dynamic value, double iconSize, double textSize) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 2,
      children: [
        Icon(icon, size: iconSize, color: Colors.grey),
        Text("$value", style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontFamily: Fonts.kIbmPlexSans,
            color:AppColors.titleMediumColor
        ),),
      ],
    );
  }
}
