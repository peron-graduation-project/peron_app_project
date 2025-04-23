import 'package:equatable/equatable.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';

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
