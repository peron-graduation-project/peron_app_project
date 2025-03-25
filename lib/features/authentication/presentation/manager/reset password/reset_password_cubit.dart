import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/authentication/data/repos/reset%20password/reset_password_repo.dart';
import 'package:peron_project/features/authentication/data/repos/send%20otp/send_repo.dart';
import 'package:peron_project/features/authentication/presentation/manager/reset%20password/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordRepo resetPasswordRepo;
  final SendOtpRepo sendOtpRepo;

  ResetPasswordCubit(
      this.resetPasswordRepo,
      this.sendOtpRepo,
      ) : super(ResetPasswordInitial());

  String? userEmail;
  String? userOtpCode;

  Future<void> resetPassword({
    required String email,
    required String otpCode,
    required String password,
    required String confirmedPassword,
  }) async {
    emit(ResetPasswordLoading());

    userEmail = email;
    userOtpCode = otpCode;

    final result = await resetPasswordRepo.resetPassword(
      body: {
        "email": email,
        "otpCode": otpCode,
        "newPassword": password,
        "confirmPassword": confirmedPassword,
      }
    );

    result.fold(
          (failure) {
        emit(ResetPasswordFailure(failure.errorMessage));
      },
          (message) async {
        emit(ResetPasswordSuccess(message));
      },
    );
  }
}
