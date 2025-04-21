import 'package:flutter/material.dart';

class PropertyRating extends StatelessWidget {
  final double rating;
  final double iconSize;
  const PropertyRating({super.key, required this.rating, required this.iconSize});

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context).textTheme;
    return Row(
      children: [
        Text("($rating)", style: theme.displayMedium?.copyWith(color: Color(0xff292828))),
        ...List.generate(
          5,
              (i) => Icon(
            Icons.star,
            size: iconSize * 0.8,
            color: i < rating ? const Color(0xFF0F7757) : Colors.grey,
          ),
        ),
      ],
    );
  }
}
