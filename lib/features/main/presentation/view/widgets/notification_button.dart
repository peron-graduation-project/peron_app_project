import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helper/colors.dart';
import '../../../../../core/navigator/page_routes_name.dart';
import '../../../../notification/presentation/manager/get notifications/notification_cubit.dart';
import '../../../../notification/presentation/manager/get notifications/notification_state.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width * 0.12;

    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        bool hasNewNotifications = false;

        if (state is NotificationStateSuccess) {
          hasNewNotifications =
              state.notifications.any((notification) => !notification.isRead);
        }

        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                alignment: Alignment.center,
              width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                  Border.all(color: Colors.grey.withOpacity(0.3), width: 2),
                  color: Colors.white,
                ),
                child: IconButton(
                  iconSize: size * 0.6,
                  onPressed: () {
                    Navigator.pushNamed(context, PageRouteName.notification);
                  },
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(Icons.notifications, color: AppColors.primaryColor),
                      if (hasNewNotifications)
                        Positioned(
                          top: 0.01,
                          right: 0.01,
                          child: Container(
                            width: size * 0.29,
                            height: size * 0.29,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:AppColors.primaryColor ,
                              border: Border.all(color: Colors.white, width: 3),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
