import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:peron_project/features/chats/data/models/chat_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_service.dart';
import 'get_chats_repo.dart';

class GetChatsRepoImp implements GetChatsRepo {
  final ApiService apiService;
  GetChatsRepoImp(this.apiService);

  List<ChatModel>? _cachedChats;

  final ValueNotifier<List<ChatModel>> _chatsNotifier = ValueNotifier([]);

  @override
  ValueNotifier<List<ChatModel>> get chatsNotifier => _chatsNotifier;

  Future<void> cacheChatsLocally(List<ChatModel> chats) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> chatsJson = chats.map((chat) => chat.toJson()).cast<String>().toList();
    prefs.setStringList('cached_chats', chatsJson);
  }

  Future<List<ChatModel>> loadChatsFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cachedChatsJson = prefs.getStringList('cached_chats');

    if (cachedChatsJson == null) return [];

    return cachedChatsJson.map((chatJson) => ChatModel.fromJson(chatJson as Map<String, dynamic>)).toList();
  }

  @override
  Future<Either<Failure, List<ChatModel>>> getChats() async {
    if (_cachedChats != null) {
      print("📦 [DEBUG] Returning cached chats");
      return Right(_cachedChats!);
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لجلب المحادثات",
          errors: ["التوكين غير موجود"],
        ));
      }

      final Either<Failure, List<ChatModel>> response =
      await apiService.getChats(token: token);

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in GetChatsImp Repo: $failure");
          return Left(failure);
        },
            (chats) {
          print("✅ [DEBUG] Caching chats and updating notifier");
          _cachedChats = chats;
          _chatsNotifier.value = List.from(chats);
          cacheChatsLocally(chats);
          return Right(chats);
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in get Chats RepoImp: $e");

      final cachedChats = await loadChatsFromCache();
      if (cachedChats.isNotEmpty) {
        print("📦 [DEBUG] Returning cached chats from local storage");
        _cachedChats = cachedChats;
        _chatsNotifier.value = List.from(cachedChats);
        return Right(cachedChats);
      } else {
        return Left(ServiceFailure(
          errorMessage: "حدث خطأ غير متوقع ولا يوجد اتصال بالإنترنت أو بيانات مخزنة.",
          errors: [e.toString()],
        ));
      }
    }
  }

  @override
  void addNewChat(ChatModel chat) {
    _cachedChats ??= [];
    _cachedChats!.add(chat);
    _chatsNotifier.value = List.from(_cachedChats!);
    print("📥 [DEBUG] New chat added and UI updated");
  }

  @override
  void clearChatsCache() {
    _cachedChats = null;
    _chatsNotifier.value = [];
    print("♻️ [DEBUG] Chats cache cleared");
  }
}
