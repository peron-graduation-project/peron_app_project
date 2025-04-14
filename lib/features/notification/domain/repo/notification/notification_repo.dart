import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../data/notification_model.dart';

abstract class NotificationRepo {
  Future<Either<Failure, List<NotificationModel>>> getNotifications();
 Future<Either<Failure, bool>> deleteNotifications({required int selectedId});

}