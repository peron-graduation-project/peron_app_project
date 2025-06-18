import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/advertisements/presentation/manager/property_pending/property_pending_state.dart';

import '../../../data/property_model.dart';
import '../../../data/repo/property_pending/property_pending_repo.dart';

class PropertyPendingCubit extends Cubit<PropertyPendingState> {
  final PropertyPendingRepo propertyPendingRepo;

  PropertyPendingCubit(this.propertyPendingRepo)
    : super(PropertyPendingStateInitial());

  Future<String?> postPropertyPending({
    required PropertyFormData property,
  }) async {
    emit(PropertyPendingStateLoading());

    final result = await propertyPendingRepo.postPropertyPending(
      property: property,
    );
    String? paymentUrl;

    result.fold(
      (failure) {
        print("❌ Failure State: ${failure.errorMessage}");
        emit(PropertyPendingStateFailure(failure.errorMessage));
        paymentUrl = null;
      },
      (url) {
        print("✅ Success State: $url");
        emit(PropertyPendingStateSuccess(url));
        paymentUrl = url;
      },
    );
    return paymentUrl;
  }
}
