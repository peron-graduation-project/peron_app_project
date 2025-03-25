import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/send otp/send_repo.dart';
import '../send otp/send_otp_state.dart';

class SendOtpCubit extends Cubit<SendOtpState> {
  final SendOtpRepo sendRepo;
  String? userEmail;

  SendOtpCubit(this.sendRepo) : super(SendOtpInitial());

  Future<void> sendOtp() async {
    if (userEmail == null || userEmail!.isEmpty) return;

    emit(SendOtpLoading());

    try {
      final result = await sendRepo.sendOtp(userEmail!);
      result.fold(
            (failure) => emit(OtpSendingFailure(failure.errorMessage)),
            (message) => emit(OtpSentSuccess(message)),
      );
    } catch (e) {
      emit(OtpSendingFailure("حدث خطأ أثناء إرسال رمز التحقق، حاول مرة أخرى."));
    }
  }
}
