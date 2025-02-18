import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.textColor,
    required this.text,
    required this.backgroundColor,
    this.onPressed,
    this.decoration,
  });

  final Color textColor;
  final Color backgroundColor;
  final String text;
  final TextDecoration? decoration;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    // Get screen width to make responsive adjustments
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: SizedBox(
        height: 48,  // Fixed height, but can be adjusted dynamically if needed
        width: screenWidth * 0.8,  // Adjust width to be responsive
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: theme.titleLarge?.copyWith(
              decoration: decoration,
              decorationColor: AppColors.primaryColor,
              color: textColor,
              fontSize: screenWidth * 0.05,  // Responsive font size
            ),
          ),
        ),
      ),
    );
  }
}
