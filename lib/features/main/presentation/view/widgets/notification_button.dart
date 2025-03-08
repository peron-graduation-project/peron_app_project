import 'package:flutter/material.dart';

import '../../../../../core/helper/colors.dart';
import '../../../../../core/navigator/page_routes_name.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.12;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.withOpacity(0.3), width: 2),
        color: Colors.white,
      ),
      child: Center(
        child: IconButton(
          iconSize: size * 0.6,
          onPressed: () {
            Navigator.pushNamed(
                context, PageRouteName.notification);
          },
          icon: Icon(Icons.notifications, color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
