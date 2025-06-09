import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:peron_project/core/network/api_service.dart';
import 'package:peron_project/features/chatPot/domain/domain/repos/get%20chatPot/get_chatpot_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../data/chat_pot_model.dart';

class GetChatBotRepoImpl implements GetChatBotRepo {
  final ApiService apiService;

  GetChatBotRepoImpl(this.apiService);
  List<ChatBotMessage>? _cachedMessages;


  final ValueNotifier<List<ChatBotMessage>> _messagesNotifier = ValueNotifier([]);

  ValueNotifier<List<ChatBotMessage>> get messagesNotifier => _messagesNotifier;

  Future<void> cacheMessagesLocally(List<ChatBotMessage> messages) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> messagesJson = messages.map((msg) => jsonEncode(msg.toJson())).toList();

    await prefs.setStringList('cached_chatbot_messages', messagesJson);
  }
  Future<List<ChatBotMessage>> loadMessagesFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cachedJson = prefs.getStringList('cached_chatbot_messages');

    if (cachedJson == null) return [];

    return cachedJson
        .map((msgJson) {
      final Map<String, dynamic> msgMap = jsonDecode(msgJson);
      return ChatBotMessage.fromJson(msgMap);
    })
        .toList();
  }

  @override
  Future<Either<Failure, List<ChatBotMessage>>> getMessages() async {
    if (_cachedMessages != null) {
      print("📦 [DEBUG] Returning cached chatbot messages");
      return Right(_cachedMessages!);
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لجلب رسائل الشات بوت",
          errors: ["التوكين غير موجود"],
        ));
      }

      final Either<Failure, List<ChatBotMessage>> response = await apiService.getChatPotMessages(token: token);

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in GetChatBotRepoImp: $failure");
          return Left(failure);
        },
            (messages) {
          print("✅ [DEBUG] Caching chatbot messages and updating notifier");
          _cachedMessages = messages;
          _messagesNotifier.value = List.from(messages);
          cacheMessagesLocally(messages);
          return Right(messages);
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in GetChatBotRepoImp: $e");

      final cachedMessages = await loadMessagesFromCache();
      if (cachedMessages.isNotEmpty) {
        print("📦 [DEBUG] Returning chatbot messages from cache");
        _cachedMessages = cachedMessages;
        _messagesNotifier.value = List.from(cachedMessages);
        return Right(cachedMessages);
      } else {
        return Left(ServiceFailure(
          errorMessage: "حدث خطأ غير متوقع ولا توجد بيانات محفوظة",
          errors: [e.toString()],
        ));
      }
    }
  }

  void addNewMessage(ChatBotMessage message) {
    _cachedMessages ??= [];
    _cachedMessages!.add(message);
    _messagesNotifier.value = List.from(_cachedMessages!);
    print("📥 [DEBUG] New ChatBot message added");
  }

  void clearMessagesCache() {
    _cachedMessages = null;
    _messagesNotifier.value = [];
    print("♻️ [DEBUG] ChatBot messages cache cleared");
  }


  @override
  Future<Either<Failure, Map<String, dynamic>>> sendMessage(String message) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لإرسال رسالة",
          errors: ["التوكين غير موجود"],
        ));
      }

      final response = await apiService.chatBotSendMessage(
        token: token,
        message: message,
      );

      print("✅ [DEBUG] SendChatBotRepoImp Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in SendChatBotRepoImp Repo: $failure");
          return Left(failure);
        },
            (success) {
          print("✅ [DEBUG] ChatBot message sent successfully with response: $success");
          return Right(success);
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in SendChatBotRepoImp Repo: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء إرسال الرسالة",
        errors: [e.toString()],
      ));
    }
  }

}
