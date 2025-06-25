import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peron_project/core/helper/colors.dart';

class FurnitureStatusSection extends StatelessWidget {
  final String? furnitureStatus;
  final ValueChanged<String> onChanged;

  const FurnitureStatusSection({
    super.key,
    required this.furnitureStatus,
    required this.onChanged,
  });

  Widget buildFurnitureButton(BuildContext context, String label) {
    const double minWidth = 90;
    const double maxWidth = 120;

    final bool isSelected = furnitureStatus == label;

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: minWidth,
        maxWidth: maxWidth,
        minHeight: 48,
        maxHeight: 48,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? AppColors.primaryColor : Colors.white,
          foregroundColor: isSelected ? Colors.white : AppColors.bodySmallColor,
          side: isSelected
              ? null
              : BorderSide(
                  color: AppColors.bodySmallColor.withOpacity(0.7),
                  width: 1,
                ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        onPressed: () => onChanged(label),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.tajawal(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : AppColors.bodySmallColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> options = ["مجهزة", "غير مجهزة", "مجهزة جزئيًا"];

    const double spacingBetween = 16;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "مجهزة بالأثاث",
          style: GoogleFonts.tajawal(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.headlineMediumColor,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildFurnitureButton(context, options[0]),
            const SizedBox(width: spacingBetween),
            buildFurnitureButton(context, options[1]),
            const SizedBox(width: spacingBetween),
            buildFurnitureButton(context, options[2]),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
