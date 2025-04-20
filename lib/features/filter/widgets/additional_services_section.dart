import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peron_project/core/helper/colors.dart';

class AdditionalServicesSection extends StatelessWidget {
  final List<String> selectedServices;
  final ValueChanged<String> onToggle;

  AdditionalServicesSection({super.key, required this.selectedServices, required this.onToggle});

  final List<String> additionalServices = ['الكل', 'واي فاي', 'بلكونه', 'حراسة / أمان', 'جراج', 'مصعد'];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = (screenWidth * 0.22).clamp(60, 100);
    double buttonHeight = 48;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "خدمات إضافية",
          style: GoogleFonts.tajawal(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.headlineMediumColor,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: additionalServices.map((service) {
            bool isSelected = selectedServices.contains(service);
            return SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected ? AppColors.primaryColor : Colors.white,
                  foregroundColor: isSelected ? Colors.white : AppColors.bodySmallColor,
                  side: isSelected ? null : BorderSide(color: AppColors.bodySmallColor.withOpacity(0.7), width: 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.zero,
                ),
                onPressed: () => onToggle(service),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      service,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.tajawal(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : AppColors.bodySmallColor,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
