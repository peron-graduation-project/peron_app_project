
import 'package:equatable/equatable.dart';


abstract class DeleteNotificationState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();

}

class DeleteNotificationStateInitial extends DeleteNotificationState {}
class DeleteNotificationStateLoading extends DeleteNotificationState {}
class DeleteNotificationStateSuccess extends DeleteNotificationState {
  DeleteNotificationStateSuccess();
}
class DeleteNotificationStateFailure extends DeleteNotificationState {
  final String errorMessage;
  DeleteNotificationStateFailure({required this.errorMessage});
}