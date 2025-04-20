import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peron_project/core/helper/colors.dart';


class AllowPetsSection extends StatelessWidget {
  final bool allowPets;
  final ValueChanged<bool> onChanged;

  const AllowPetsSection({
    super.key,
    required this.allowPets,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "السماح بوجود حيوانات أليفة",
          style: GoogleFonts.tajawal(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.headlineMediumColor,
          ),
        ),
        Switch(
          value: allowPets,
          activeColor: Colors.white,
          activeTrackColor: AppColors.primaryColor,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
