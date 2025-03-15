

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/authentication/data/repos/send%20verification%20code/send_verfication_code_repo.dart';
import 'package:peron_project/features/authentication/presentation/manager/send%20verification%20code/send_verification_code_state.dart';

class SendVerificationCodeCubit extends Cubit<SendVerificationCodeState> {
  SendVerificationCodeCubit(this.sendVerificationCodeRepo) : super(SendVerificationCodeInitial());
  final SendVerificationCodeRepo sendVerificationCodeRepo;
  Future<void>sendVerificationCode(String phoneNumber)async{
    emit(SendVerificationCodeLoading());
    var result= await sendVerificationCodeRepo.sendVerificationCode(phoneNumber);
    result.fold((failure){
      emit(SendVerificationCodeFailure(errorMessage: failure.errorMessage));
    }, (message){
      emit(SendVerificationCodeSuccess(message: message));
    });


  }
}