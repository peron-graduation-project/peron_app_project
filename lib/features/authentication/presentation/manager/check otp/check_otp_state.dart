import 'package:equatable/equatable.dart';

abstract class CheckOtpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckOtpInitial extends CheckOtpState {}

class CheckOtpLoading extends CheckOtpState {}

class CheckOtpSuccess extends CheckOtpState {
  final String message;
  final String otp;


  CheckOtpSuccess({required this.otp, required this.message,});

  @override
  List<Object?> get props => [message];
}

class CheckOtpFailure extends CheckOtpState {
  final String errorMessage;
  CheckOtpFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
