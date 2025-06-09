import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/error/failure.dart';
import 'package:peron_project/features/chatPot/domain/domain/repos/get%20chatPot/get_chatpot_repo.dart';
import 'package:peron_project/features/chatPot/presentation/manager/chatPot_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/chat_pot_model.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  final GetChatBotRepo chatBotRepo;

  ChatBotCubit(this.chatBotRepo) : super(ChatInitial());

  Future<void> getMessages() async {
    try {
      emit(ChatLoading());

      final cachedMessages = await _loadMessagesLocally();
      if (cachedMessages.isNotEmpty) {
        emit(ChatLoaded(cachedMessages));
      }

      print(' نحاول جلب الرسائل من API');
      final Either<Failure, List<ChatBotMessage>> result = await chatBotRepo.getMessages();

      result.fold(
            (failure) {
          print(' فشل في جلب الرسائل: ${failure.message}');
          emit(ChatError('فشل في تحميل الرسائل: ${failure.message}'));
        },
            (messages) async {
          print('✅ تم جلب الرسائل بنجاح');
          await _saveMessagesLocally(messages);
          emit(ChatLoaded(messages));
        },
      );
    } catch (e) {
      print('❗ خطأ غير متوقع أثناء جلب الرسائل: $e');
      emit(ChatError('حدث خطأ غير متوقع: $e'));
    }
  }

  Future<void> sendMessage(String message) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        emit(ChatError('لا يوجد توكين مسجل لإرسال الرسائل'));
        return;
      }

      final userMessage = ChatBotMessage(messageText: message, sender: 'user');
      List<ChatBotMessage> updatedMessages = [];

      if (state is ChatLoaded) {
        updatedMessages = List<ChatBotMessage>.from((state as ChatLoaded).messages);
      }

      updatedMessages.add(userMessage);
      emit(ChatLoaded(List<ChatBotMessage>.from(updatedMessages)));

      final Either<Failure, Map<String, dynamic>> result = await chatBotRepo.sendMessage(message);

      result.fold(
            (failure) {
          print('❌ فشل في إرسال الرسالة: ${failure.message}');
          emit(ChatLoaded(updatedMessages));
        },
            (data) async {
          await Future.delayed(Duration(seconds: 1));

          final responseMessage = ChatBotMessage(
            messageText: data['response'] ?? data['messageText'] ?? 'رد فارغ',
            sender: 'bot',
          );
          updatedMessages.add(responseMessage);

          await _saveMessagesLocally(updatedMessages);
          emit(ChatLoaded(List<ChatBotMessage>.from(updatedMessages)));
        },
      );
    } catch (e) {
      print('❗ حدث خطأ غير متوقع أثناء إرسال الرسالة: $e');
      emit(ChatError('حدث خطأ غير متوقع: $e'));
    }
  }
  Future<void> _saveMessagesLocally(List<ChatBotMessage> messages) async {
    final prefs = await SharedPreferences.getInstance();
    final messagesJson = messages.map((e) => e.toJson()).toList();
    await prefs.setString('chat_messages', jsonEncode(messagesJson));
  }


  Future<List<ChatBotMessage>> _loadMessagesLocally() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('chat_messages');
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      return decoded.map((e) => ChatBotMessage.fromJson(e)).toList();
    }
    return [];
  }
}
