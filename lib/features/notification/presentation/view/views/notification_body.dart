import 'package:flutter/material.dart';
import 'package:peron_project/features/notification/presentation/view/widgets/empty_notification_widget.dart';
class NotificationBodyView extends StatelessWidget {
  const NotificationBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyNotificationWidget();
  }
}
/*
BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        if (state is NotificationStateLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is NotificationStateSuccess) {
          print(state.notifications);
          return state.notifications.isEmpty
              ? EmptyNotificationWidget()
              : NotificationsWidget(notifications:state.notifications);
        } else if (state is NotificationStateFailure) {
          return Center(child: Text(state.errorMessage, style: TextStyle(color: Colors.red)));
        }
        return Container();
      },
    );
 */