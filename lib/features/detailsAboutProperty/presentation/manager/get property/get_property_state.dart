import 'package:equatable/equatable.dart';
import 'package:peron_project/core/utils/property_model.dart';

abstract class GetPropertyState extends Equatable {
  const GetPropertyState();

  @override
  List<Object?> get props => [];
}

class GetPropertyStateInitial extends GetPropertyState {}

class GetPropertyStateLoading extends GetPropertyState {}

class GetPropertyStateSuccess extends GetPropertyState {
  final Property property;

  const GetPropertyStateSuccess({required this.property});

  @override
  List<Object?> get props => [property];
}

class GetPropertyStateFailure extends GetPropertyState {
  final String errorMessage;

  const GetPropertyStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
