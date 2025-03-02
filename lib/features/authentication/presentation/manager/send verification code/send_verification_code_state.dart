
import 'package:equatable/equatable.dart';

abstract class SendVerificationCodeState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();

}

class SendVerificationCodeInitial extends SendVerificationCodeState {}
class SendVerificationCodeLoading extends SendVerificationCodeState {}
class SendVerificationCodeSuccess extends SendVerificationCodeState {
final String message;
 SendVerificationCodeSuccess({required this.message});
}
class SendVerificationCodeFailure extends SendVerificationCodeState {
  final String errorMessage;
  SendVerificationCodeFailure({required this.errorMessage});
}