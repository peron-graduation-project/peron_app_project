import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/authentication/data/repos/resend%20otp/resend_otp_repo.dart';
import 'package:peron_project/features/authentication/presentation/manager/resend%20otp/resend_otp_state.dart';

class ResendOtpCubit extends Cubit<ResendOtpState> {
  final ResendOtpRepo resendOtpRepo;
  final String email;

 ResendOtpCubit({required this.email, required this.resendOtpRepo,}) : super(ResendOtpInitial());


  Future<void> resendOtp() async {
    if (isClosed) return;
    emit(OtpResentLoading());
    debugPrint("🔄 إعادة إرسال OTP إلى: $email");

    try {
      final result = await resendOtpRepo.resendOtp(email: email);

      result.fold(
            (failure) {
          if (!isClosed) {
            debugPrint("❌ فشل في إعادة الإرسال: ${failure.errorMessage}");
            emit(OtpResentFailure("تعذر إعادة إرسال OTP، يرجى المحاولة لاحقًا."));
          }
        },
            (message) {
          if (!isClosed) {
            debugPrint("✅ OTP تمت إعادة إرساله بنجاح!");
            emit(OtpResentSuccess("تم إرسال OTP بنجاح إلى بريدك الإلكتروني."));
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        debugPrint("⚠️ خطأ غير متوقع أثناء إعادة إرسال OTP: $e");
        emit(OtpResentFailure("حدث خطأ غير متوقع، يرجى المحاولة لاحقًا."));
      }
    }
  }
}
