import 'package:flutter/material.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String image;
  final double screenWidth;

  const ChatAppBar({super.key, required this.name, required this.image, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context).textTheme;
    return AppBar(
      leading: CustomArrowBack(),
      title: Row(
        children: [
          CircleAvatar(backgroundImage: AssetImage(image), radius: screenWidth * 0.06),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: theme.labelLarge!.copyWith(color:Color(0xff282929) )),
              Text("متصل الآن", style: theme.bodySmall!.copyWith(color: Color(0xff818181))),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
