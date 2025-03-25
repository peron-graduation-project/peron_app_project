import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/images.dart'; 
import 'package:google_fonts/google_fonts.dart';

class HeaderWidget extends StatelessWidget {
  final double screenWidth;

  const HeaderWidget({Key? key, required this.screenWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: SvgPicture.asset(
            Images.backIcon, 
            width: screenWidth * 0.06,
            height: screenWidth * 0.06,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        Text(
          'سياسة الخصوصية',
          style: GoogleFonts.tajawal(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
        ),
        SizedBox(width: screenWidth * 0.12),
      ],
    );
  }
}

class SectionWidget extends StatelessWidget {
  final String title;
  final String content;

  const SectionWidget({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:GoogleFonts.tajawal(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 8),
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
}

class ContactItemWidget extends StatelessWidget {
  final String text;
  final String iconPath;
  final double screenWidth;

  const ContactItemWidget({
    Key? key,
    required this.text,
    required this.iconPath,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
