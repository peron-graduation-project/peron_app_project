import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/repo/get_notification_repo_imp.dart';
import 'notification_state.dart';

import 'package:dartz/dartz.dart';
import '../../../data/notification_model.dart';



class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepoImp _notificationRepoImp;

  NotificationCubit(this._notificationRepoImp) : super(NotificationStateInitial());

  Future<void> fetchNotifications() async {
    emit(NotificationStateLoading());

    try {
      final Either<Failure, List<NotificationModel>> result = await _notificationRepoImp.getNotifications();

      result.fold(
            (failure) {
          emit(NotificationStateFailure(errorMessage: failure.errorMessage));
        },
            (notifications) {
          for (var n in notifications) {
          }
          emit(NotificationStateSuccess(notifications: notifications));
        },
      );
    } catch (e) {
      emit(NotificationStateFailure(errorMessage: 'حدث خطأ أثناء تحميل الإشعارات: ${e.toString()}'));
    }
  }

  Future<void> deleteNotifications({required List<String> selectedIds}) async {
    emit(NotificationStateLoading());

    try {
      final Either<Failure, List<NotificationModel>> result = await _notificationRepoImp.deleteNotifications(
        selectedIds: selectedIds,
      );

      result.fold(
            (failure) => emit(NotificationStateFailure(errorMessage: failure.errorMessage)),
            (updatedNotifications) {
          emit(NotificationStateSuccess(notifications: updatedNotifications));
        },
      );
    } catch (e) {
      emit(NotificationStateFailure(errorMessage: 'حدث خطأ أثناء حذف الإشعارات: ${e.toString()}'));
    }
  }

  void markAllAsRead() {
    if (state is NotificationStateSuccess) {
      final currentState = state as NotificationStateSuccess;

      final updatedNotifications = currentState.notifications.map(
            (notification) => notification.copyWith(isRead: true),
      ).toList();

      emit(NotificationStateSuccess(notifications: updatedNotifications));
    }
  }
}




/*
class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.getNotificationRepo) : super(NotificationStateInitial());
  final GetNotificationRepo getNotificationRepo;
  Future<void>getNotification(String phoneNumber)async{
    emit(NotificationStateLoading());
    var result= await getNotificationRepo.getNotification(phoneNumber);
    result.fold((failure){
      emit(NotificationStateFailure(errorMessage: failure.errorMessage));
    }, (notification){
      emit(NotificationStateSuccess(notifications: notification));
    });


  }
}*/