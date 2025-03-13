import 'package:flutter/material.dart';
import '../../../domain/notification_model.dart';
import 'notification_item.dart';

class NotificationsWidget extends StatelessWidget {
  final List<NotificationModel> notifications;
  final Function(String) onToggleSelection;
  final Set<String> selectedNotifications;
  final bool isSelectionMode;

  const NotificationsWidget({
    super.key,
    required this.notifications,
    required this.onToggleSelection,
    required this.selectedNotifications,
    required this.isSelectionMode,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return ListView.builder(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.02,
        horizontal: screenWidth * 0.05,
      ),
      itemCount: notifications.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        final isSelected = selectedNotifications.contains(notification.id);
        return NotificationItem(
          notification: notification,
          onToggleSelection: onToggleSelection,
          isSelected: isSelected,
          isSelectionMode: isSelectionMode,
        );
      },
    );
  }
}
