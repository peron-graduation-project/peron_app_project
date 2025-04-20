import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peron_project/core/helper/colors.dart';

class PriceRangeSection extends StatelessWidget {
  final double minPrice;
  final double maxPrice;
  final TextEditingController minController;
  final TextEditingController maxController;
  final VoidCallback updateRangeSlider;

  const PriceRangeSection({
    super.key,
    required this.minPrice,
    required this.maxPrice,
    required this.minController,
    required this.maxController,
    required this.updateRangeSlider,
  });

  Widget buildTextField(String label, TextEditingController controller, Function() onChanged) {
    return TextField(
      keyboardType: TextInputType.number,
      controller: controller,
      onChanged: (value) => onChanged(),
      style: GoogleFonts.tajawal(fontSize: 16, color: AppColors.labelLargeColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.tajawal(color: AppColors.bodySmallColor
),
        floatingLabelStyle: GoogleFonts.tajawal(color: AppColors.bodySmallColor
),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            "السعر",
            style: GoogleFonts.tajawal(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.headlineMediumColor,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.primaryColor,
            inactiveTrackColor: AppColors.dividerColor.withOpacity(0.3),
            thumbColor: Colors.white,
            overlayColor: AppColors.primaryColor.withOpacity(0.2),
            valueIndicatorTextStyle: GoogleFonts.tajawal(color: Colors.white),
          ),
          child: RangeSlider(
            values: RangeValues(minPrice, maxPrice),
            min: 500,
            max: 20000,
            labels: RangeLabels(minPrice.toInt().toString(), maxPrice.toInt().toString()),
            onChanged: (values) {
              minController.text = values.start.toInt().toString();
              maxController.text = values.end.toInt().toString();
              updateRangeSlider();
            },
          ),
        ),
        Row(
          children: [
            Expanded(child: buildTextField("من", minController, updateRangeSlider)),
            const SizedBox(width: 8),
            Expanded(child: buildTextField("إلى", maxController, updateRangeSlider)),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
