import '../../../data/models/user_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserModel userModel;
  final String email;
  final String password;

  LoginSuccess({
    required this.userModel,
    required this.email,
    required this.password,
  });
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}

class LoginCredentialsLoaded extends LoginState {
  final String email;
  final String password;

  LoginCredentialsLoaded({required this.email, required this.password});
}

class LoginRememberPasswordUpdated extends LoginState {
  final bool rememberPassword;

  LoginRememberPasswordUpdated({required this.rememberPassword});
}
