import 'package:equatable/equatable.dart';

abstract class VerifyOtpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VerifyOtpInitial extends VerifyOtpState {}

class VerifyOtpLoading extends VerifyOtpState {}

class VerifyOtpSuccess extends VerifyOtpState {
  final String message;
  VerifyOtpSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class VerifyOtpFailure extends VerifyOtpState {
  final String errorMessage;
  VerifyOtpFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class ResendOtpLoading extends VerifyOtpState {}

class OtpResentSuccess extends VerifyOtpState {
  final String message;
  OtpResentSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class OtpResentFailure extends VerifyOtpState {
  final String errorMessage;
  OtpResentFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
