import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helper/shared_prefs_helper.dart';
import '../../../data/repos/login/login_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;
  final SharedPrefsHelper prefsHelper;
  bool rememberPassword;

  LoginCubit({
    required this.loginRepo,
    required this.prefsHelper,
    this.rememberPassword = true,
  }) : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(LoginLoading());
    try {
      final response = await loginRepo.login(
        email: email,
        password: password,
        rememberMe: rememberMe,
      );

      response.fold(
            (failure) => emit(LoginFailure(error: failure.errorMessage)),
            (userModel) => emit(LoginSuccess(
          userModel: userModel,
          email: email,
          password: password,
        )),
      );
    } catch (e) {
      emit(LoginFailure(error: "حدث خطأ غير متوقع: $e"));
    }
  }

  Future<void> loadSavedCredentials(
      TextEditingController emailController,
      TextEditingController passwordController,
      ) async {
    final credentials = await prefsHelper.getUserCredentials();

    if (credentials != null) {
      emailController.text = credentials['email'] ?? '';
      passwordController.text = credentials['password'] ?? '';
      emit(LoginCredentialsLoaded(
        email: emailController.text,
        password: passwordController.text,
      ));
    }
  }

  void updateRememberPassword(bool value) {
    rememberPassword = value;
    emit(LoginRememberPasswordUpdated(rememberPassword: rememberPassword));
  }
}
