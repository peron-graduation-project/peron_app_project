import 'package:flutter/material.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/favourite/presentation/manager/addFavorite/addFavorite_cubit.dart';
import 'package:peron_project/features/favourite/presentation/manager/deleteFavorite/deleteFavorite_cubit.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';

class FavoriteManager extends ChangeNotifier {
  final List<Map<String, dynamic>> _favorites = [];

  AddfavoriteCubit? _addFavoriteCubit;
  DeletefavoriteCubit? _deleteFavoriteCubit;


  void setAddCubit(AddfavoriteCubit cubit) {
    _addFavoriteCubit = cubit;
  }

  void setDeleteCubit(DeletefavoriteCubit cubit) {
    _deleteFavoriteCubit = cubit;
  }

  List<Map<String, dynamic>> get favorites => _favorites;


  void addFavorite(RecommendedProperty property, String category) {
    _favorites.add({'property': property, 'category': category});
    notifyListeners();

    if (_addFavoriteCubit != null) {
      _addFavoriteCubit!.addFavorite(id: property.propertyId);
    }
  }

  void removeFavoriteById(int id) {
    _favorites.removeWhere((item) => (item['property'] as Property).propertyId == id);
    notifyListeners();

    if (_deleteFavoriteCubit != null) {
      _deleteFavoriteCubit!.deleteFavorite(id: id);
    }
  }

  void toggleFavorite(RecommendedProperty property, String category) {
    final id = property.propertyId;
    final isAlreadyFavorite = _favorites.any(
          (item) => (item['property'] as Property).propertyId == id,
    );

    if (isAlreadyFavorite) {
      removeFavoriteById(id);
    } else {
      addFavorite(property, category);
    }
  }


  bool isFavorite(RecommendedProperty property, String category) {
    return _favorites.any(
          (item) => (item['property'] as Property).propertyId == property.propertyId ,
    );
  }
}