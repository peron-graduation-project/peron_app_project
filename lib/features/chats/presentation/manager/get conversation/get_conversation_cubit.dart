import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../data/models/message_model.dart';
import 'package:peron_project/features/chats/domain/repos/get%20conversation/get_conversation_repo.dart';
import 'package:peron_project/features/chats/presentation/manager/get%20conversation/get_conversation_state.dart';
import '../../../../../core/error/failure.dart';


class GetConversationCubit extends Cubit<GetConversationState> {
  final GetConversationRepo getConversationRepo;

  GetConversationCubit(this.getConversationRepo) : super(GetConversationStateInitial());

  Future<void> getConversations({required String id}) async {
    emit(GetConversationStateLoading());

    try {
      final Either<Failure, List<Message>> result = await getConversationRepo.getconversation(id: id);

      result.fold(
            (failure) {
          emit(GetConversationStateFailure(errorMessage: failure.errorMessage));
        },
            (conversations) {
          if (conversations.isNotEmpty) {
            emit(GetConversationStateSuccess(conversations: conversations));
          } else {
            emit(const GetConversationStateFailure(errorMessage: 'لا توجد محادثة حالياً'));
          }
        },
      );
    } catch (e) {
      emit(GetConversationStateFailure(errorMessage: 'حدث خطأ غير متوقع: $e'));
    }
  }

  Future<void> addSentMessage({
    required String message,
  }) async {
    if (state is GetConversationStateSuccess) {
      final currentState = state as GetConversationStateSuccess;

      final String senderName = currentState.conversations.first.senderName??"";
      final String? senderPhoto = currentState.conversations.first.senderPhoto;

      final bool isMe = currentState.conversations.first.isMe;

      final newMessage = Message(
        id: DateTime.now().millisecondsSinceEpoch,
        isMe: isMe,
        senderName: senderName,
        senderPhoto: senderPhoto,
        message: message,
        timestamp: DateTime.now().toString(),
        isRead: false,
      );

      final updatedConversations = List<Message>.from(currentState.conversations)
        ..add(newMessage);

      emit(GetConversationStateSuccess(conversations: updatedConversations));
    }
  }

}
