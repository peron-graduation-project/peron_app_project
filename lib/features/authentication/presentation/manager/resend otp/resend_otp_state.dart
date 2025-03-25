import 'package:equatable/equatable.dart';

abstract class ResendOtpState extends Equatable{
  @override
  List<Object?> get props => [];
}
class ResendOtpInitial extends ResendOtpState {}

class OtpResentLoading extends ResendOtpState {}
class OtpResentSuccess extends ResendOtpState {
  final String message;


  OtpResentSuccess(this.message,);

  @override
  List<Object?> get props => [message];
}

class OtpResentFailure extends ResendOtpState {
  final String errorMessage;
  OtpResentFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
