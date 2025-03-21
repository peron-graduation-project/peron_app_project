import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/authentication/presentation/manager/signup/signup_state.dart';

import '../../../data/repos/signup/signup_repo.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepo signupRepo;

  SignupCubit(this.signupRepo) : super(SignupInitial());

  Future<void> signup({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    emit(SignupLoading());

    final result = await signupRepo.signup(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      confirmPassword: confirmPassword,
    );

    result.fold(
          (failure) => emit(SignupFailure(errorMessage: failure.errorMessage)),
          (message) => emit(SignupSuccess(message: message)),
    );
  }
}
