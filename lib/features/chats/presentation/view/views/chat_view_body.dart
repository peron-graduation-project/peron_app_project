import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/network/api_service.dart';
import 'package:peron_project/features/chats/domain/repos/get%20conversation/get_conversation_repo_imp.dart';
import 'package:peron_project/features/chats/domain/repos/send%20message/send_message_repo_imp.dart';
import 'package:peron_project/features/chats/presentation/manager/send%20message/send_message_cubit.dart';
import '../../../data/models/chat_model.dart';
import '../../manager/get chats/get_chats_cubit.dart';
import '../../manager/get chats/get_chats_state.dart';
import '../../manager/get conversation/get_conversation_cubit.dart';
import 'chat_body_screen.dart';

class ChatViewBody extends StatefulWidget {
  const ChatViewBody({super.key});

  @override
  _ChatViewBodyState createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  List<ChatModel> filteredChats = [];
  Set<int> selectedChats = {};
  bool isSelectionMode = false;

  @override
  void initState() {
    super.initState();
    context.read<GetChatsCubit>().getChats();
  }

  void _filterChats(String query, List<ChatModel> chats) {
    setState(() {
      if (query.isEmpty) {
        filteredChats = List.from(chats);
      } else {
        filteredChats =
            chats
                .where(
                  (chat) =>
                      chat.name.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
      }
    });
  }

  void _toggleSelection(int index) {
    setState(() {
      if (selectedChats.contains(index)) {
        selectedChats.remove(index);
        if (selectedChats.isEmpty) {
          isSelectionMode = false;
        }
      } else {
        selectedChats.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var theme = Theme.of(context).textTheme;

    return BlocBuilder<GetChatsCubit, GetChatsState>(
      builder: (context, state) {
        List<ChatModel> chats = [];

        if (state is GetChatsStateSuccess) {
          chats = state.chats;
          if (filteredChats.isEmpty || filteredChats.length != chats.length) {
            filteredChats = List.from(chats);
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "المحادثات",
              style: theme.headlineMedium!.copyWith(fontSize: 20),
            ),
            centerTitle: true,
            leading:
                isSelectionMode
                    ? IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          isSelectionMode = false;
                          selectedChats.clear();
                        });
                      },
                    )
                    : null,
            actions: [
              PopupMenuButton<String>(
                color: AppColors.scaffoldBackgroundColor,
                onSelected: (value) {
                  if (value == "delete") {
                    setState(() {
                      selectedChats.forEach((index) {
                        chats.removeAt(index);
                      });
                      selectedChats.clear();
                      isSelectionMode = false;
                    });
                  } else if (value == "archive" || value == "pin") {
                    print("تم اختيار: $value");
                  }
                },
                itemBuilder:
                    (context) => [
                      PopupMenuItem(
                        value: "delete",
                        child: Row(
                          children: [
                            Text(
                              "حذف",
                              style: theme.labelLarge!.copyWith(
                                color: Color(0xff282929),
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.delete, color: Colors.grey),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: "archive",
                        child: Row(
                          children: [
                            Text(
                              "أرشيف",
                              style: theme.labelLarge!.copyWith(
                                color: Color(0xff282929),
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.archive, color: Colors.grey),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: "pin",
                        child: Row(
                          children: [
                            Text(
                              "تثبيت",
                              style: theme.labelLarge!.copyWith(
                                color: Color(0xff282929),
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.push_pin, color: Colors.grey),
                          ],
                        ),
                      ),
                    ],
              ),
            ],
          ),
          body:
              state is GetChatsStateLoading
                  ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: AppColors.primaryColor,
                    ),
                  )
                  : Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.03),
                        child: TextField(
                          onChanged: (query) => _filterChats(query, chats),
                          decoration: InputDecoration(
                            hintText: "ابحث عن الاسم...",
                            hintStyle: theme.displayMedium!.copyWith(
                              color: Color(0xff818181),
                            ),
                            prefixIcon: const Icon(Icons.search),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                screenWidth * 0.03,
                              ),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                screenWidth * 0.03,
                              ),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 123, 122, 122),
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredChats.length,
                          itemBuilder: (context, index) {
                            final chat = filteredChats[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.005,
                                horizontal: screenWidth * 0,
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.04,
                                ),
                                tileColor:
                                    selectedChats.contains(index)
                                        ? Colors.grey.shade300
                                        : Colors.transparent,
                                leading: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: screenWidth * 0.10,
                                      backgroundColor: Colors.grey[300],
                                      backgroundImage:
                                          chat.photo.isNotEmpty
                                              ? NetworkImage(chat.photo)
                                              : AssetImage(
                                                    "assets/images/no pic.jpg",
                                                  )
                                                  as ImageProvider,
                                    ),
                                    if (selectedChats.contains(index))
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromARGB(
                                              255,
                                              76,
                                              141,
                                              95,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      chat.name,
                                      style: theme.labelLarge!.copyWith(
                                        color: Color(0xff231F20),
                                      ),
                                    ),
                                    Text(
                                      chat.timestamp,
                                      style: theme.displayMedium!.copyWith(
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        chat.lastMessage,
                                        style: theme.bodySmall!.copyWith(
                                          color: Color(0xff818181),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    if (chat.unReadCount > 0)
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                            255,
                                            76,
                                            141,
                                            95,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          "${chat.unReadCount}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                onTap: () {
                                  if (isSelectionMode) {
                                    _toggleSelection(index);
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => MultiBlocProvider(
                                              providers: [
                                                BlocProvider<
                                                  GetConversationCubit
                                                >(
                                                  create:
                                                      (
                                                        _,
                                                      ) => GetConversationCubit(
                                                        GetConversationRepoImp(
                                                          ApiService(Dio()),
                                                        )..getconversation(
                                                          id: chat.chatWithId,
                                                        ),
                                                      ),
                                                ),
                                                BlocProvider<SendMessageCubit>(
                                                  create:
                                                      (
                                                        context,
                                                      ) => SendMessageCubit(
                                                        sendMessageRepo:
                                                            SendMessageRepoImp(
                                                              ApiService(Dio()),
                                                            ),
                                                        currentUserId:
                                                            chat.chatWithId,
                                                      ),
                                                ),
                                              ],
                                              child: ChatBodyScreen(
                                                date: chat.timestamp,
                                                name: chat.name,
                                                image: chat.photo,
                                                id: chat.chatWithId,
                                              ),
                                            ),
                                      ),
                                    );
                                  }
                                },
                                onLongPress: () {
                                  setState(() {
                                    isSelectionMode = true;
                                    _toggleSelection(index);
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
        );
      },
    );
  }
}
