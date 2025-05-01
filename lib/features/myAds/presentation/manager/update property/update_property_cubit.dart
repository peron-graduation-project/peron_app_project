import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/property_model.dart';
import '../../../domain/repos/edit property/edit_property_repo_imp.dart';
import 'update_property_state.dart';

class UpdatePropertyCubit extends Cubit<UpdatePropertyState> {
  final UpdatePropertyRepoImp updatePropertyRepoImp;

  UpdatePropertyCubit(this.updatePropertyRepoImp) : super(UpdatePropertyStateInitial());

  Future<void> updateProperty({
    required Property property,
    required int id,
  }) async {
    try {
      emit(UpdatePropertyStateLoading());

      final result = await updatePropertyRepoImp.editProperty(
        property: property,
        id: id,
      );

      result.fold(
            (failure) {
          emit(UpdatePropertyStateFailure(failure.errorMessage));
        },
            (message) {
          emit(UpdatePropertyStateSuccess(message));
        },
      );
    } catch (e) {
      emit(UpdatePropertyStateFailure("حدث خطأ غير متوقع: ${e.toString()}"));
    }
  }
}
