import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/fonts.dart';

class PaymentMethodItem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String? title; 
  final String? cardNumber;
  final String icon;
  final bool isCustomIcon;
  final VoidCallback onTap;
  final Color activeColor;

  const PaymentMethodItem({
    super.key,
    required this.index,
    required this.selectedIndex,
    this.title, 
    this.cardNumber,
    required this.icon,
    this.isCustomIcon = false,
    required this.onTap,
    this.activeColor = const Color(0xff0F7757),
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            textDirection: TextDirection.rtl, // Set text direction to right-to-left
            children: [
              // Icon on the right side
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: isCustomIcon
                      ? Image.asset(
                          icon,
                          width: 30,
                          height: 30,
                        )
                      : Icon(
                          Icons.payment,
                          color: Colors.grey[700],
                        ),
                ),
              ),
              const SizedBox(width: 16),
              // Title and card number if available
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align to start (which will be right due to RTL)
                  children: [
                    if (title != null) 
                      Text(
                        title!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: Fonts.primaryFontFamily,
                        ),
                      ),
                    if (cardNumber != null)
                      Text(
                        cardNumber!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: Fonts.primaryFontFamily,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Checkbox on the left side
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? activeColor : Colors.grey.shade400,
                    width: 1.5,
                  ),
                  color: isSelected ? activeColor : Colors.white,
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}