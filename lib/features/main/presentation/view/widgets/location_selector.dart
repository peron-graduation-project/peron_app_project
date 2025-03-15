import 'package:flutter/material.dart';

import '../../../../../core/helper/colors.dart';
import '../../../../map/views/location_dialog.dart';
import 'notification_button.dart';

class LocationSelector extends StatelessWidget {
  const LocationSelector({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return  Row(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          iconSize: 25,
          color: AppColors.primaryColor,
          onPressed: (){
            _showLocationDialog(context);
          },

          icon: Icon(Icons.location_on),
        ),
        Text("قم بتحديد موقعك الحالى", style: theme.bodySmall!.copyWith(color: Color(0xff292828))),
        Spacer(),
        NotificationButton(),
      ],
    );
  }
  Future<void> _showLocationDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LocationDialog();
      },
    );
  }

}
