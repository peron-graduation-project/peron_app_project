import 'package:flutter/material.dart';
import 'package:peron_project/features/advertisements/presentation/views/myAdvScreen.dart';
import 'package:peron_project/core/helper/fonts.dart';

class SuccessPaymentDialog extends StatelessWidget {
  final String message;
  final String buttonText;
  final VoidCallback? onButtonPressed;

  const SuccessPaymentDialog({
    super.key,
    required this.message,
    this.buttonText = 'عودة',
    this.onButtonPressed,
  });

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
        return SuccessPaymentDialog(
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
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
              child: const Icon(Icons.check, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 24),
            Text(
              message,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontFamily: Fonts.primaryFontFamily,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
                onPressed:
                    onButtonPressed ??
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => MyAdvertisementsPage(
                                initialPublishedCount:
                                    1, // Start with 1 to show PropertyCard
                              ),
                        ),
                      );
                    },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F7757),
                  // minimumSize: const Size(double.infinity,30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontFamily: Fonts.primaryFontFamily,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
