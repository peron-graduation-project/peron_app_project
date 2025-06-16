import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';

class CustomDatePickerField extends StatefulWidget {
  final String hintText;
  final DateTime? initialDate;
  final ValueChanged<DateTime> onDateSelected;

  const CustomDatePickerField({
    Key? key,
    required this.hintText,
    this.initialDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _CustomDatePickerFieldState createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
  late TextEditingController _controller;
  DateTime? _selectedDate;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _controller = TextEditingController(
      text: _selectedDate != null
          ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
          : '',
    );
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      locale: const Locale('ar'), 
    );
    if (picked != null) {
      _selectedDate = picked;
      _controller.text = DateFormat('yyyy-MM-dd').format(picked);
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      readOnly: true,
      focusNode: _focusNode,
      onTap: () async {
        _focusNode.requestFocus();
        await _pickDate();
        _focusNode.unfocus();
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: GestureDetector(
          onTap: () async {
            _focusNode.requestFocus();
            await _pickDate();
            _focusNode.unfocus();
          },
          child: const Icon(Icons.calendar_today_outlined),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFDADADA), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
        ),
      ),
      style: TextStyle(fontFamily: Fonts.primaryFontFamily),
      textAlign: TextAlign.right,
    );
  }
}
