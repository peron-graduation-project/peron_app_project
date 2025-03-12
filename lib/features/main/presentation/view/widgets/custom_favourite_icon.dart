import 'package:flutter/material.dart';

import '../../../../../core/helper/colors.dart';

class CustomFavouriteIcon extends StatefulWidget {
  const CustomFavouriteIcon({super.key, required this.iconSize});
  final double iconSize;


  @override
  State<CustomFavouriteIcon> createState() => _CustomFavouriteIconState();
}

class _CustomFavouriteIconState extends State<CustomFavouriteIcon> {
  bool isFavorite = false;


  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      left: 8,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        },
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? AppColors.primaryColor : Colors.white,
          size: widget.iconSize,
        ),
      ),
    )
    ;
  }
}
