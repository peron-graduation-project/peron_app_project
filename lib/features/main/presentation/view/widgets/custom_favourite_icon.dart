import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/features/favourite/presentation/manager/addFavorite/addFavorite_cubit.dart';
import 'package:peron_project/features/favourite/presentation/manager/addFavorite/addFavorite_state.dart';
import 'package:peron_project/features/favourite/presentation/manager/deleteFavorite/deleteFavorite_cubit.dart';
import 'package:peron_project/features/favourite/presentation/manager/deleteFavorite/deleteFavorite_state.dart';
import 'package:peron_project/features/main/presentation/view/widgets/favorite_manager.dart';
import 'package:provider/provider.dart';
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
      child: BlocListener<AddfavoriteCubit, AddfavoriteState>(
        listener: (context, state) {
          if (state is AddFavoriteSuccess) {
            debugPrint("تمت إضافة العقار إلى المفضلة");
          } else if (state is AddFavoriteFailuer) {
            debugPrint("فشل إضافة العقار: ${state.errorMessage}");
          }
        },
        child: BlocListener<DeletefavoriteCubit, DeletefavoriteState>(
          listener: (context, state) {
            if (state is DeleteFavoriteSuccess) {
              debugPrint("تم إزالة العقار من المفضلة");
            } else if (state is DeleteFavoriteFailuer) {
              debugPrint("فشل إزالة العقار: ${state.errorMessage}");
            }
          },
          child: Consumer<FavoriteManager>(
            builder: (context, favoriteManager, child) {
              bool isFavorite = favoriteManager.isFavorite(property, category);

              return GestureDetector(
                onTap: () async {
                  if (isFavorite) {
                    // إزالة من المفضلة
                    context.read<DeletefavoriteCubit>().deleteFavorite(id: property['id']);
                    favoriteManager.removeFavoriteById(property['id']);
                    debugPrint("Removed from favorites: ${property['title']}");
                  } else {
                    // إضافة إلى المفضلة
                    context.read<AddfavoriteCubit>().addFavorite(id: property['id']);
                    favoriteManager.addFavorite(property, category);
                    debugPrint("Added to favorites: ${property['title']}");
                  }
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    key: ValueKey<bool>(isFavorite),
                    color: isFavorite ? AppColors.primaryColor : Colors.white,
                    size: iconSize,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
