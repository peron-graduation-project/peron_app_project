import 'package:flutter/material.dart';

class ShowLessButton extends StatelessWidget {
  final double standardPadding;
  final double smallPadding;
  final double smallFontSize;
  final VoidCallback toggleExtendedDetails;

  const ShowLessButton({
    Key? key,
    required this.standardPadding,
    required this.smallPadding,
    required this.smallFontSize,
    required this.toggleExtendedDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: standardPadding,
        vertical: smallPadding,
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: toggleExtendedDetails,
          child: Text(
            'عرض أقل',
            style: TextStyle(
              color: const Color(0xff0F7757),
              fontWeight: FontWeight.bold,
              fontSize: smallFontSize,
            ),
          ),
        ),
      ),
    );
  }
}
