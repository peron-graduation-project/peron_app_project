
import 'package:equatable/equatable.dart';

import '../../../domain/notification_model.dart';

abstract class NotificationState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();

}

class NotificationStateInitial extends NotificationState {}
class NotificationStateLoading extends NotificationState {}
class NotificationStateSuccess extends NotificationState {
  final List<NotificationModel> notifications;
  NotificationStateSuccess({required this.notifications});
}
class NotificationStateFailure extends NotificationState {
  final String errorMessage;
  NotificationStateFailure({required this.errorMessage});
}