import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/notification/presentation/view/views/notification_body.dart';
import '../../../../../core/utils/api_service.dart';
import '../../../data/repo/get_notification_repo_imp.dart';
import '../../manager/get notifications/notification_cubit.dart';
import '../widgets/notification_app_bar.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  Set<int> selectedNotifications = {};
  bool isSelectionMode = false;

  void _deleteSelectedNotifications() {
    setState(() {
      selectedNotifications.clear();
      isSelectionMode = false;
    });
  }

  void _toggleSelection(int notificationId) {
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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit(GetNotificationRepoImp(apiService: ApiService(Dio()))),
      child: Scaffold(
        appBar: NotificationAppBar(
          onDelete: _deleteSelectedNotifications,
          selectedNotifications: selectedNotifications,
        ),
        body: NotificationBodyView(),
      ),
    );
  }
}
