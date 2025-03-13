import 'package:flutter/material.dart';

import '../../../domain/notification_model.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  notification.title,
                  style: theme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                notification.date,
                style: theme.bodySmall?.copyWith(color: const Color(0xff818181)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            notification.body,
            style: theme.bodySmall,
          ),
        ],
      ),
    );
  }
}
