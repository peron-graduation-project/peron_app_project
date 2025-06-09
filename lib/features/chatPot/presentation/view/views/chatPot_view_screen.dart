import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/features/chatPot/presentation/manager/chatPot_cubit.dart';
import 'package:peron_project/features/chatPot/presentation/manager/chatPot_state.dart';

class ChatpotViewScreen extends StatefulWidget {
  ChatpotViewScreen({super.key});

  @override
  State<ChatpotViewScreen> createState() => _ChatpotViewScreenState();
}

class _ChatpotViewScreenState extends State<ChatpotViewScreen> {
  final TextEditingController _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ChatBotCubit>().getMessages();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: CustomArrowBack(),
          title: Text(
            "مساعد بيرون",
            style: theme.headlineMedium!.copyWith(fontSize: screenWidth * 0.05),
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<ChatBotCubit, ChatBotState>(
                    builder: (context, state) {
                      if (state is ChatLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is ChatLoaded) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          scrollToBottom();
                        });
                        return ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                          itemCount: state.messages.length,
                          itemBuilder: (context, index) {
                            final message = state.messages[index];
                            return ListTile(
                              title: Text(message.messageText ?? ''),
                            );
                          },
                        );
                      } else if (state is ChatError) {
                        return Center(child: Text(state.error));
                      } else {
                        return Center(child: Text("لا توجد رسائل"));
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          style: TextStyle(fontSize: screenWidth * 0.038),
                          decoration: InputDecoration(
                            hintText: 'استفسر عن أي شيء',
                            hintStyle: TextStyle(
                              fontSize: screenWidth * 0.038,
                              color: Colors.grey[700],
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(
                                screenWidth * 0.03,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(
                                screenWidth * 0.03,
                              ),
                            ),
                            contentPadding: EdgeInsetsDirectional.only(
                              start: screenWidth * 0.04,
                              top: screenHeight * 0.015,
                              bottom: screenHeight * 0.015,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Container(
                        height: screenWidth * 0.12,
                        width: screenWidth * 0.12,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            final message = _messageController.text.trim();
                            if (message.isNotEmpty) {
                              context.read<ChatBotCubit>().sendMessage(message);
                              _messageController.clear();
                              FocusScope.of(context).unfocus();
                              scrollToBottom();
                            }
                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: screenWidth * 0.05,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
