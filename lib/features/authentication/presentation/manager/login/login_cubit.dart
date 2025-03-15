import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/login/login_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;

  LoginCubit({required this.loginRepo}) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    final response = await loginRepo.login(email, password);
    response.fold(
          (failure) => emit(LoginFailure(failure.errorMessage)),
          (token) => emit(LoginSuccess(token)),
    );
  }
}