import 'package:dartz/dartz.dart';
import 'package:peron_project/core/error/failure.dart';
import 'package:peron_project/core/utils/api_service.dart';
import 'package:peron_project/features/notification/data/repo/get_notification_repo.dart';
import 'package:peron_project/features/notification/domain/notification_model.dart';

class NotificationRepoImp implements NotificationRepo {
  ApiService apiService;

  final List<NotificationModel> _notifications = [
    NotificationModel(id: "1", title: "إعلانك أصبح متاحًا!", body: "تمت الموافقة على إعلانك، وهو الآن مرئي للمستخدمين.", date: "منذ 3 دقائق", isRead: false),
    NotificationModel(id: "2", title: "لا يزال هذا العقار متاحًا!", body: "يبدو أنك مهتم بهذا العقار، هل ترغب في التواصل مع المالك؟", date: "منذ 5 دقائق", isRead: false),
    NotificationModel(id: "3", title: "تم تأجير عقارك!", body: "عقارك في (حي الجامعة) قد تم تأجيره، هل ترغب في إزالة الإعلان؟", date: "منذ ساعة", isRead: true),
    NotificationModel(id: "4", title: "عقارات جديدة متاحة!", body: "تمت إضافة عقارات جديدة في منطقتك، تصفحها الآن!", date: "منذ يوم", isRead: true),
  ];

  NotificationRepoImp({required this.apiService});

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return Right(_notifications);
    } catch (e) {
      return Left(ServiceFailure(errorMessage: "حدث خطأ أثناء تحميل الإشعارات"));
    }
  }

  @override
  Future<Either<Failure, List<NotificationModel>>> deleteNotifications({required List<String> selectedIds}) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      _notifications.removeWhere((notification) => selectedIds.contains(notification.id));
      return Right(_notifications);
    } catch (e) {
      return Left(ServiceFailure(errorMessage: "حدث خطأ أثناء حذف الإشعارات"));
    }
  }
  @override
  Future<Either<Failure, List<NotificationModel>>> markAllAsRead() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      _notifications.replaceRange(
        0, _notifications.length,
        _notifications.map((notification) => notification.copyWith(isRead: true)).toList(),
      );

      return Right(_notifications);
    } catch (e) {
      return Left(ServiceFailure(errorMessage: "حدث خطأ أثناء تحديث الإشعارات"));
    }
  }
}
