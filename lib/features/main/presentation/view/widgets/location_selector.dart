import 'package:flutter/material.dart';

import '../../../../../core/helper/colors.dart';
import '../../../../map/presentation/view/views/location_dialog.dart';
import 'notification_button.dart';

class LocationSelector extends StatelessWidget {
  final bool isShown;
  const LocationSelector({super.key,  this.isShown=true});

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
        isShown?NotificationButton():SizedBox(),
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
