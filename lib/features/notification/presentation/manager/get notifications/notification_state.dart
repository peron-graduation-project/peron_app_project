import 'package:equatable/equatable.dart';
import '../../../data/notification_model.dart';

abstract class GetNotificationState extends Equatable {
  const GetNotificationState();

  @override
  List<Object?> get props => [];
}

class GetNotificationStateInitial extends GetNotificationState {}

class GetNotificationStateLoading extends GetNotificationState {}

class GetNotificationStateSuccess extends GetNotificationState {
  final List<NotificationModel> notifications;

  const GetNotificationStateSuccess({required this.notifications});

  @override
  List<Object?> get props => [notifications];
}

class GetNotificationStateFailure extends GetNotificationState {
  final String errorMessage;

  const GetNotificationStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
