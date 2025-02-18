import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';

class ApplicationThemeManager {
  static ThemeData lightThemeMode = ThemeData(
    fontFamily: Fonts.primaryFontFamily,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryColor,
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.titleSmallColor,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.bodySmallColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryColor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
  );

  static TextStyle getResponsiveTextStyle(BuildContext context, {required String style}) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (style == 'titleLarge') {
      return TextStyle(
        fontSize: screenWidth * 0.1,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryColor,
      );
    } else if (style == 'titleSmall') {
      return TextStyle(
        fontSize: screenWidth * 0.05,
        fontWeight: FontWeight.w700,
        color: AppColors.titleSmallColor,
      );
    } else {
      return TextStyle(
        fontSize: screenWidth * 0.04,
        fontWeight: FontWeight.w400,
        color: AppColors.bodySmallColor,
      );
    }
  }
}
