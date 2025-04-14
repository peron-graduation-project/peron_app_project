import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/api_service.dart';
import '../../../data/notification_model.dart';
import 'notification_repo.dart';


class NotificationRepoImpl implements NotificationRepo {
  final ApiService apiService;

  NotificationRepoImpl(this.apiService);

  @override
  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لجلب الإشعارات",
          errors: ["التوكين غير موجود"],
        ));
      }

      final Either<Failure, List<NotificationModel>> response = await apiService.getNotification(token: token); // توقعنا إن الـ ApiService هيرجع List<NotificationModel>

      print("✅ [DEBUG] NotificationRepoImp Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in Notification Repo: $failure");
          return Left(failure);
        },
            (notifications) {
          print("✅✅✅ [DEBUG] Notifications received from ApiService: $notifications");
          return Right(notifications);
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in NotificationRepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب الإشعارات",
        errors: [e.toString()],
      ));
    }
  }
  @override
  Future<Either<Failure, bool>> deleteNotifications({required int selectedId}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لحذف الإشعارات",
          errors: ["التوكين غير موجود"],
        ));
      }

      final response = await apiService.deleteNotification(token: token, id: selectedId);

      print("✅ [DEBUG] NotificationRepoImp Delete Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in Delete Notification Repo: $failure");
          return Left(failure);
        },
            (success) {
          return const Right(true);
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in Delete Notification Repo: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء حذف الإشعار",
        errors: [e.toString()],
      ));
    }
  }
}