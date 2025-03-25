import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/authentication/presentation/manager/verify%20otp/verify_otp_state.dart';
import '../../../data/repos/verify otp/verify_otp_repo.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final VerifyOtpRepo verifyOtpRepo;
  final String email;

  VerifyOtpCubit({required this.email, required this.verifyOtpRepo,}) : super(VerifyOtpInitial());

  Future<void> verifyOtp({required String otpCode,}) async {
    if (isClosed) return;

    emit(VerifyOtpLoading());
    debugPrint("🔍 إرسال OTP للتحقق: $otpCode");

    try {
      final result = await verifyOtpRepo.verifyOtp(email: email, otpCode: otpCode);

      result.fold(
            (failure) {
          if (!isClosed) {
            debugPrint("❌ فشل التحقق: ${failure.errorMessage}");
            emit(VerifyOtpFailure("فشل التحقق: ${failure.errorMessage}"));
          }
        },
            (isAuthenticated) {
          if (!isClosed) {
            if (isAuthenticated) {
              debugPrint("✅ تم التحقق بنجاح!");
              emit(VerifyOtpSuccess(message: "تم التحقق من OTP بنجاح!",otp:otpCode ));
            } else {
              debugPrint("❌ OTP غير صالح!");
              emit(VerifyOtpFailure("OTP غير صالح أو منتهي الصلاحية!"));
            }
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        debugPrint("⚠️ خطأ غير متوقع أثناء التحقق من OTP: $e");
        emit(VerifyOtpFailure("حدث خطأ غير متوقع، يرجى المحاولة لاحقًا."));
      }
    }
  }

}
