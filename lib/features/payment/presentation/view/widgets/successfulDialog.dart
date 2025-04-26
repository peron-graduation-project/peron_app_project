import 'package:flutter/material.dart';
import 'package:peron_project/features/home/presentation/view/views/home_view_body.dart';


class SuccessDialog extends StatelessWidget {
  final String message;
  final String buttonText;
  final VoidCallback? onButtonPressed;

  const SuccessDialog({
    Key? key,
    required this.message,
    this.buttonText = 'عودة',
    this.onButtonPressed,
  }) : super(key: key);

  // طريقة لعرض الـ dialog مباشرة بدون الحاجة لإنشاء instance
  static Future<void> show({
    required BuildContext context,
    required String message,
    String buttonText = 'عودة',
    VoidCallback? onButtonPressed,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SuccessDialog(
          message: message,
          buttonText: buttonText,
          onButtonPressed: onButtonPressed,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF0F7757),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              message,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onButtonPressed ??
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeViewBody()),
                    );
                  },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F7757),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
