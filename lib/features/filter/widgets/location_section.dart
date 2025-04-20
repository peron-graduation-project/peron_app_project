import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peron_project/core/helper/colors.dart';

class LocationSection extends StatelessWidget {
  final String? selectedLocation;
  final ValueChanged<String?> onChanged;

  const LocationSection({super.key, required this.selectedLocation, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final List<String> locations = [
      "حي الجامعة",
      "قناة السويس",
      "توريل",
      "الجلاء",
      "المشاية",
      "عبدالسلام عارف",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            "المكان",
            style: GoogleFonts.tajawal(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.headlineMediumColor,
            ),
          ),
        ),
        const SizedBox(height: 4),
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              "اختر المكان",
              style: GoogleFonts.tajawal(
                fontSize: 16,
                color: AppColors.titleMediumColor,
              ),
            ),
            value: selectedLocation,
            buttonStyleData: ButtonStyleData(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.dividerColor),
                borderRadius: BorderRadius.circular(8),
                color: AppColors.scaffoldBackgroundColor,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: double.infinity,
              width: 150,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.inActiveColor),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              offset: const Offset(-300, -10),
            ),
            menuItemStyleData: const MenuItemStyleData(height: 48),
            iconStyleData: const IconStyleData(
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
              iconSize: 24,
              openMenuIcon: Icon(Icons.keyboard_arrow_up, color: Colors.black),
            ),
            items: locations.map((String location) {
              return DropdownMenuItem<String>(
                value: location,
                child: Text(
                  location,
                  style: GoogleFonts.tajawal(fontSize: 16, color: AppColors.labelLargeColor),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
