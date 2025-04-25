import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helper/colors.dart';

class SortButton extends StatefulWidget {
  final Function(String)? onSelected;
  const SortButton({super.key, this.onSelected});

  @override
  State<SortButton> createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {
  final List<String> items = ["الأكثر تقييما", 'الأكثر مساحة', 'الأعلى سعرا', 'الأقل سعرا'];
  String selectedValue = "الأكثر تقييما";

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    double screenWidth = MediaQuery.of(context).size.width;

    // نحسب أطول عنصر
    double longestTextWidth = _getLongestTextWidth(context, items, theme.bodyMedium!);

    // نحدد العرض بناءً على الشاشة وبحد أقصى 70٪ منها
    double dropdownWidth = longestTextWidth + 40; // +40 علشان الأيقونات والمسافة
    dropdownWidth = dropdownWidth > screenWidth * 0.7 ? screenWidth * 0.7 : dropdownWidth;

    return IntrinsicWidth(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.02,
          vertical: screenWidth * 0.015,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(screenWidth * 0.025),
          color: Colors.white,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: false,
            customButton: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'ترتيب',
                  style: theme.displayMedium!.copyWith(color: AppColors.primaryColor),
                ),
                SizedBox(width: screenWidth * 0.01),
                Icon(Icons.swap_vert, color: AppColors.primaryColor, size: screenWidth * 0.05),
              ],
            ),
            value: null,
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
              });
              widget.onSelected?.call(selectedValue);
            },
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item,
                      style: TextStyle(
                        color: selectedValue == item
                            ? AppColors.primaryColor
                            : Colors.black,
                        fontWeight: selectedValue == item
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                    if (selectedValue == item)
                      Icon(Icons.check, color: AppColors.primaryColor, size: 20),
                  ],
                ),
              );
            }).toList(),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: dropdownWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              offset: const Offset(0, 8),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.black54),
              iconSize: 24,
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ),
      ),
    );
  }

  double _getLongestTextWidth(BuildContext context, List<String> texts, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.rtl,
    );
    double maxWidth = 0;

    for (var text in texts) {
      textPainter.text = TextSpan(text: text, style: style);
      textPainter.layout();
      if (textPainter.width > maxWidth) {
        maxWidth = textPainter.width;
      }
    }
    return maxWidth;
  }
}
