import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helper/colors.dart';
import '../../../../../core/widgets/custom_arrow_back.dart';
import '../../manager/delete notifications/delete_notification_cubit.dart';

class NotificationAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Set<int> selectedNotifications;
  final Function(BuildContext)? onDelete;

  const NotificationAppBar({
    super.key,
    required this.selectedNotifications,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text("الإشعارات", style: theme.headlineMedium!.copyWith(fontSize: 20)),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          thickness: 1,
          height: 1,
          color: AppColors.dividerColor,
        ),
      ),
      leading: const CustomArrowBack(),
      actions: selectedNotifications.isNotEmpty
          ? [
        PopupMenuButton<String>(
          color: AppColors.scaffoldBackgroundColor,
          onSelected: (value) {
            if (value == "delete") {
              if (onDelete != null) {
                onDelete!(context);
              } else {

                if (selectedNotifications.isNotEmpty) {
                  for (var id in selectedNotifications) {
                    BlocProvider.of<DeleteNotificationCubit>(context)
                        .deleteNotification(id: id);
                  }
                }
              }
            }
          },
          icon: const Icon(Icons.do_not_disturb_on_outlined, size: 23, color: Colors.black),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: "delete",
              child: Row(
                children: [
                  Text("حذف", style: theme.labelLarge!.copyWith(color: AppColors.primaryColor)),
                  const Spacer(),
                  Icon(Icons.delete, color: AppColors.primaryColor),
                ],
              ),
            ),
          ],
        ),      ]
          : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}