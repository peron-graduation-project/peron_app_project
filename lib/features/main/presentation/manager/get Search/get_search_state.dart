import 'package:equatable/equatable.dart';

import '../../../../../core/utils/property_model.dart';

abstract class GetSearchPropertiesState extends Equatable {
  const GetSearchPropertiesState();

  @override
  List<Object?> get props => [];
}

class GetSearchPropertiesStateInitial extends GetSearchPropertiesState {}

class GetSearchPropertiesStateLoading extends GetSearchPropertiesState {}

class GetSearchPropertiesStateSuccess extends GetSearchPropertiesState {
  final List<Property> properties;

  const GetSearchPropertiesStateSuccess({required this.properties});

  @override
  List<Object?> get props => [properties];
}

class GetSearchPropertiesStateFailure extends GetSearchPropertiesState {
  final String errorMessage;

  const GetSearchPropertiesStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class GetSearchPropertiesStateEmpty extends GetSearchPropertiesState {}
