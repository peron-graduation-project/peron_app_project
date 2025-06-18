import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/advertisements/data/property_model.dart';
import 'package:peron_project/features/advertisements/presentation/manager/propert_confirm/property_confirm_state.dart';
import 'package:peron_project/features/advertisements/presentation/manager/propert_create/property_confirm_state.dart';

import '../../../data/repo/property_confirm/property_confirm_repo.dart';

class PropertyCreateCubit extends Cubit<PropertyCreateState> {
  final PropertyConfirmRepo propertyConfirmRepo;

  PropertyCreateCubit(this.propertyConfirmRepo)
    : super(PropertyCreateStateInitial());

  Future<void> propertyCreate({required PropertyFormData property}) async {
    emit(PropertyCreateStateLoading());

    final result = await propertyConfirmRepo.propertyCreate(property: property);

    result.fold(
      (failure) {
        print("❌ Failure State: ${failure.errorMessage}");
        emit(PropertyCreateStateFailure(failure.errorMessage));
      },
      (id) {
        print("✅ Success State: $id");
        emit(PropertyCreateStateSuccess(id));
      },
    );
  }

  String? get getId {
    if (state is PropertyCreateStateSuccess) {
      return (state as PropertyCreateStateSuccess).id;
    }
    return null;
  }
}
