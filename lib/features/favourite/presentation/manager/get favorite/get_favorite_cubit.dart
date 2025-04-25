import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:peron_project/features/favourite/data/repos/get%20favorite/get_favorite_repo.dart';
import 'package:peron_project/features/favourite/presentation/manager/get%20favorite/get_favorite_state.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';
import '../../../../../core/error/failure.dart';


class GetFavoriteCubit extends Cubit<GetFavoriteState> {
  final GetFavoriteRepo getFavoriteRepo;

  GetFavoriteCubit(this.getFavoriteRepo) : super(GetFavoriteStateInitial());

  Future<void> getFavoriteProperties() async {
    emit(GetFavoriteStateLoading());

    final Either<Failure, List<RecommendedProperty>> result = await getFavoriteRepo.getFavoriteProperties();

    result.fold(
          (failure) {
        emit(GetFavoriteStateFailure(errorMessage: failure.errorMessage));
      },
          (properties) {
        print("✅✅✅ [DEBUG] properties (in Cubit, before emit): $properties");
        if (properties.isNotEmpty) {
          print("✅✅✅ [DEBUG] First properties Type: ${properties.first.runtimeType}");
          print("✅✅✅ [DEBUG] First properties: ${properties.first.toJson()}");
        }
        emit(GetFavoriteStateSuccess(properties: properties));
      },
    );
  }
}