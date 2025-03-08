import 'package:flutter/material.dart';

import '../../../../../core/helper/colors.dart';
import 'notification_button.dart';

class LocationSelector extends StatelessWidget {
  const LocationSelector({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("الموقع", style: theme.labelLarge!.copyWith(fontSize: 25, color: Color(0xff7F7F7F))),
        Row(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              iconSize: 25,
              color: AppColors.primaryColor,
              onPressed: () {},
              icon: Icon(Icons.location_on),
            ),
            Text("قم بتحديد موقعك الحالى", style: theme.bodySmall!.copyWith(color: Color(0xff292828))),
            Spacer(),
            NotificationButton(),
          ],
        ),
      ],
    );
  }
}
