import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart'; 

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomOutlinedButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColors.grey, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: Size(screenWidth * 0.9, 48),
        padding: EdgeInsets.all(10),
      ),
      child: Text(
        text,
        style: TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
