import 'package:flutter/material.dart';

class FavoriteManager extends ChangeNotifier {
  final List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;

  void toggleFavorite(Map<String, dynamic> property, String category) {
    print("بدء محاولة إضافة/إزالة عقار من المفضلة");
    print("العقار: $property");
    print("القسم: $category");

    final isAlreadyFavorite = _favorites.any((item) => item['id'] == property['id'] && item['source'] == category);

    if (isAlreadyFavorite) {
      print("العقار موجود بالفعل في المفضلة، سيتم حذفه");
      _favorites.removeWhere((item) => item['id'] == property['id'] && item['source'] == category);
      print("تم حذف العقار");
    } else {
      print("العقار غير موجود في المفضلة، سيتم إضافته");
      _favorites.add({...property, 'source': category});
      print("تم إضافة العقار");
    }
    print("قائمة المفضلة الآن: $_favorites");
    notifyListeners();
    print("تم إعلام المستمعين بالتغيير");
  }
  bool isFavorite(Map<String, dynamic> property, String category) {
    return _favorites.any((item) => item['id'] == property['id'] && item['source'] == category);
  }
}