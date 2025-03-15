import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final String message;
  SignupSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class SignupFailure extends SignupState {
  final String errorMessage;
  SignupFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
