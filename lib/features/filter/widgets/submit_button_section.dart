import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';


class SubmitButtonSection extends StatelessWidget {
  final VoidCallback onPressed;

  const SubmitButtonSection({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onPressed,
          child: const Text(
            "عرض الشقة المتاحة",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: 'Tajawal',
            ),
          ),
        ),
      ),
    );
  }
}
