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
    this.side,
    this.borderColor = Colors.transparent,
    this.isLoading = false,
  });

  final Color textColor;
  final Color borderColor;
  final Color backgroundColor;
  final String text;
  final TextDecoration? decoration;
  final void Function()? onPressed;
  final BorderSide? side;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    double screenWidth = MediaQuery.of(context).size.width;

    final defaultSide = side ?? BorderSide(color: borderColor, width: 1);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        height: 48,
        width: screenWidth * 0.8,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            side: defaultSide,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: defaultSide,
            ),
          ),
          onPressed: isLoading ? null : onPressed,
          child: isLoading
              ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
              : Text(
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
