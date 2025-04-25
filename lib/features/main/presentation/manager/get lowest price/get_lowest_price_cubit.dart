import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';
import 'package:peron_project/features/main/domain/repo/get%20lowest%20price/get_lowest_price_repo.dart';
import '../../../../../core/error/failure.dart';
import 'get_lowest_price_state.dart';


class GetLowestPricePropertiesCubit extends Cubit<GetLowestPricePropertiesState> {
  final GetLowestPriceRepo getLowestPriceRepo;

  GetLowestPricePropertiesCubit(this.getLowestPriceRepo) : super(GetLowestPricePropertiesStateInitial());

  Future<void> getLowestPriceProperties() async {
    emit(GetLowestPricePropertiesStateLoading());

    final Either<Failure, List<RecommendedProperty>> result = await getLowestPriceRepo.getLowestPrice();

    result.fold(
          (failure) {
        emit(GetLowestPricePropertiesStateFailure(errorMessage: failure.errorMessage));
      },
          (properties) {
        print("✅✅✅ [DEBUG] properties (in Cubit, before emit): $properties");
        if (properties.isNotEmpty) {
          print("✅✅✅ [DEBUG] First properties Type: ${properties.first.runtimeType}");
          print("✅✅✅ [DEBUG] First properties: ${properties.first.toJson()}");
        }
        emit(GetLowestPricePropertiesStateSuccess(properties: properties));
      },
    );
  }
}