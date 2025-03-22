import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneFieldInput extends StatefulWidget {
  final TextEditingController? controller;
  const PhoneFieldInput({super.key, this.controller});

  @override
  _PhoneFieldInputState createState() => _PhoneFieldInputState();
}

class _PhoneFieldInputState extends State<PhoneFieldInput> {
  String completePhoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntlPhoneField(
          decoration: InputDecoration(
            labelText: 'الهاتف',
            labelStyle: TextStyle(fontSize: 16, color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
          style: TextStyle(fontSize: 16, color: Colors.black),
          dropdownTextStyle: TextStyle(fontSize: 16, color: Colors.black),
          initialCountryCode: 'EG',
          languageCode: 'ar',
          onChanged: (phone) {
            setState(() {
              completePhoneNumber = phone.completeNumber;
            });
            widget.controller?.text = completePhoneNumber;
            print(widget.controller?.text);
            },
        ),
      ],
    );
  }
}
