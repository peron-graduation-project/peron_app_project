import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';
import 'package:peron_project/features/main/domain/repo/get%20recommended/get_recommended_repo.dart';
import '../../../../../core/error/failure.dart';
import 'get_recommended_properties_state.dart';


class GetRecommendedPropertiesCubit extends Cubit<GetRecommendedPropertiesState> {
  final GetRecommendedRepo getRecommendedRepo;

   GetRecommendedPropertiesCubit(this.getRecommendedRepo) : super(GetRecommendedPropertiesStateInitial());

  Future<void> getRecommendedProperties() async {
    emit(GetRecommendedPropertiesStateLoading());

    final Either<Failure, List<RecommendedProperty>> result = await getRecommendedRepo.getRecommendedProperties();

    result.fold(
          (failure) {
        emit(GetRecommendedPropertiesStateFailure(errorMessage: failure.errorMessage));
      },
          (properties) {
        print("✅✅✅ [DEBUG] properties (in Cubit, before emit): $properties");
        if (properties.isNotEmpty) {
          print("✅✅✅ [DEBUG] First properties Type: ${properties.first.runtimeType}");
          print("✅✅✅ [DEBUG] First properties: ${properties.first.toJson()}");
        }
        emit(GetRecommendedPropertiesStateSuccess(properties: properties));
      },
    );
  }
}