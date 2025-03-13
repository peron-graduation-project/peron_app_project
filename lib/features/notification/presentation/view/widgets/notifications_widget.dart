import 'package:flutter/material.dart';
import '../../../../../core/helper/media_query.dart';
import '../../../domain/notification_model.dart';
import 'notification_item.dart';

class NotificationsWidget extends StatelessWidget {
  const NotificationsWidget({super.key, required this.notifications});

  final List<NotificationModel> notifications;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQueryHelper.screenWidth;
    final double screenHeight = MediaQueryHelper.screenHeight;

    return ListView.builder(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.02,
        horizontal: screenWidth * 0.05,
      ),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return NotificationItem(notification: notifications[index]);
      },
    );
  }
}

