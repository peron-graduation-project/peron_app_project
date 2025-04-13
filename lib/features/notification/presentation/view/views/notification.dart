import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/notification/presentation/manager/delete%20notifications/delete_notification_cubit.dart';
import 'package:peron_project/features/notification/presentation/view/views/notification_body.dart';
import '../../../../../core/network/api_service.dart';
import '../../../domain/repo/get%20notification/notification_repo_imp.dart';
import '../widgets/notification_app_bar.dart';
import 'package:dio/dio.dart';

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

  void _deleteSelectedNotifications(BuildContext context) {
    if (selectedNotifications.isNotEmpty) {
      selectedNotifications.forEach((id) {
        BlocProvider.of<DeleteNotificationCubit>(context)
            .deleteNotification(id: int.parse(id));
      });
      setState(() {
        selectedNotifications.clear();
        isSelectionMode = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeleteNotificationCubit>(
      create: (context) => DeleteNotificationCubit(
        NotificationRepoImpl(ApiService(Dio())),
      ),
      child: Scaffold(
        appBar: NotificationAppBar(
          onDelete: _deleteSelectedNotifications,
          selectedNotifications: selectedNotifications,
        ),
        body: NotificationBodyView(
          onToggleSelection: _toggleSelection,
          selectedNotifications: selectedNotifications,
          isSelectionMode: isSelectionMode,
        ),
      ),
    );
  }
}