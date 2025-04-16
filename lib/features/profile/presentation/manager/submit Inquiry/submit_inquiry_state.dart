abstract class SubmitInquiryState {}

class SubmitInquiryStateInitial extends SubmitInquiryState {}

class SubmitInquiryStateLoading extends SubmitInquiryState {}

class SubmitInquiryStateSuccess extends SubmitInquiryState {
  final String message;

  SubmitInquiryStateSuccess(this.message);
}

class SubmitInquiryStateFailure extends SubmitInquiryState {
  final String errorMessage;

  SubmitInquiryStateFailure(this.errorMessage);
}
