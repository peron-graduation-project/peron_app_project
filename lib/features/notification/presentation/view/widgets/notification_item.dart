import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';
import '../../../data/notification_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final Function(String) onToggleSelection;
  final bool isSelected;
  final bool isSelectionMode;

  const NotificationItem({
    super.key,
    required this.notification,
    required this.onToggleSelection,
    required this.isSelected,
    required this.isSelectionMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return InkWell(
      onLongPress: () => onToggleSelection(notification.id),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: !isSelected ? Colors.transparent : Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        child: Row(
          children: [
            if (isSelectionMode)
              ValueListenableBuilder<bool>(
                valueListenable: ValueNotifier(isSelected),
                builder: (context, value, child) {
                  return Checkbox(
                    fillColor: WidgetStateProperty.all(Colors.white),
                    checkColor: AppColors.primaryColor,
                    value: value,
                    onChanged: (newValue) => onToggleSelection(notification.id),
                  );
                },
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: theme.bodyMedium?.copyWith(
                            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                          ),
                          maxLines: 2,
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
            ),
          ],
        ),
      ),
    );
  }
}
