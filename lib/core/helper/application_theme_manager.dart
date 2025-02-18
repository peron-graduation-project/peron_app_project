import 'package:flutter/material.dart' ;
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/string_helper.dart';

class ApplicationThemeManager{
  static ThemeData lightThemeMode=ThemeData(
    fontFamily: StringHelper.primaryFontFamily,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      textTheme:  TextTheme(
        titleSmall:  TextStyle(
             fontSize: 40,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor
         ),

        // titleLarge: TextStyle(
        //     fontFamily: Fonts.,
        //     fontSize: 24,
        //     fontWeight: FontWeight.bold,
        //     color: AppColors.
        // ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.primaryColor,
        showSelectedLabels: true,

        showUnselectedLabels: true,
      )

  );

}