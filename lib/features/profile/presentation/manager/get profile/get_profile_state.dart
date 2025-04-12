
import 'package:equatable/equatable.dart';
import '../../../data/models/profile_model.dart';

abstract class GetProfileState extends Equatable {
  const GetProfileState();

  @override
  List<Object> get props => [];
}

class GetProfileInitial extends GetProfileState {}

class GetProfileLoading extends GetProfileState {}

class GetProfileLoaded extends GetProfileState {
  final ProfileModel profile;

  const GetProfileLoaded({required this.profile});

  @override
  List<Object> get props => [profile];
}

class GetProfileError extends GetProfileState {
  final String message;

  const GetProfileError({required this.message});

  @override
  List<Object> get props => [message];
}

