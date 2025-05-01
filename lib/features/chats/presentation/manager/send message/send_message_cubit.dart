import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/chats/domain/repos/send%20message/send_message_repo.dart';
import 'package:peron_project/features/chats/presentation/manager/send%20message/send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  final SendMessageRepo sendMessageRepo;
  final String currentUserId;

  SendMessageCubit({
    required this.sendMessageRepo,
    required this.currentUserId,
  }) : super(SendMessageStateInitial());

  Future<void> sendMessage({required String id, required String message}) async {
    emit(SendMessageStateLoading());

    final result = await sendMessageRepo.sendMessage(receiverId: id, message: message);

    result.fold(
          (failure) {
        emit(SendMessageStateFailure(
          errorMessage: failure.errorMessage,
        ));
      },
          (success) {
        if (success) {
          emit(SendMessageStateSuccess());
        } else {
          emit(SendMessageStateFailure(
            errorMessage: 'حدث خطأ غير متوقع أثناء إرسال الرسالة',
          ));
        }
      },
    );
  }
}
