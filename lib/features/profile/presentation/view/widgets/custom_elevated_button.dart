import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart'; 

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomElevatedButton({super.key, 
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: Size(screenWidth * 0.9, 48),
        padding: EdgeInsets.all(10),
      ),
      child: Text(
        text,
        style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}

