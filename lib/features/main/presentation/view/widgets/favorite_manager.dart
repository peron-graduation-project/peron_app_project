import 'package:flutter/material.dart';
import 'package:peron_project/features/favourite/presentation/manager/addFavorite/addFavorite_cubit.dart';
import 'package:peron_project/features/favourite/presentation/manager/deleteFavorite/deleteFavorite_cubit.dart';

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


  void addFavorite(Map<String, dynamic> property, String category) {
    _favorites.add({...property, 'source': category});
    notifyListeners();

    if (_addFavoriteCubit != null) {
      _addFavoriteCubit!.addFavorite(id: property['id']);
    }
  }

  void removeFavoriteById(int id) {
    _favorites.removeWhere((item) => item['id'] == id);
    notifyListeners();

    if (_deleteFavoriteCubit != null) {
      _deleteFavoriteCubit!.deleteFavorite(id: id);
    }
  }

  void toggleFavorite(Map<String, dynamic> property, String category) {
    final id = property['id'];
    final isAlreadyFavorite = _favorites.any(
      (item) => item['id'] == id && item['source'] == category,
    );

    if (isAlreadyFavorite) {
      removeFavoriteById(id);
    } else {
      addFavorite(property, category);
    }
  }

  
  bool isFavorite(Map<String, dynamic> property, String category) {
    return _favorites.any(
      (item) => item['id'] == property['id'] && item['source'] == category,
    );
  }
}
