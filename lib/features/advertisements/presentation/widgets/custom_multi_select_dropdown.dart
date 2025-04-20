import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart'; // مهم دلوقتي

class CustomMultiSelectDropdown extends StatelessWidget {
  final String label;
  final List<String> selectedValues;
  final List<String> items;
  final void Function(List<String>) onChanged;

  const CustomMultiSelectDropdown({
    super.key,
    required this.label,
    required this.selectedValues,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final GlobalKey dropdownKey = GlobalKey();

    return GestureDetector(
      onTap: () async {
        final RenderBox? renderBox =
            dropdownKey.currentContext?.findRenderObject() as RenderBox?;

        if (renderBox != null) {
          final position = renderBox.localToGlobal(Offset.zero);
          final itemHeight = renderBox.size.height;

          List<String> tempSelected = List.from(selectedValues);

          await showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
              0,
              position.dy + itemHeight + 2,
              position.dx,
              0,
            ),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            items: [
              PopupMenuItem(
                enabled: false,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      children: items.map((item) {
                        final isSelected = tempSelected.contains(item);
                        return InkWell(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                tempSelected.remove(item);
                              } else {
                                tempSelected.add(item);
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Checkbox(
                                value: isSelected,
                                activeColor: AppColors.primaryColor,
                                onChanged: (_) {
                                  setState(() {
                                    if (isSelected) {
                                      tempSelected.remove(item);
                                    } else {
                                      tempSelected.add(item);
                                    }
                                  });
                                },
                              ),
                              Expanded(
                                child: Text(
                                  item,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontFamily: Fonts.primaryFontFamily,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    height: 1.0,
                                    letterSpacing: 0,
                                    color: AppColors.bodySmallColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              )
            ],
          );

          onChanged(tempSelected);
        }
      },
      child: Container(
        key: dropdownKey,
        width: double.infinity,
        height: 48,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.dividerColor),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                selectedValues.isEmpty ? label : selectedValues.join(', '),
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: Fonts.primaryFontFamily,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 1.0,
                  letterSpacing: 0,
                  color: selectedValues.isEmpty
                      ? AppColors.bodySmallColor
                      : Colors.black87,
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}
