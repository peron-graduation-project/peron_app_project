import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/notification/presentation/view/views/notification_body.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<GetNotificationCubit>().getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NotificationAppBar(
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