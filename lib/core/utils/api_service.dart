import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:peron_project/features/notification/domain/notification_model.dart';
import '../../../../core/error/failure.dart';

class ApiService {
  final String _baseUrl = 'https://sakaniapi1.runasp.net/api/';
  final Dio _dio;

  ApiService(this._dio);

  Future<Either<Failure, String>> sendVerificationCode({
    required String endPoint,
    Map<String, dynamic>? body,
  }) async {
    try {
      var response = await _dio.post('$_baseUrl$endPoint', data: body);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(ServiceFailure.fromDioError(e));
    }
  }

  Future<Either<Failure, List<NotificationModel>>> getNotifications({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await _dio.get('$_baseUrl$endPoint', queryParameters: queryParameters);
      List<dynamic> data = response.data;
      List<NotificationModel> notifications = data.map((json) => NotificationModel.fromJson(json)).toList();
      return Right(notifications);
    } on DioException catch (e) {
      return Left(ServiceFailure.fromDioError(e));
    }
  }

  Future<Either<Failure, bool>> deleteNotifications({
    required String endPoint,
    required List<String> ids,
  }) async {
    try {
      Response response = await _dio.delete('$_baseUrl$endPoint', data: {"ids": ids});
      return Right(response.statusCode == 200);
    } on DioException catch (e) {
      return Left(ServiceFailure.fromDioError(e));
    }
  }
}
