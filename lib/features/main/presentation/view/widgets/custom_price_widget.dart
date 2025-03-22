import 'package:flutter/material.dart';

import '../../../../../core/helper/colors.dart';

class CustomPriceWidget extends StatelessWidget {
  const CustomPriceWidget({super.key, required this.propertyPrice});
  final String propertyPrice;

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context).textTheme;
    return Positioned(
      bottom: 4,
      right: 4,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.primaryColor,
        ),
        child: Text(
          "$propertyPrice ج.م",
          style:theme.labelMedium,
        ),
      ),
    )
    ;
  }
}
