import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../../core/helper/colors.dart';
import '../../../../../core/widgets/custom_arrow_back.dart';
import '../../manager/get notifications/notification_cubit.dart';
import '../../manager/get notifications/notification_state.dart';

class NotificationAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Set<int> selectedNotifications;
  final Function() onDelete;

  const NotificationAppBar({
    super.key,
    required this.selectedNotifications,
    required this.onDelete,
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
      actions: [
        BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state is NotificationStateSuccess && state.notifications.isNotEmpty) {
              return PopupMenuButton<String>(
                color: AppColors.scaffoldBackgroundColor,
                onSelected: (value) {
                  if (value == "delete" && selectedNotifications.isNotEmpty) {
                    onDelete();
                  }
                },
                icon: Icon(Icons.do_not_disturb_on_outlined, size: 23, color: Colors.black),
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
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
