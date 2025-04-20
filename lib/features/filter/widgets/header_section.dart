import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';

class HeaderSection extends StatelessWidget {
  final VoidCallback resetFilters;

  const HeaderSection({super.key, required this.resetFilters});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomArrowBack(),
        Text(
          "التصفية",
          style: GoogleFonts.tajawal(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColors.headlineMediumColor,
          ),
        ),
        TextButton(
          onPressed: resetFilters,
          child: Text(
            "مسح",
            style: GoogleFonts.tajawal(
              fontSize: 16,
              color: AppColors.bodySmallColor,
            ),
          ),
        ),
      ],
    );
  }
}

