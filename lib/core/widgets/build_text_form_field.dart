import 'package:flutter/material.dart';

import '../helper/colors.dart';

Widget buildTextField(String label, TextInputType type, {bool obscureText = false}) {
  return TextFormField(
    keyboardType: type,
    obscureText: obscureText,
    obscuringCharacter: '*',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'من فضلك أدخل $label';
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.black),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
Widget buildTextFieldPattern({required String label, required TextInputType type, required String pattern,required String text,bool obscureText = false}) {
  return TextFormField(
    keyboardType: type,
    obscureText: obscureText,
    obscuringCharacter: '*',
    validator: (value) {
      String textFieldPattern = pattern;
      final regExp = RegExp(textFieldPattern);
      if (value == null || value.isEmpty) {
        return "من فضلك أدخل رقم $text";
      } else if (!regExp.hasMatch(value)) {
        return "$text غير صحيح";
      }
      return null;
    },

    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.black),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
