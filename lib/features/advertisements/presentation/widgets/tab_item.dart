import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/fonts.dart';

class TabItem extends StatelessWidget {
  final String title;
  final int index;
  final int selectedIndex;
  final Function(int) onTap;

  const TabItem({
    Key? key,
    required this.title,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected ? const Color(0xFF0F8E65) : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontFamily: Fonts.primaryFontFamily,

              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          if (isSelected)
            Container(height: 2, width: 50, color: const Color(0xFF0F8E65)),
        ],
      ),
    );
  }
}
