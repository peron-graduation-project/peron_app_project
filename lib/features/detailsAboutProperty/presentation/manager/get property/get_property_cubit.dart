import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/detailsAboutProperty/domain/repos/get%20property/get_property_repo.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/manager/get%20property/get_property_state.dart';
import '../../../../../core/error/failure.dart';

class GetPropertyCubit extends Cubit<GetPropertyState> {
  final GetPropertyRepo getPropertyRepo;

  Property? _cachedProperty;

  GetPropertyCubit(this.getPropertyRepo) : super( GetPropertyStateInitial());

  Future<void> getProperty({required int id, bool forceRefresh = false}) async {
    emit( GetPropertyStateLoading());

    if (_cachedProperty != null && !forceRefresh) {
      emit(GetPropertyStateSuccess(property: _cachedProperty!));
      return;
    }

    final Either<Failure, Property> result = await getPropertyRepo.getProperty(id: id);

    result.fold(
      (failure) {
        emit(GetPropertyStateFailure(errorMessage: failure.errorMessage));
      },
      (property) {
        _cachedProperty = property;
        emit(GetPropertyStateSuccess(property: property));
      },
    );
  }

  Future<void> refreshProperty(int id) async {
    await getProperty(id: id, forceRefresh: true);
  }
}
