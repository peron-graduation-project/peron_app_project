import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/features/notification/presentation/view/widgets/empty_notification_widget.dart';

import '../../manager/get notifications/notification_cubit.dart';
import '../../manager/get notifications/notification_state.dart';
import '../widgets/notifications_widget.dart';
class NotificationBodyView extends StatefulWidget {
  const NotificationBodyView({super.key});

  @override
  State<NotificationBodyView> createState() => _NotificationBodyViewState();
}

class _NotificationBodyViewState extends State<NotificationBodyView> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        if (state is NotificationStateLoading) {
          return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
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
  }
}


