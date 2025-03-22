import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final String message;
  SignupSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class SignupFailure extends SignupState {
  final String? errorMessage;
  final List<String>? errors;

  SignupFailure({this.errorMessage, this.errors});

  String get displayErrorMessage {
    if (errors != null && errors!.isNotEmpty) {
      return errors!.join("\n");
    }
    return errorMessage ?? "حدث خطأ غير معروف!";
  }

  @override
  List<Object?> get props => [errorMessage, errors];

  @override
  String toString() =>
      "SignupFailure(errorMessage: $errorMessage, errors: $errors)";
}

class OtpSending extends SignupState {}

class OtpSentSuccess extends SignupState {
  final String message;
  OtpSentSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class OtpSendingFailure extends SignupState {
  final String errorMessage;
  OtpSendingFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
