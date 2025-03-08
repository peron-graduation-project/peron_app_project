
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneFieldInput extends StatelessWidget {
  const PhoneFieldInput({super.key});

  @override
  Widget build(BuildContext context) {
    return  IntlPhoneField(
        decoration: InputDecoration(
          labelText: 'الهاتف',
          labelStyle:const TextStyle(fontSize: 16, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(12),
          ),),
        languageCode: 'ar',
        dropdownTextStyle: const TextStyle(fontSize: 16),
        initialCountryCode: 'EG',
        onChanged: (phone) {
          debugPrint(phone.completeNumber);
        },
        validator: (value) {
          const String phonePattern = r'^(?:[1-9])?[0-9]{11}$';
          final regExp = RegExp(phonePattern);
          if (value == null || value.number.isEmpty) {
            return "من فضلك أدخل رقم الهاتف";
          } else if (!regExp.hasMatch(value.number)) {
            return "رقم الهاتف غير صحيح";
          }
          return null;
        },
      );
  }
}
