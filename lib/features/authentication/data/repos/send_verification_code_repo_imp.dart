

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:peron_project/core/error/failure.dart';
import 'package:peron_project/features/authentication/data/repos/send_verfication_code_repo.dart';

import '../../../../core/utils/api_service.dart';

class SendVerificationCodeRepoImp implements SendVerificationCodeRepo {
  final ApiService apiService;

  SendVerificationCodeRepoImp({required this.apiService});
  @override
  Future<Either<Failure, String>> sendVerificationCode(String phoneNumber)async {
  try{
    String data=(await apiService.sendVerificationCode(endPoint: 'PhoneNumber/send-verification-code?phoneNumber=$phoneNumber')) as String;
    if (data == "User not found.") {
      return Right("المستخدم غير موجود");
    } else {
      return Right("User found");
    }
  } catch (e) {
    if(e is DioException){
      return left(ServiceFailure.fromDioError(e));
    }
    return left(ServiceFailure(errorMessage: e.toString()));
  }  }


  }
