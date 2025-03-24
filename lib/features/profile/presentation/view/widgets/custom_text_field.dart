import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peron_project/core/helper/colors.dart'; 

class CustomTextField extends StatelessWidget {
  final String label;
  final int maxLines;

  const CustomTextField({required this.label, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.05),
      child: TextField(
        maxLines: maxLines,
        textDirection: TextDirection.rtl,
        style: TextStyle(color: AppColors.black), 
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.tajawal(
            fontSize: screenWidth * 0.04,
            color: AppColors.black, 
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
            borderSide: BorderSide(color: AppColors.grey), 
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
            borderSide: BorderSide(color: AppColors.primary, width: 2), 
          ),
        ),
      ),
    );
  }
}
