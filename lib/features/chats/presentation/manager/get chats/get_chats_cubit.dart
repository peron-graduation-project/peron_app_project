import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:peron_project/features/chats/data/models/chat_model.dart';
import 'package:peron_project/features/chats/domain/repos/get%20chats/get_chats_repo.dart';
import 'package:peron_project/features/chats/presentation/manager/get%20chats/get_chats_state.dart';
import '../../../../../../core/error/failure.dart';

class GetChatsCubit extends Cubit<GetChatsState> {
  final GetChatsRepo getChatsRepo;

  GetChatsCubit(this.getChatsRepo) : super(GetChatsStateInitial()) {
    getChatsRepo.chatsNotifier.addListener(() {
      emit(GetChatsStateSuccess(chats: getChatsRepo.chatsNotifier.value));
    });
  }

  Future<void> getChats() async {
    emit(GetChatsStateLoading());

    try {
      final Either<Failure, List<ChatModel>> result = await getChatsRepo.getChats();

      result.fold(
            (failure) {
          emit(GetChatsStateFailure(errorMessage: failure.errorMessage));
        },
            (chats) {
          if (chats.isNotEmpty) {
          } else {
            emit(const GetChatsStateFailure(errorMessage: 'لم يتم العثور على محادثات حتى الآن'));
          }
        },
      );
    } catch (e) {
      emit(GetChatsStateFailure(errorMessage: 'حدث خطأ غير متوقع: $e'));
    }
  }

  void addNewChat(ChatModel chat) {
    try {
      getChatsRepo.addNewChat(chat);
    } catch (e) {
      emit(GetChatsStateFailure(errorMessage: 'حدث خطأ أثناء إضافة المحادثة: $e'));
    }
  }

  void clearChatsCache() {
    try {
      getChatsRepo.clearChatsCache();
    } catch (e) {
      emit(GetChatsStateFailure(errorMessage: 'حدث خطأ أثناء مسح البيانات المخزنة: $e'));
    }
  }
}
