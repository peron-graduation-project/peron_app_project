import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/advertisements/presentation/manager/propert_confirm/property_confirm_state.dart';
import '../../../data/repo/property_confirm/property_confirm_repo.dart';

class PropertyConfirmCubit extends Cubit<PropertyConfirmState> {
  final PropertyConfirmRepo propertyConfirmRepo;

  PropertyConfirmCubit(this.propertyConfirmRepo)
      : super(PropertyConfirmStateInitial());

  Future<void> propertyConfirm({required String sessionId}) async {
    emit(PropertyConfirmStateLoading());

    final result = await propertyConfirmRepo.propertyConfirm(
      sessionId: sessionId,
    );

    result.fold(
          (failure) {
        print("❌ Failure State: ${failure.errorMessage}");
        emit(PropertyConfirmStateFailure(failure.errorMessage));
      },
          (confirmationMessage) {
        print("✅ Success State: $confirmationMessage");
        emit(PropertyConfirmStateSuccess(confirmationMessage));
      },
    );
  }
}
