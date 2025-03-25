import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repos/check otp/check_otp_repo.dart';
import 'check_otp_state.dart';

class CheckOtpCubit extends Cubit<CheckOtpState> {
  final CheckOtpRepo checkOtpRepo;
  final String email;

  CheckOtpCubit({required this.email, required this.checkOtpRepo,})
      : super(CheckOtpInitial());

  Future<void> checkOtp(
      {required String otpCode,}) async {
    if (isClosed) return;

    emit(CheckOtpLoading());
    debugPrint("🔍 إرسال OTP للتحقق: $otpCode");

    try {
      final result = await checkOtpRepo.checkOtp(
          email: email, otpCode: otpCode);

      result.fold(
            (failure) {
          if (!isClosed) {
            debugPrint("❌ فشل التحقق: ${failure.errorMessage}");
            emit(CheckOtpFailure("فشل التحقق: ${failure.errorMessage}"));
          }
        },
            (isAuthenticated) {
          if (!isClosed) {
            if (isAuthenticated) {
              debugPrint("✅ تم التحقق بنجاح!");
              emit(CheckOtpSuccess(message: "تم التحقق من OTP بنجاح!",
                  otp: otpCode));
            } else {
              debugPrint("❌ OTP غير صالح!");
              emit(CheckOtpFailure("OTP غير صالح أو منتهي الصلاحية!"));
            }
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        debugPrint("⚠️ خطأ غير متوقع أثناء التحقق من OTP: $e");
        emit(CheckOtpFailure("حدث خطأ غير متوقع، يرجى المحاولة لاحقًا."));
      }
    }
  }
}
