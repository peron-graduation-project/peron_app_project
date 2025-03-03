import 'package:flutter/material.dart';
import '../../../../../core/helper/media_query.dart';
import '../../../domain/notification_model.dart';

class NotificationsWidget extends StatelessWidget {
  const NotificationsWidget({super.key, required this.notifications});
  final List<NotificationModel> notifications;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final double screenWidth = MediaQueryHelper.screenWidth;
    final double screenHeight = MediaQueryHelper.screenHeight;

    return ListView.builder(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.02,
        horizontal: screenWidth * 0.05,
      ),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.015,
              horizontal: screenWidth * 0.04,
            ),
            leading: Icon(
              Icons.notifications,
              color: Colors.blue,
              size: screenWidth * 0.08,
            ),
            title: Text(
              notifications[index].title,
              style: theme.bodyLarge?.copyWith(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              notifications[index].date,
              style: theme.bodyMedium?.copyWith(
                fontSize: screenWidth * 0.035,
                color: Colors.grey,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: screenWidth * 0.05,
            ),
          ),
        );
      },
    );
  }
}
