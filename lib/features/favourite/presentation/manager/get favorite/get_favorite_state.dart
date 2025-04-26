import 'package:equatable/equatable.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';

abstract class GetFavoriteState extends Equatable {
  const GetFavoriteState();

  @override
  List<Object?> get props => [];
}

class GetFavoriteStateInitial extends GetFavoriteState {}

class GetFavoriteStateLoading extends GetFavoriteState {}

class GetFavoriteStateSuccess extends GetFavoriteState {
  final List<RecommendedProperty> properties;

  const GetFavoriteStateSuccess({required this.properties});

  @override
  List<Object?> get props => [properties];
}

class GetFavoriteStateFailure extends GetFavoriteState {
  final String errorMessage;

  const GetFavoriteStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
