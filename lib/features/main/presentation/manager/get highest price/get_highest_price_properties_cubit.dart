import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';
import 'package:peron_project/features/main/domain/repo/get%20highest%20price/get_highest_price_repo.dart';
import '../../../../../core/error/failure.dart';
import 'get_highest_price_properties_state.dart';


class GetHighestPricePropertiesCubit extends Cubit<GetHighestPricePropertiesState> {
  final GetHighestPriceRepo getHighestPriceRepo;

  GetHighestPricePropertiesCubit(this.getHighestPriceRepo) : super(GetHighestPricePropertiesStateInitial());

  Future<void> getHighestPriceProperties() async {
    emit(GetHighestPricePropertiesStateLoading());

    final Either<Failure, List<RecommendedProperty>> result = await getHighestPriceRepo.getHighestPrice();

    result.fold(
          (failure) {
        emit(GetHighestPricePropertiesStateFailure(errorMessage: failure.errorMessage));
      },
          (properties) {
        print("✅✅✅ [DEBUG] properties (in Cubit, before emit): $properties");
        if (properties.isNotEmpty) {
          print("✅✅✅ [DEBUG] First properties Type: ${properties.first.runtimeType}");
          print("✅✅✅ [DEBUG] First properties: ${properties.first.toJson()}");
        }
        emit(GetHighestPricePropertiesStateSuccess(properties: properties));
      },
    );
  }
}