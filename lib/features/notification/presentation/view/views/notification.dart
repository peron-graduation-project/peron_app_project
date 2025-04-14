import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/notification/presentation/view/views/notification_body.dart';
import 'package:peron_project/features/notification/presentation/view/widgets/shimmer_notification_placeholder.dart';
import '../../../../../core/network/api_service.dart';
import '../../../domain/repo/notification/notification_repo_imp.dart';
import '../../manager/delete notifications/delete_notification_cubit.dart';
import '../../manager/delete notifications/delete_notification_state.dart';
import '../../manager/get notifications/notification_cubit.dart';
import '../widgets/notification_app_bar.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteNotificationCubit(
        NotificationRepoImpl(ApiService(Dio())),
      ),
      child: _NotificationViewContent(),
    );
  }
}

class _NotificationViewContent extends StatefulWidget {
  const _NotificationViewContent();

  @override
  State<_NotificationViewContent> createState() => _NotificationViewContentState();
}

class _NotificationViewContentState extends State<_NotificationViewContent> {
  Set<int> selectedNotifications = {};
  bool isSelectionMode = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetNotificationCubit>(context).getNotifications();
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

  void _deleteSelectedNotifications(BuildContext context) {
    if (selectedNotifications.isNotEmpty) {
      for (var id in selectedNotifications) {
        BlocProvider.of<DeleteNotificationCubit>(context)
            .deleteNotification(id: id);
      }
      setState(() {
        selectedNotifications.clear();
        isSelectionMode = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DeleteNotificationCubit, DeleteNotificationState>(
          listener: (context, state) {
            if (state is DeleteNotificationStateSuccess) {
              BlocProvider.of<GetNotificationCubit>(context).getNotifications();
            } else if (state is DeleteNotificationStateFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('حدث خطأ أثناء الحذف: ${state.errorMessage}')),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: NotificationAppBar(
          onDelete: _deleteSelectedNotifications,
          selectedNotifications: selectedNotifications,
        ),
        body: BlocBuilder<DeleteNotificationCubit, DeleteNotificationState>(
          builder: (context, state) {
            if (state is DeleteNotificationStateLoading && selectedNotifications.isNotEmpty) {
              return ShimmerNotificationPlaceholder();
            } else {
              return NotificationBodyView(
                onToggleSelection: _toggleSelection,
                selectedNotifications: selectedNotifications,
                isSelectionMode: isSelectionMode,
              );
            }
          },
        ),
      ),
    );
  }
}