import 'package:flutter/material.dart';

import 'location_selector.dart';

class LocationNotificationHeader extends StatelessWidget {
  const LocationNotificationHeader({super.key,});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("الموقع", style: theme.labelLarge!.copyWith(fontSize: 25, color: Color(0xff7F7F7F))),
       LocationSelector(),
      ],
    );
  }

}
