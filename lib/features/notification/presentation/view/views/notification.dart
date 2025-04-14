import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/notification/presentation/view/views/notification_body.dart';
import '../../manager/delete notifications/delete_notification_cubit.dart';
import '../../manager/get notifications/notification_cubit.dart';
import '../widgets/notification_app_bar.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  Set<String> selectedNotifications = {};
  bool isSelectionMode = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetNotificationCubit>(context).getNotifications();
  }

  void _toggleSelection(String notificationId) {
    setState(() {
      if (selectedNotifications.contains(notificationId)) {
        selectedNotifications.remove(notificationId);
      } else {
        selectedNotifications.add(notificationId);
      }
      isSelectionMode = selectedNotifications.isNotEmpty;
    });
  }

  void _deleteSelectedNotifications(BuildContext context) {
    if (selectedNotifications.isNotEmpty) {
      for (var id in selectedNotifications) {
        BlocProvider.of<DeleteNotificationCubit>(context)
            .deleteNotification(id: int.parse(id));
      }
      setState(() {
        selectedNotifications.clear();
        isSelectionMode = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NotificationAppBar(
        onDelete: _deleteSelectedNotifications,
        selectedNotifications: selectedNotifications,
      ),
      body: NotificationBodyView(
        onToggleSelection: _toggleSelection,
        selectedNotifications: selectedNotifications,
        isSelectionMode: isSelectionMode,
      ),
    );
  }
}