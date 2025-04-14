import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../data/notification_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final Function(int) onToggleSelection;
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
      onLongPress: () => onToggleSelection(notification.id ),
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
                    onChanged: (newValue) => onToggleSelection(notification.id ),
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
                          notification.message,
                          style: theme.bodyMedium,
                        ),
                      ),
                      Text(
                        notification.createdAt != null
                            ? () {
                          if (notification.createdAt is String) {
                            final parsedDateTime = DateTime.tryParse(notification.createdAt as String);
                            if (parsedDateTime != null) {
                              return timeago.format(parsedDateTime, locale: 'ar');
                            } else {
                              print("⚠️ [WARNING] Failed to parse createdAt (String): ${notification.createdAt}");
                              return '';
                            }
                          } else if (notification.createdAt is DateTime) {
                            return timeago.format(notification.createdAt!, locale: 'ar');
                          } else if (notification.createdAt is int) {
                            return timeago.format(DateTime.fromMillisecondsSinceEpoch(notification.createdAt as int), locale: 'ar');
                          } else {
                            print("⚠️ [WARNING] Unknown createdAt type: ${notification.createdAt.runtimeType}, value: ${notification.createdAt}");
                            return '';
                          }
                        }()
                            : '',
                        style: theme.bodySmall?.copyWith(color: const Color(0xff818181)),
                      ),
                    ],
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