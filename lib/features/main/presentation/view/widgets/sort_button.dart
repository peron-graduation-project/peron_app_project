import 'package:flutter/material.dart';
import '../../../../../core/helper/colors.dart';

class SortButton extends StatelessWidget {
  const SortButton({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03,
          vertical: screenWidth * 0.015
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(screenWidth * 0.025),
      ),
      child: GestureDetector(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                "ترتيب",
                style: theme.displayMedium!.copyWith(color: AppColors.primaryColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: screenWidth * 0.01),
            Icon(Icons.swap_vert, color: AppColors.primaryColor, size: screenWidth * 0.05),
          ],
        ),
      ),
    );
  }
}