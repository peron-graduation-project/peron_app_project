import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peron_project/core/helper/colors.dart';

class RentalDurationSection extends StatelessWidget {
  final bool? isMonthly;
  final ValueChanged<bool> onChanged;

  const RentalDurationSection({
    super.key,
    required this.isMonthly,
    required this.onChanged,
  });

  Widget buildSelectableButton(String label, bool isSelected, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? AppColors.primaryColor : Colors.white,
          side: isSelected
              ? null
              : BorderSide(
                  color: AppColors.bodySmallColor.withOpacity(0.7),
                  width: 1,
                ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: GoogleFonts.tajawal(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.bodySmallColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            "مدة الإيجار",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Tajawal',
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: buildSelectableButton(
                "يومي",
                isMonthly == false,
                () => onChanged(false),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: buildSelectableButton(
                "شهري",
                isMonthly == true,
                () => onChanged(true),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
