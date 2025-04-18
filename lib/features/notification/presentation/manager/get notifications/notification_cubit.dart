import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../data/notification_model.dart';
import '../../../domain/repo/notification/notification_repo.dart';
import 'notification_state.dart';

class GetNotificationCubit extends Cubit<GetNotificationState> {
  final NotificationRepo _notificationRepo;

  GetNotificationCubit(this._notificationRepo) : super(GetNotificationStateInitial());

  Future<void> getNotifications() async {
    emit(GetNotificationStateLoading());

    try {
      final Either<Failure, List<NotificationModel>> result = await _notificationRepo.getNotifications();

      result.fold(
            (failure) {
          emit(GetNotificationStateFailure(errorMessage: failure.errorMessage));
        },
            (notifications) {
          // تفادي عرض إشعارات فارغة
          if (notifications.isNotEmpty) {
            emit(GetNotificationStateSuccess(notifications: notifications));
          } else {
            emit(const GetNotificationStateFailure(errorMessage: 'لا توجد إشعارات حالياً'));
          }
        },
      );
    } catch (e) {
      // التعامل مع أي أخطاء غير متوقعة
      emit(GetNotificationStateFailure(errorMessage: 'حدث خطأ غير متوقع: $e'));
    }
  }
}
