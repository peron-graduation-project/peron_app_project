import 'package:flutter/material.dart';

import '../../../../../core/helper/colors.dart';
import '../../../../../core/widgets/custom_arrow_back.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String image;
  final double screenWidth;

  const ChatAppBar({super.key, required this.name, required this.image, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context).textTheme;
    return AppBar(
      titleSpacing: 0,
      leading: CustomArrowBack(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: screenWidth * 0.06,
            backgroundColor: Colors.grey[300],
            backgroundImage:
            image.isNotEmpty
                ? NetworkImage(image)
                : AssetImage(
              "assets/images/no pic.jpg",
            )
            as ImageProvider,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: theme.labelLarge!.copyWith(color:Color(0xff282929) )),
            //  Text("متصل الآن", style: theme.bodySmall!.copyWith(color: Color(0xff818181))),
            ],
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          thickness: 1,
          height: 1,
          color: AppColors.dividerColor,
        ),
      ),

    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
