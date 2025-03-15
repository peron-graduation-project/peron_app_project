import 'package:flutter/material.dart';
import 'package:peron_project/features/main/presentation/view/widgets/favorite_manager.dart';
import 'package:provider/provider.dart';
import '../../../../../core/helper/colors.dart';

class CustomFavouriteIcon extends StatelessWidget {
  final double iconSize;
  final Map<String, dynamic> property;
  final String category;

  const CustomFavouriteIcon({
    super.key,
    required this.iconSize,
    required this.property,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      left: 8,
      child: GestureDetector(
      onTap: () {
  debugPrint(" Toggling favorite for: ${property['title']} (ID: ${property['id']}) in category: $category");
  Provider.of<FavoriteManager>(context, listen: false).toggleFavorite(property, category);
},
        child: Consumer<FavoriteManager>(
          builder: (context, favoriteManager, child) {
            bool isFavorite = favoriteManager.isFavorite(property, category);
            debugPrint(" UI Updated: ${property['title']} isFavorite = $isFavorite");

            return Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? AppColors.primaryColor : Colors.white,
              size: iconSize,
            );
          },
        ),
      ),
    );
  }
}