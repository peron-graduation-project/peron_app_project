import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:peron_project/core/error/failure.dart';
import 'package:peron_project/features/authentication/data/repos/signup/signup_repo.dart';

import '../../../../../core/utils/api_service.dart';

class SignupRepoImpl implements SignupRepo {
  final ApiService apiService;

  SignupRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, String>> signup({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final result = await apiService.signup(
        endPoint: 'Auth/register',
        body: {
          "fullName": fullName,
          "email": email,
          "phoneNumber": phoneNumber,
          "password": password,
          "confirmPassword": confirmPassword,
        },
      );

      return result.fold(
            (failure) => Left(failure),
            (data) {
          if (data["message"] == "User registered successfully") {
            return Right("تم التسجيل بنجاح!");
          } else {
            return Left(ServiceFailure(errorMessage: data["message"] ?? "حدث خطأ أثناء التسجيل!"));
          }
        },
      );
    } catch (e) {
      if (e is DioException) {
        return Left(ServiceFailure.fromDioError(e));
      }
      return Left(ServiceFailure(errorMessage: e.toString()));
    }
  }
}
