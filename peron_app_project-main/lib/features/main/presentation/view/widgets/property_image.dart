import 'package:flutter/material.dart';


class PropertyImage extends StatelessWidget {
  final String image;
  final double itemWidth;

  const PropertyImage({super.key,
    required this.image,
 required this.itemWidth,
  });

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: Image.asset(
        image,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: itemWidth * 0.6,
            color: Colors.grey[300],
            child: const Center(child: Icon(Icons.image_not_supported, size: 50)),
          );
        },
      ),
    );
  }
}
