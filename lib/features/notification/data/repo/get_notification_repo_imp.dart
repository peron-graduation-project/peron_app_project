import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:peron_project/core/error/failure.dart';
import 'package:peron_project/features/notification/data/repo/get_notification_repo.dart';
import 'package:peron_project/features/notification/domain/notification_model.dart';
import '../../../../core/utils/api_service.dart';

class GetNotificationRepoImp implements GetNotificationRepo {
  final ApiService apiService;

  GetNotificationRepoImp({required this.apiService});

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotification(String phoneNumber) async {
    try {
      var response = await apiService.getNotification(
        endPoint: 'notifications?phoneNumber=$phoneNumber',
      );

      List<NotificationModel> notifications =
      response.map((item) => NotificationModel.fromJson(item as Map<String, dynamic>)).toList();

      return Right(notifications);
        } catch (e) {
      if (e is DioException) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(errorMessage: e.toString()));
    }
  }
}
