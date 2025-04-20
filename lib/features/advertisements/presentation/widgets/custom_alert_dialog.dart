import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/widgets/custom_button.dart';

class CustomAlertDialog extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomAlertDialog({
    super.key,
    required this.iconPath,
    required this.title,
    required this.description,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 327,
        height: 290,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 107,
              height: 107,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Fonts.primaryFontFamily,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Fonts.primaryFontFamily,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 118,
                  height: 48,
                  child: CustomButton(
                    text: cancelText,
                    backgroundColor: Colors.white,
                    textColor: AppColors.primaryColor,
                    borderColor: AppColors.primaryColor,
                    onPressed: onCancel,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 118,
                  height: 48,
                  child: CustomButton(
                    text: confirmText,
                    backgroundColor: AppColors.primaryColor,
                    textColor: Colors.white,
                    onPressed: onConfirm,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
