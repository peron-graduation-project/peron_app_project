import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final int maxLines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;                 
  final TextAlignVertical? textAlignVertical;        

  const CustomTextField({
    super.key,
    this.hintText,
    this.maxLines = 1,
    this.controller,
    this.validator,
    this.keyboardType,                                
    this.textAlignVertical,      
                     
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final inputDecoration = InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        fontFamily: Fonts.primaryFontFamily,
        fontWeight: FontWeight.w500,
        fontSize: screenWidth * 0.04,
        height: 1.0,
        color: AppColors.bodySmallColor,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.dividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red, width: 1.2),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: maxLines == 1
            ? screenHeight * 0.015
            : screenHeight * 0.02,
      ),
    );

    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      keyboardType: keyboardType,                   
      textAlign: TextAlign.right,
      textAlignVertical: textAlignVertical ??
          (maxLines == 1
              ? TextAlignVertical.center
              : TextAlignVertical.top),
      style: TextStyle(
        fontFamily: Fonts.primaryFontFamily,
        fontSize: screenWidth * 0.04,
        fontWeight: FontWeight.w500,
        color: AppColors.titleSmallColor,
      ),
      decoration: inputDecoration,
    );
  }
}
