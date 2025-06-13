import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:peron_project/core/helper/colors.dart'; 

class CustomPhoneField extends StatelessWidget {
  const CustomPhoneField({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return IntlPhoneField(
      decoration: InputDecoration(
        labelText: 'الهاتف',
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
      initialCountryCode: 'EG',
      dropdownIcon: Icon(
        Icons.arrow_drop_down,
        color: AppColors.black, 
        size: screenWidth * 0.06,
      ),
      onChanged: (phone) {
        print(phone.completeNumber);
      },
    );
  }
}
