import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:peron_project/features/authentication/data/repos/signup/signup_repo.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_service.dart';
import '../../models/user_model.dart';

class SignupRepoImp implements SignupRepo {
  final ApiService apiService;

  SignupRepoImp({required this.apiService});

  @override
  Future<Either<Failure, Map<String, dynamic>>> signUp({required Map<String, dynamic> body}) async {
    try {
      final response = await apiService.signup(body: body);

      return response.fold(
            (failure) {
          print("📌 [DEBUG] Failure Details: $failure");
          return Left(failure);
        },
            (data) {
          try {
            print("📌 [DEBUG] Response Data: $data");

            if (data.containsKey("email") || data.containsKey("username")) {
              return Right({
                "user": UserModel.fromJson(data),
                "message": data["message"] ?? "تم التسجيل بنجاح"
              });
            } else {
              return Left(ServiceFailure(
                errorMessage: "الاستجابة لا تحتوي على بيانات المستخدم",
                errors: ["لم يتم العثور على مفتاح 'user' أو 'email' أو 'username' في الاستجابة"],
              ));
            }
                    } catch (e) {
            print("📌 [DEBUG] Error while processing response data: $e");
            return Left(ServiceFailure(
              errorMessage: "خطأ في تنسيق البيانات المستلمة",
              errors: ["فشل في تحليل بيانات المستخدم: ${e.toString()}"],
            ));
          }
        },
      );
    } on DioException catch (e) {
      print("📌 [DEBUG] DioError: $e");
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      print("📌 [DEBUG] Unexpected Error: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء التسجيل",
        errors: [e.toString()],
      ));
    }
  }


  @override
  Future<Either<Failure, String>> sendOtp(String email) async {
    try {
      return await apiService.sendOtp(email);
    } on DioException catch (e) {
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ أثناء إرسال OTP",
        errors: [e.toString()],
      ));
    }
  }
}
