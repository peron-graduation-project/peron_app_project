import 'package:equatable/equatable.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';

abstract class GetMostAreaState extends Equatable {
  const GetMostAreaState();

  @override
  List<Object?> get props => [];
}

class GetMostAreaStateInitial extends GetMostAreaState {}

class GetMostAreaStateLoading extends GetMostAreaState {}

class GetMostAreaStateSuccess extends GetMostAreaState {
  final List<RecommendedProperty> properties;

  const GetMostAreaStateSuccess({required this.properties});

  @override
  List<Object?> get props => [properties];
}

class GetMostAreaStateFailure extends GetMostAreaState {
  final String errorMessage;

  const GetMostAreaStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
