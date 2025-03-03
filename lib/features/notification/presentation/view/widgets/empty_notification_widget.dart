import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/helper/images.dart';
import '../../../../../core/helper/media_query.dart';

class EmptyNotificationWidget extends StatelessWidget {
  const EmptyNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final screenWidth = MediaQueryHelper.screenWidth;
    final screenHeight = MediaQueryHelper.screenHeight;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.06,
        vertical: screenHeight * 0.03,
      ),
      child: ListView(
        children: [
          SvgPicture.asset(
            Images.notification,
          ),
          SizedBox(height: screenHeight * 0.03),
          Text(
            "لا يوجد إشعارات بعد",
            style: theme.headlineMedium?.copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            "لا يوجد إشعارات بعد",
            style: theme.displaySmall?.copyWith(color: const Color(0xff818181)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
