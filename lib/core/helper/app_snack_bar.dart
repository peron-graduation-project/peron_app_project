import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:peron_project/core/helper/colors.dart';

class AppSnackBar {
  static void showFromTop({
    required BuildContext context,
    required String title,
    required String message,
    required ContentType contentType,
    Duration duration = const Duration(seconds: 4),
  }) {
    final overlay = Overlay.of(context);

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 16,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: AwesomeSnackbarContent(
            title: title,
            message: message,
            contentType: contentType,
            color: _getColorByType(contentType),
            inMaterialBanner: true,
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }

  static Color _getColorByType(ContentType type) {
    switch (type) {
      case ContentType.success:
        return AppColors.primaryColor;
      case ContentType.failure:
        return const Color(0xFFD32F2F);
      case ContentType.warning:
        return const Color(0xFFFFA000);
      case ContentType.help:
        return const Color(0xFF1976D2);
      default:
        return AppColors.primaryColor.withOpacity(0.8);
    }
  }
}
