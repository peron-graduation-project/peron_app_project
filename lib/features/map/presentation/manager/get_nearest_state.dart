import 'package:equatable/equatable.dart';
import 'package:peron_project/core/utils/property_model.dart';

abstract class GetNearestState extends Equatable {
  const GetNearestState();

  @override
  List<Object?> get props => [];
}

class GetNearestStateInitial extends GetNearestState {}

class GetNearestStateStateLoading extends GetNearestState {}

class GetNearestStateSuccess extends GetNearestState {
  final List<Property> properties;

  const GetNearestStateSuccess({required this.properties});

  @override
  List<Object?> get props => [properties];
}

class GetNearestStateFailure extends GetNearestState {
  final String errorMessage;

  const GetNearestStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
