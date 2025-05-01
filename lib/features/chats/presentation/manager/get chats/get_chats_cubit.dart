import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:peron_project/features/chats/data/models/chat_model.dart';
import 'package:peron_project/features/chats/domain/repos/get%20chats/get_chats_repo.dart';
import 'package:peron_project/features/chats/presentation/manager/get%20chats/get_chats_state.dart';
import '../../../../../core/error/failure.dart';


class GetChatsCubit extends Cubit<GetChatsState> {
  final GetChatsRepo getChatsRepo;

  GetChatsCubit(this.getChatsRepo) : super(GetChatsStateInitial());

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
            emit(GetChatsStateSuccess(chats: chats));
          } else {
            emit(const GetChatsStateFailure(errorMessage: 'لا توجد محادثات حالياً'));
          }
        },
      );
    } catch (e) {
      emit(GetChatsStateFailure(errorMessage: 'حدث خطأ غير متوقع: $e'));
    }
  }
}
