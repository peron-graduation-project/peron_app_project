import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manager/get notifications/notification_cubit.dart';
import '../../manager/get notifications/notification_state.dart';
import '../widgets/notifications_widget.dart';
import '../widgets/empty_notification_widget.dart';
import '../widgets/shimmer_notification_placeholder.dart';

class NotificationBodyView extends StatelessWidget {
  final Function(int) onToggleSelection;
  final Set<int> selectedNotifications;
  final bool isSelectionMode;

  const NotificationBodyView({
    super.key,
    required this.onToggleSelection,
    required this.selectedNotifications,
    required this.isSelectionMode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetNotificationCubit, GetNotificationState>(
      bloc: BlocProvider.of<GetNotificationCubit>(context),
      listener: (context, state) {
        if (state is GetNotificationStateFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
              action: SnackBarAction(
                label: 'إعادة المحاولة',
                textColor: Colors.white,
                onPressed: () => context.read<GetNotificationCubit>().getNotifications(),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is GetNotificationStateLoading) {
          return const ShimmerNotificationPlaceholder();
        } else if (state is GetNotificationStateSuccess) {
          return state.notifications.isEmpty
              ? const EmptyNotificationWidget()
              : NotificationsWidget(
            key: ValueKey(state.notifications.length),
            notifications: state.notifications,
            onToggleSelection: onToggleSelection,
            selectedNotifications: selectedNotifications,
            isSelectionMode: isSelectionMode,
          );
        }
        return const EmptyNotificationWidget();
      },
    );
  }
}
