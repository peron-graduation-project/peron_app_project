import 'package:flutter/material.dart';
import 'package:peron_project/features/favourite/presentation/manager/addFavorite/addFavorite_cubit.dart';

class FavoriteManager extends ChangeNotifier {
  final List<Map<String, dynamic>> _favorites = [];

  AddfavoriteCubit? _addFavoriteCubit;

  // تعيين الـ Cubit
  void setCubit(AddfavoriteCubit cubit) {
    _addFavoriteCubit = cubit;
  }

  List<Map<String, dynamic>> get favorites => _favorites;

  // التبديل بين إضافة أو إزالة المفضلة
  void toggleFavorite(Map<String, dynamic> property, String category, String token) {
    print("بدء محاولة إضافة/إزالة عقار من المفضلة");

    final isAlreadyFavorite = _favorites.any(
      (item) => item['id'] == property['id'] && item['source'] == category,
    );

    if (isAlreadyFavorite) {
      print("العقار موجود بالفعل، سيتم حذفه من المفضلة");
      _favorites.removeWhere(
        (item) => item['id'] == property['id'] && item['source'] == category,
      );
      print("تم الحذف");
      // يمكن إضافة الكود لإزالة المفضلة من خلال الـ Cubit هنا إذا كان لديك
    } else {
      print("العقار غير موجود، سيتم إضافته إلى المفضلة");
      _favorites.add({...property, 'source': category});
      print("تمت الإضافة");

      // ✅ استدعاء Cubit للإضافة إلى المفضلة
      if (_addFavoriteCubit != null) {
        // تأكد من أنه يتم إرسال التوكن الصحيح مع المعرف
        _addFavoriteCubit!.addFavorite(
          id: property['id'],
          
        );
      } else {
        print("Cubit غير مُعين.");
      }
    }

    print("قائمة المفضلة الآن: $_favorites");
    notifyListeners();
  }

  // التحقق إذا كان العقار في المفضلة أم لا
  bool isFavorite(Map<String, dynamic> property, String category) {
    return _favorites.any(
      (item) => item['id'] == property['id'] && item['source'] == category,
    );
  }
}
