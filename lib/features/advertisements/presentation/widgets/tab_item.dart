import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/fonts.dart';

class TabItem extends StatelessWidget {
  final String title;
  final int index;
  final int selectedIndex;
  final int? length;
  final Function(int) onTap;

  const TabItem({
    super.key,
    required this.title,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
    this.length,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        children: [
          Row(
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
              SizedBox(),
              // BlocBuilder(
              //   builder: (context, state) {
              //     if (state is! GetPropertyStateSuccess) {
              //       return SizedBox();
              //     }
              //     return ;
              //   },
              // ),
              Text(
                "${length ?? 0}",
                // "${index == 0 ? context.read<GetPropertyCubit>().getPropertiesLength ?? 0 : 0}",
                style: TextStyle(
                  color: isSelected ? const Color(0xFF0F8E65) : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontFamily: Fonts.primaryFontFamily,

                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          if (isSelected)
            Container(height: 2, width: 50, color: const Color(0xFF0F8E65)),
        ],
      ),
    );
  }
}
