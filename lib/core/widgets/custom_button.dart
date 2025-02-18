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

    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: SizedBox(
        height: 48,
        width: screenWidth * 0.8,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            side: BorderSide(
              color: AppColors.primaryColor
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: theme.titleLarge?.copyWith(
              decoration: decoration,
              decorationColor: AppColors.primaryColor,
              color: textColor,
              fontSize: screenWidth * 0.05,
            ),
          ),
        ),
      ),
    );
  }
}
