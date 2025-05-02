import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/detailsAboutProperty/domain/repos/get%20property/get_property_repo.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/manager/get%20property/get_property_state.dart';
import '../../../../../core/error/failure.dart';


class GetPropertyCubit extends Cubit<GetPropertyState> {
  final GetPropertyRepo getPropertyRepo;

  GetPropertyCubit(this.getPropertyRepo) : super(GetPropertyStateInitial());

  Future<void> getProperty({required int id}) async {
    emit(GetPropertyStateLoading());

    try {
      final Either<Failure, Property> result = await getPropertyRepo.getProperty(id: id);

      result.fold(
            (failure) {
          emit(GetPropertyStateFailure(errorMessage: failure.errorMessage));
        },
            (property) {

            emit(GetPropertyStateSuccess(property: property));
        },
      );
    } catch (e) {
      emit(GetPropertyStateFailure(errorMessage: 'حدث خطأ غير متوقع: $e'));
    }
  }
}
