import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/utils/api_service.dart';
import 'login_repo.dart';

class LoginRepoImp implements LoginRepo {
  final ApiService apiService;

  LoginRepoImp({required this.apiService});

  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    try {
      final response = await apiService.login(
        email: email,
        password: password,
      );

      return response.fold(
            (failure) => Left(failure),
            (token) => Right(token),
      );
    } catch (e) {
      return Left(ServiceFailure(errorMessage: e.toString()));
    }
  }
}
