import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/authentication/presentation/manager/signup/signup_state.dart';
import '../../../../../core/error/failure.dart';
import '../../../data/repos/send otp/send_repo.dart';
import '../../../data/repos/signup/signup_repo.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepo authRepo;
  final SendOtpRepo sendRepo;
  String? userEmail;

  SignupCubit(this.authRepo, this.sendRepo) : super(SignupInitial());

  Future<void> signUp({
    required String username,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    emit(SignupLoading());

    try {
      final result = await authRepo.signUp(body: {
        "fullName": username,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
        "confirmPassword": confirmPassword,
      });

      result.fold(
            (failure) {
          String errorMessage = "حدث خطأ أثناء التسجيل";
          List<String> errors = [];

          if (failure is ServiceFailure) {
            errorMessage = failure.errorMessage;
            errors = failure.errors;
          }

          print(" [DEBUG] Failure Details: $failure");
          print(" [DEBUG] Extracted Errors: $errors");

          if (errors.isEmpty) {
            emit(SignupSuccess("تم التسجيل بنجاح"));
          } else {
            emit(SignupFailure(
              errorMessage: errorMessage,
              errors: errors,
            ));
          }
        },
            (data) async {
          userEmail = email;
          String message = data["message"] ?? "تم التسجيل بنجاح";
          List errors = data["errors"] ?? [];

          print("📌 [DEBUG] Signup Success: $message");

          if (errors.isEmpty) {
            emit(SignupSuccess(message));
          //  await sendRepo.sendOtp(email);
          } else {
            emit(SignupFailure(
              errorMessage: "حدث خطأ أثناء التسجيل، حاول مرة أخرى.",
            ));
          }
        },
      );
    } catch (e) {
      emit(SignupFailure(
        errorMessage: "حدث خطأ أثناء التسجيل، حاول مرة أخرى.",
      ));
    }
  }



}
