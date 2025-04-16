import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/profile/domain/repos/submit%20inquiry/submit_inquiry_repo.dart';
import 'package:peron_project/features/profile/presentation/manager/submit%20Inquiry/submit_inquiry_state.dart';

class SubmitInquiryCubit extends Cubit<SubmitInquiryState> {
  final SubmitInquiryRepo submitInquiryRepo;

  SubmitInquiryCubit(this.submitInquiryRepo) : super(SubmitInquiryStateInitial());

  Future<void> submitInquiry({
    required String name,
    required String email,
    required String phone,
    required String message,}) async {
    try {
      emit(SubmitInquiryStateLoading());


      final result = await submitInquiryRepo.submitInquiry(
        name: name,
        email: email,
        phone: phone,
        message: message
      );


      result.fold(
            (failure) {

          emit(SubmitInquiryStateFailure(failure.errorMessage));
        },
            (message) {

          emit(SubmitInquiryStateSuccess(message));
        },
      );
    } catch (e) {

      emit(SubmitInquiryStateFailure("حدث خطأ غير متوقع: ${e.toString()}"));
    }
  }
}
