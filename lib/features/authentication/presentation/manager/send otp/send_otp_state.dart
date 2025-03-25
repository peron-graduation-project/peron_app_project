import 'package:equatable/equatable.dart';

abstract class SendOtpState extends Equatable {
  @override
  List<Object> get props => [];
}

class SendOtpInitial extends SendOtpState {}

class SendOtpLoading extends SendOtpState {}

class OtpSentSuccess extends SendOtpState {
  final String message;
  OtpSentSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class OtpSendingFailure extends SendOtpState {
  final String errorMessage;
  OtpSendingFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
