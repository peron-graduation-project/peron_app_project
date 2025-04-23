import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/main/domain/repo/get%20search/get_search_repo.dart';
import 'package:peron_project/features/main/presentation/manager/get%20Search/get_search_state.dart';
import '../../../../../core/error/failure.dart';
class GetSearchPropertiesCubit extends Cubit<GetSearchPropertiesState> {
  final GetSearchRepo getSearchRepo;
  GetSearchPropertiesCubit(this.getSearchRepo) : super(GetSearchPropertiesStateInitial());
  Future<void> getSearchProperties(String location) async {
    emit(GetSearchPropertiesStateLoading());
    final Either<Failure, List<Property>> result = await getSearchRepo.getSearchProperties(location);
    result.fold(
          (failure) {
        emit(GetSearchPropertiesStateFailure(errorMessage: failure.errorMessage));
      },
          (properties) {
        print("✅✅✅ [DEBUG] properties (in Cubit, before emit): $properties");
        if (properties.isNotEmpty) {
          print("✅✅✅ [DEBUG] First properties Type: ${properties.first.runtimeType}");
          print("✅✅✅ [DEBUG] First properties: ${properties.first.toJson()}");
        }
        emit(GetSearchPropertiesStateSuccess(properties: properties));
      },
    );
  }
}