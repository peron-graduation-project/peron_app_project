import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final void Function(String?) onChanged;
  final String? Function(String?)? validator;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return FormField<String>(
      initialValue: value,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (FormFieldState<String> state) {
        final dropdownKey = GlobalKey();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              key: dropdownKey,
              onTap: () async {
                final renderBox = dropdownKey.currentContext
                    ?.findRenderObject() as RenderBox?;
                if (renderBox == null) return;

                final position = renderBox.localToGlobal(Offset.zero);
                final itemHeight = renderBox.size.height;

                final selected = await showMenu<String>(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    0,
                    position.dy + itemHeight + 4,
                    MediaQuery.of(context).size.width - position.dx - renderBox.size.width,
                    0,
                  ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  items: items.map((item) {
                    return PopupMenuItem<String>(
                      value: item,
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                      child: Row(
                        children: [
                          if (item == state.value)
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(
                                Icons.check,
                                color: AppColors.primaryColor,
                                size: 18,
                              ),
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
                                color: const Color(0xFF818181),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );

                if (selected != null) {
                  state.didChange(selected);
                  onChanged(selected);
                }
              },
              child: Container(
                width: double.infinity,
                height: 48,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: state.hasError
                          ? Colors.red
                          : const Color(0xFFDADADA)),
                          
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        state.value ?? label,
                        style: TextStyle(
                          fontFamily: Fonts.primaryFontFamily,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          height: 1.0,
                          letterSpacing: 0,
                          color: state.value == null
                              ? const Color(0xFF818181)
                              : AppColors.titleSmallColor,
                        ),
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),

            if (state.hasError)
              Padding(
                padding: EdgeInsets.only(top: 4, left: screenWidth * 0.03),
                child: Text(
                  state.errorText!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                    fontFamily: Fonts.primaryFontFamily,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
          ],
        );
      },
    );
  }
}
