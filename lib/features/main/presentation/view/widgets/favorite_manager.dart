import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:peron_project/features/favourite/presentation/manager/addFavorite/addFavorite_cubit.dart';
import 'package:peron_project/features/favourite/presentation/manager/deleteFavorite/deleteFavorite_cubit.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';

class FavoriteManager extends ChangeNotifier {
  final List<Map<String, dynamic>> _favorites = [];
  bool _isDataLoaded = false;

  AddfavoriteCubit? _addFavoriteCubit;
  DeletefavoriteCubit? _deleteFavoriteCubit;

  List<Map<String, dynamic>> get favorites => _favorites;
  bool get isDataLoaded => _isDataLoaded;

  void setAddCubit(AddfavoriteCubit cubit) {
    _addFavoriteCubit = cubit;
  }

  void setDeleteCubit(DeletefavoriteCubit cubit) {
    _deleteFavoriteCubit = cubit;
  }

  void addFavorite(RecommendedProperty property, String category) async {
    final exists = _favorites.any(
          (item) => (item['property'] as RecommendedProperty).propertyId == property.propertyId,
    );
    if (exists) return;

    _favorites.add({'property': property, 'category': category});
    notifyListeners();

    _addFavoriteCubit?.addFavorite(id: property.propertyId);
    await _saveToSharedPreferences();
  }

  void removeFavoriteById(int id) async {
    _favorites.removeWhere(
          (item) => (item['property'] as RecommendedProperty).propertyId == id,
    );
    notifyListeners();

    _deleteFavoriteCubit?.deleteFavorite(id: id);
    await _saveToSharedPreferences();
  }

  void toggleFavorite(RecommendedProperty property, String category) {
    final id = property.propertyId;
    final isAlreadyFavorite = _favorites.any(
          (item) => (item['property'] as RecommendedProperty).propertyId == id,
    );

    if (isAlreadyFavorite) {
      removeFavoriteById(id);
    } else {
      addFavorite(property, category);
    }
  }

  bool isFavorite(RecommendedProperty property, String category) {
    return _favorites.any(
          (item) => (item['property'] as RecommendedProperty).propertyId == property.propertyId,
    );
  }

  Future<void> loadFromSharedPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = prefs.getStringList('favorite_properties');

      if (jsonList != null) {
        _favorites.clear();
        for (final jsonString in jsonList) {
          final decoded = jsonDecode(jsonString);
          _favorites.add({
            'property': RecommendedProperty.fromJson(decoded['property']),
            'category': decoded['category'],
          });
        }
        _isDataLoaded = true;
        notifyListeners();
        print("✅ Loaded favorites from SharedPreferences.");
      } else {
        print("❗ No favorite properties found in SharedPreferences.");
      }
    } catch (e) {
      print("❌ Error loading favorites: $e");
    }
  }

  Future<void> _saveToSharedPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jsonList = _favorites.map((item) {
        return jsonEncode({
          'property': (item['property'] as RecommendedProperty).toJson(),
          'category': item['category'],
        });
      }).toList();

      await prefs.setStringList('favorite_properties', jsonList);
      print("💾 Saved favorites to SharedPreferences.");
    } catch (e) {
      print("❌ Error saving favorites: $e");
    }
  }
}
