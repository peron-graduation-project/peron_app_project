import 'package:flutter/material.dart';
import 'package:peron_project/features/main/presentation/view/widgets/favorite_manager.dart';
import 'package:provider/provider.dart';
import '../../../../../core/helper/colors.dart';

class CustomFavouriteIcon extends StatelessWidget {
  final Map<String, dynamic> property;
  final String category;

  const CustomFavouriteIcon({
    super.key,
    required this.property,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth > 400 ? 30.0 : 24.0;
    double positionOffset = screenWidth > 400 ? 12.0 : 8.0;

    return Positioned(
      top: positionOffset,
      left: positionOffset,
      child: GestureDetector(
        onTap: () {
          debugPrint(" Toggling favorite for: ${property['title']} (ID: ${property['id']}) in category: $category");
          Provider.of<FavoriteManager>(context, listen: false).toggleFavorite(property,category ) ;
        },
        child: Consumer<FavoriteManager>(
          builder: (context, favoriteManager, child) {
            bool isFavorite = favoriteManager.isFavorite(property,category );
            debugPrint(" UI Updated: ${property['title']} isFavorite = $isFavorite");

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                key: ValueKey<bool>(isFavorite),
                color: isFavorite ? AppColors.primaryColor : Colors.white,
                size: iconSize,
              ),
            );
          },
        ),
      ),
    );
  }
}
