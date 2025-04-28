import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peron_project/core/helper/fonts.dart';

class CustomField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isNumeric;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const CustomField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isNumeric = false,
    this.maxLength,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      inputFormatters: isNumeric
          ? [
              FilteringTextInputFormatter.digitsOnly,
              if (maxLength != null)
                LengthLimitingTextInputFormatter(maxLength!),
            ]
          : null,
      onChanged: onChanged,
      style: TextStyle(
        fontFamily: Fonts.primaryFontFamily,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.grey,
          fontFamily: Fonts.primaryFontFamily,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF0F7757)),
        ),
      ),
    );
  }
}