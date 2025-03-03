import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/notification/data/repo/get_notification_repo.dart';

import 'notification_state.dart';

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
}