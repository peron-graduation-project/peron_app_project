import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';
import 'package:peron_project/features/main/domain/repo/get%20recommended/get_recommended_repo.dart';
import '../../../../../core/error/failure.dart';
import 'get_recommended_properties_state.dart';


class GetRecommendedPropertiesCubit extends Cubit<GetRecommendedPropertiesState> {
  final GetRecommendedRepo getRecommendedRepo;

  List<RecommendedProperty>? _cachedProperties;

  GetRecommendedPropertiesCubit(this.getRecommendedRepo) : super(GetRecommendedPropertiesStateInitial());

  Future<void> getRecommendedProperties({bool forceRefresh = false}) async {
    if (_cachedProperties != null && !forceRefresh) {
      emit(GetRecommendedPropertiesStateSuccess(properties: _cachedProperties!));
      return;
    }

    emit(GetRecommendedPropertiesStateLoading());

    final Either<Failure, List<RecommendedProperty>> result = await getRecommendedRepo.getRecommendedProperties();

    result.fold(
          (failure) {
        emit(GetRecommendedPropertiesStateFailure(errorMessage: failure.errorMessage));
      },
          (properties) {
        _cachedProperties = properties;
        emit(GetRecommendedPropertiesStateSuccess(properties: properties));
      },
    );
  }

  Future<void> refreshRecommendedProperties() async {
    await getRecommendedProperties(forceRefresh: true);
  }
}