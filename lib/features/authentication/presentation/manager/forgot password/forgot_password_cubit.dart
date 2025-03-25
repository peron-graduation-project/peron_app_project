import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/authentication/data/repos/send%20otp/send_repo.dart';
import '../../../data/repos/forget password/forget_password_repo.dart';
import 'forgot_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordRepo forgetPasswordRepo;
  final SendOtpRepo sendOtpRepo;

  ForgetPasswordCubit(this.forgetPasswordRepo, this.sendOtpRepo) : super(ForgetPasswordInitial());

  String? userEmail;

  Future<void> forgetPassword(String email) async {
    emit(ForgetPasswordLoading());
    userEmail = email;

    final result = await forgetPasswordRepo.forgotPassword(email: email);

    result.fold(
          (failure) {
        emit(ForgetPasswordFailure(failure.errorMessage,
        ));
      },
          (message) async {
        emit(ForgetPasswordSuccess(message));
      //  await sendOtpRepo.sendOtp(email);
      },
    );
  }

}
