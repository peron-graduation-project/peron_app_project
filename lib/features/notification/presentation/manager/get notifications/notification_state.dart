
import 'package:equatable/equatable.dart';

import '../../../data/notification_model.dart';

abstract class GetNotificationState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();

}

class GetNotificationStateInitial extends GetNotificationState {}
class GetNotificationStateLoading extends GetNotificationState {}
class GetNotificationStateSuccess extends GetNotificationState {
  final List<NotificationModel> notifications;
  GetNotificationStateSuccess({required this.notifications});
}
class GetNotificationStateFailure extends GetNotificationState {
  final String errorMessage;
  GetNotificationStateFailure({required this.errorMessage});
}