import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/notification/presentation/view/views/notification_body.dart';
import 'package:peron_project/features/notification/presentation/view/widgets/shimmer_notification_placeholder.dart';
import '../../manager/get notifications/notification_cubit.dart';
import '../../manager/get notifications/notification_state.dart';
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

  void _deleteSelectedNotifications(BuildContext context) {
    if (selectedNotifications.isNotEmpty) {
      context.read<NotificationCubit>().deleteNotifications(selectedIds: selectedNotifications.toList());
      setState(() {
        selectedNotifications.clear();
        isSelectionMode = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationState>(
      listener: (context, state) {
        if (state is NotificationStateFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: NotificationAppBar(
            onDelete: () => _deleteSelectedNotifications(context),
            selectedNotifications: selectedNotifications,
          ),
          body: state is NotificationStateLoading
              ? ShimmerNotificationPlaceholder()
              : NotificationBodyView(
            onToggleSelection: _toggleSelection,
            selectedNotifications: selectedNotifications,
            isSelectionMode: isSelectionMode,
          ),
        );
      },
    );
  }
}