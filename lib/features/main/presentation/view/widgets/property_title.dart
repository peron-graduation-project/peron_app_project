import 'package:flutter/material.dart';

class PropertyTitle extends StatelessWidget {
  const PropertyTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context).textTheme;
    return Text(
      title,
      style: theme.displayMedium?.copyWith(color: Color(0xff000000)),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
