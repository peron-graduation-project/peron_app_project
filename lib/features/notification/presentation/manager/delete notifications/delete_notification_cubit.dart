import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repo/get notification/notification_repo.dart';
import 'delete_notification_state.dart';

class DeleteNotificationCubit extends Cubit<DeleteNotificationState> {
  final NotificationRepo _notificationRepo;

  DeleteNotificationCubit(this._notificationRepo) : super(DeleteNotificationStateInitial());

  Future<void> deleteNotification({required int id}) async {
    emit(DeleteNotificationStateLoading());

    final result = await _notificationRepo.deleteNotifications(selectedId: id);

    result.fold(
          (failure) {
        emit(DeleteNotificationStateFailure(errorMessage: failure.errorMessage));
      },
          (success) {
        if (success) {
          emit(DeleteNotificationStateSuccess());
        } else {
          emit(DeleteNotificationStateFailure(errorMessage: 'حدث خطأ غير متوقع أثناء الحذف'));
        }
      },
    );
  }
}