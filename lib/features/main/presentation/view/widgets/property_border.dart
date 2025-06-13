import 'package:flutter/material.dart';

class PropertyBorder extends StatelessWidget {
  const PropertyBorder({super.key,required this.child, required this.paddingSize});
  final Widget child;
  final double paddingSize;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(paddingSize),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: const Color(0xff7f7f7f66))),
      child: child,

    );
  }
}
