import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';

class PropertyImage extends StatelessWidget {
  final String? imageUrl;
  final double itemWidth;

  const PropertyImage({
    super.key,
    required this.imageUrl,
    required this.itemWidth,
  });

  @override
  Widget build(BuildContext context) {
    final bool isValidUrl = imageUrl != null && imageUrl!.trim().isNotEmpty;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: isValidUrl
          ? Image.network(
        imageUrl!,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _placeholder();
        },
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Container(
            height: itemWidth * 0.6,
            color: Colors.grey[300],
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      )
          : _placeholder(),
    );
  }

  Widget _placeholder() {
    return Container(
      height: itemWidth * 0.6,
      color: Colors.grey[300],
      child: const Center(child: Icon(Icons.image_not_supported, size: 50)),
    );
  }
}
