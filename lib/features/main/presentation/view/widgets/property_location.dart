import 'package:flutter/material.dart';

import '../../../../../core/helper/colors.dart';

class PropertyLocation extends StatelessWidget {
  const PropertyLocation({super.key, required this.location, required this.iconSize});
 final String location;
 final double iconSize;

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.location_on, color: AppColors.primaryColor, size: iconSize * 0.8),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
           location,
            style: theme.bodySmall!.copyWith(color: const Color(0xff282929)),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
