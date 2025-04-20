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
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = (screenWidth / 3.5).clamp(98, 140);
    final bool isSelected = furnitureStatus == label;

    return SizedBox(
      width: buttonWidth,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? AppColors.primaryColor : Colors.white,
          foregroundColor: isSelected ? Colors.white : AppColors.bodySmallColor,
          side: isSelected ? null : BorderSide(color: AppColors.bodySmallColor.withOpacity(0.7), width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(horizontal: buttonWidth * 0.2),
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
        LayoutBuilder(
          builder: (context, constraints) {
            final buttons = options.map((label) => buildFurnitureButton(context, label)).toList();

            if (constraints.maxWidth > 350) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: buttons,
              );
            } else {
              return Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: buttons,
              );
            }
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
