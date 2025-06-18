import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final int maxLines;
  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    this.hintText,
    this.maxLines = 1,
    this.controller, required String labelText, required bool isNumeric, required int maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.dividerColor, // من AppColors
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        textAlign: TextAlign.right,
        textAlignVertical: maxLines == 1
            ? TextAlignVertical.center
            : TextAlignVertical.top,
        style: TextStyle(
          fontFamily: Fonts.primaryFontFamily,
          fontSize: screenWidth * 0.04,
          fontWeight: FontWeight.w500,
          color: AppColors.titleSmallColor, // بدل Colors.black
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: Fonts.primaryFontFamily,
            fontWeight: FontWeight.w500,
            fontSize: screenWidth * 0.04,
            height: 1.0,
            color: AppColors.bodySmallColor, // بدل 0xFF818181
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
            vertical: maxLines == 1
                ? screenHeight * 0.015
                : screenHeight * 0.02,
          ),
        ),
      ),
    );
  }
}

