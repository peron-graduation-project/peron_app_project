import 'package:equatable/equatable.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';

abstract class GetHighestPricePropertiesState extends Equatable {
  const GetHighestPricePropertiesState();

  @override
  List<Object?> get props => [];
}

class GetHighestPricePropertiesStateInitial extends GetHighestPricePropertiesState {}

class GetHighestPricePropertiesStateLoading extends GetHighestPricePropertiesState {}

class GetHighestPricePropertiesStateSuccess extends GetHighestPricePropertiesState {
  final List<RecommendedProperty> properties;

  const GetHighestPricePropertiesStateSuccess({required this.properties});

  @override
  List<Object?> get props => [properties];
}

class GetHighestPricePropertiesStateFailure extends GetHighestPricePropertiesState {
  final String errorMessage;

  const GetHighestPricePropertiesStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
