import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/notification_model.dart';

abstract class NotificationRepo {
  Future<Either<Failure, List<NotificationModel>>> getNotifications();
  Future<Either<Failure, List<NotificationModel>>> deleteNotifications({required List<String> selectedIds});
  Future<Either<Failure, List<NotificationModel>>> markAllAsRead();
}
