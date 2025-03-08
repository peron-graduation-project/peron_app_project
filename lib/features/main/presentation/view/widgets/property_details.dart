import 'package:flutter/material.dart';
import 'package:peron_project/features/main/presentation/view/widgets/property_status.dart';

import '../../../../../core/helper/colors.dart';

class PropertyDetails extends StatelessWidget {
  final Map<String, dynamic> property;
  const PropertyDetails({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(property["location"], style: TextStyle(fontWeight: FontWeight.bold)),
          Row(children: [
            Text("(${property["rating"]})", style: TextStyle(fontSize: 12)),
            ...List.generate(
              5,
                  (i) => Icon(Icons.star, size: 16, color: i < property["rating"] ? AppColors.primaryColor : AppColors.inActiveColor),
            ),
          ]),
          Divider(),
          PropertyStats(property: property),
        ],
      ),
    );
  }
}
