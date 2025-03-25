import 'package:equatable/equatable.dart';

abstract class VerifyOtpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VerifyOtpInitial extends VerifyOtpState {}

class VerifyOtpLoading extends VerifyOtpState {}

class VerifyOtpSuccess extends VerifyOtpState {
  final String message;
  final String otp;


  VerifyOtpSuccess({required this.otp, required this.message, });

  @override
  List<Object?> get props => [message];
}

class VerifyOtpFailure extends VerifyOtpState {
  final String errorMessage;
  VerifyOtpFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

