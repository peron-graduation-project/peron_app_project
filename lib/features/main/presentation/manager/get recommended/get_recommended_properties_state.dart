import 'package:equatable/equatable.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';

abstract class GetRecommendedPropertiesState extends Equatable {
  const GetRecommendedPropertiesState();

  @override
  List<Object?> get props => [];
}

class GetRecommendedPropertiesStateInitial extends GetRecommendedPropertiesState {}

class GetRecommendedPropertiesStateLoading extends GetRecommendedPropertiesState {}

class GetRecommendedPropertiesStateSuccess extends GetRecommendedPropertiesState {
  final List<RecommendedProperty> properties;

  const GetRecommendedPropertiesStateSuccess({required this.properties});

  @override
  List<Object?> get props => [properties];
}

class GetRecommendedPropertiesStateFailure extends GetRecommendedPropertiesState {
  final String errorMessage;

  const GetRecommendedPropertiesStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
