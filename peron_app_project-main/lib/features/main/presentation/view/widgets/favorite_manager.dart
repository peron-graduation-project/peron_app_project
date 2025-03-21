import 'package:flutter/material.dart';

class FavoriteManager extends ChangeNotifier {
  final List<Map<String, dynamic>> _mostRentFavorites = [];
  final List<Map<String, dynamic>> _recommendedFavorites = [];

  List<Map<String, dynamic>> get mostRentFavorites => _mostRentFavorites;
  List<Map<String, dynamic>> get recommendedFavorites => _recommendedFavorites;

  void toggleFavorite(Map<String, dynamic> property, String category) {
    if (category == "most_rent") {
      if (isFavorite(property, category)) {
        _mostRentFavorites.removeWhere((item) => item['id'] == property['id']);
      } else {
        _mostRentFavorites.add(property);
      }
    } else if (category == "recommended") {
      if (isFavorite(property, category)) {
        _recommendedFavorites.removeWhere((item) => item['id'] == property['id']);
      } else {
        _recommendedFavorites.add(property);
      }
    }
    debugPrint(" Total Most Rent Favorites: ${_mostRentFavorites.length}");
    debugPrint(" Total Recommended Favorites: ${_recommendedFavorites.length}");
      debugPrint("Most Rent Favorites: ${_mostRentFavorites.map((e) => e['id']).toList()}");
debugPrint("Recommended Favorites: ${_recommendedFavorites.map((e) => e['id']).toList()}");
   
    notifyListeners();
  }

  bool isFavorite(Map<String, dynamic> property, String category) {
    if (category == "most_rent") {
      return _mostRentFavorites.any((item) => item['id'] == property['id']);
    } else if (category == "recommended") {
      return _recommendedFavorites.any((item) => item['id'] == property['id']);
    }
    return false;
  }
}