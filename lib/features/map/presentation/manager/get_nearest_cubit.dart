import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/map/domain/repos/get%20nearest/get_nearest_repo.dart';
import 'package:peron_project/features/map/presentation/manager/get_nearest_state.dart';
import '../../../../../core/error/failure.dart';


class GetNearestCubit extends Cubit<GetNearestState> {
  final GetNearestRepo getNearestRepo;

  GetNearestCubit(this.getNearestRepo) : super(GetNearestStateInitial());

  Future<void> getNearest(
  {
    required double lat,
    required double lon,
    int? maxResults=10,
}
      ) async {
    emit(GetNearestStateStateLoading());

    final Either<Failure, List<Property>> result = await getNearestRepo.getNearest(lat: lat, lon: lon,maxResults: maxResults);

    result.fold(
          (failure) {
        emit(GetNearestStateFailure(errorMessage: failure.errorMessage));
      },
          (properties) {
        print("✅✅✅ [DEBUG] properties (in Cubit, before emit): $properties");
        if (properties.isNotEmpty) {
          print("✅✅✅ [DEBUG] First properties Type: ${properties.first.runtimeType}");
          print("✅✅✅ [DEBUG] First properties: ${properties.first.toJson()}");
        }
        emit(GetNearestStateSuccess(properties: properties));
      },
    );
  }
}