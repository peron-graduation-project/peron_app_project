import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart'; 

Widget buildSection({required String title, required String content}) {
  return Padding(
    padding: const EdgeInsets.only(top: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.tajawal(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.black, 
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: GoogleFonts.tajawal(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.grey, 
          ),
        ),
      ],
    ),
  );
}

Widget buildContactItem({
  required String text,
  required String iconPath,
  required double screenWidth,
}) {
  return Row(
    children: [
      SvgPicture.asset(
        iconPath,
        height: screenWidth * 0.06,
        width: screenWidth * 0.06,
      ),
      SizedBox(width: screenWidth * 0.03),
      Expanded(
        child: Text(
          text,
          style: GoogleFonts.tajawal(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.primary, 
          ),
        ),
      ),
    ],
  );
}
