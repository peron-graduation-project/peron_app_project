import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

import '../../../data/notification_model.dart';
import '../../../domain/repo/get notification/notification_repo.dart';
import 'notification_state.dart';

class GetNotificationCubit extends Cubit<GetNotificationState> {
  final NotificationRepo _notificationRepo;

  GetNotificationCubit(this._notificationRepo) : super(GetNotificationStateInitial());

  Future<void> getNotifications() async {
    emit(GetNotificationStateLoading());

    final Either<Failure, dynamic> result = await _notificationRepo.getNotifications();

    result.fold(
          (failure) {
        emit(GetNotificationStateFailure(errorMessage: failure.errorMessage));
      },
          (responseData) {
        try {
          // تحقق من نوع البيانات
          print("✅✅✅ [DEBUG] Response Data Type: ${responseData.runtimeType}");

          if (responseData is List) {
            // تحقق من البيانات داخل القائمة
            for (var item in responseData) {
              print("✅✅✅ [DEBUG] Notification Item: $item");
            }

            // تأكد من أن البيانات هي List
            final List<NotificationModel> notifications = responseData
                .map((item) => NotificationModel.fromJson(item as Map<String, dynamic>)) // تأكد من أن كل عنصر هو Map<String, dynamic>
                .toList();

            print("✅✅✅ [DEBUG] Notifications: $notifications");

            emit(GetNotificationStateSuccess(notifications: notifications));
          } else {
            throw Exception("البيانات غير صحيحة أو غير متوافقة.");
          }
        } catch (e) {
          print("❌❌❌ [ERROR] Error while parsing notifications: $e");
          emit(GetNotificationStateFailure(errorMessage: 'خطأ أثناء تحويل البيانات: $e'));
        }
      },
    );
  }
}
