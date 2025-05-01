
import 'package:flutter/material.dart';

class DateSeparator extends StatelessWidget {
  final double screenWidth;
  final String date;


  const DateSeparator({super.key, required this.screenWidth, required this.date});

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(11)),
        child: Text("اليوم", style: theme.labelSmall!.copyWith(color: Color(0xff7D848D))),
      ),
    );
  }
}
