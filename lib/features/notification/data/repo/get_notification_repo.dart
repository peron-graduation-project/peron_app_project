
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/notification_model.dart';

abstract class GetNotificationRepo
{
  Future<Either<Failure,List<NotificationModel>>> getNotification(String phoneNumber);
}