import 'package:equatable/equatable.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';

abstract class GetLowestPricePropertiesState extends Equatable {
  const GetLowestPricePropertiesState();

  @override
  List<Object?> get props => [];
}

class GetLowestPricePropertiesStateInitial extends GetLowestPricePropertiesState {}

class GetLowestPricePropertiesStateLoading extends GetLowestPricePropertiesState {}

class GetLowestPricePropertiesStateSuccess extends GetLowestPricePropertiesState {
  final List<RecommendedProperty> properties;

  const GetLowestPricePropertiesStateSuccess({required this.properties});

  @override
  List<Object?> get props => [properties];
}

class GetLowestPricePropertiesStateFailure extends GetLowestPricePropertiesState {
  final String errorMessage;

  const GetLowestPricePropertiesStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
