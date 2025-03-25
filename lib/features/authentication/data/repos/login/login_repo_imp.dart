import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/helper/shared_prefs_helper.dart';
import '../../../../../core/network/api_service.dart';
import '../../models/user_model.dart';
import 'login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  final ApiService apiService;
  final SharedPrefsHelper sharedPrefsHelper;

  LoginRepoImpl({required this.apiService, required this.sharedPrefsHelper});

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      final response = await apiService.login(email: email, password: password);

      return await response.fold(
            (failure) async {
          return Left(failure);
        },
            (jsonData) async {
          final userModel = UserModel.fromJson(jsonData);

          if (rememberMe) {
            await sharedPrefsHelper.saveUserCredentials(email, password);
          } else {
            await sharedPrefsHelper.clearUserCredentials();
          }

          return Right(userModel);
        },
      );
    } catch (e) {
      return Left(ServiceFailure(
        errorMessage: e.toString(),
        errors: [e.toString()],
      ));
    }
  }
}
