import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/notification/data/repo/get_notification_repo_imp.dart';

import '../../../domain/notification_model.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(GetNotificationRepoImp getNotificationRepoImp) : super(NotificationStateInitial());

  Future<void> getNotifications() async {
    try {
      emit(NotificationStateLoading());

      await Future.delayed(const Duration(seconds: 2));

      List<NotificationModel> fakeNotifications = [
        NotificationModel(
          id: "1",
          title: "إعلانك أصبح متاحًا!",
          body: "تمت الموافقة على إعلانك، وهو الآن مرئي للمستخدمين.",
          date: "منذ 3 دقائق",
        ),
        NotificationModel(
          id: "2",
          title: " لا يزال هذا العقار متاحًا!",
          body: "يبدو أنك مهتم بهذا العقار، هل ترغب في التواصل مع المالك؟",
          date: "منذ 5 دقائق",
        ),
        NotificationModel(
          id: "3",
          title: " تم تأجير عقارك!",
          body: "عقارك في (حي الجامعه) قد تم تأجيره، هل ترغب في إزالة الإعلان؟",
          date: "منذ ساعه",
        ),
        NotificationModel(
          id: "4",
          title: " عقارات جديدة متاحة!",
          body: "تمت إضافة عقارات جديدة في منطقتك، تصفحها الآن!",
          date: "منذ يوم",
        ),
      ];

      emit(NotificationStateSuccess(notifications: fakeNotifications));
    } catch (e) {
      emit(NotificationStateFailure( errorMessage: 'حدث خطأ أثناء تحميل الإشعارات'));
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