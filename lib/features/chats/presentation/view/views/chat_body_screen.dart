import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';

import '../../manager/get conversation/get_conversation_cubit.dart';
import '../../manager/get conversation/get_conversation_state.dart';
import '../../manager/send message/send_message_cubit.dart';
import '../../manager/send message/send_message_state.dart';
import '../widgets/chat_app_bar.dart';
import '../widgets/date_separator.dart';
import '../widgets/message_input.dart';
import '../widgets/message_list.dart';

class ChatBodyScreen extends StatefulWidget {
  final String name;
  final String image;
  final String id;
  final String date;


  const ChatBodyScreen({
    super.key,
    required this.name,
    required this.image,
    required this.id,
    required this.date,
  });

  @override
  State<ChatBodyScreen> createState() => _ChatBodyScreenState();
}

class _ChatBodyScreenState extends State<ChatBodyScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<GetConversationCubit>().getConversations(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocListener<SendMessageCubit, SendMessageState>(
      listener: (context, state) {
        if (state is SendMessageStateSuccess) {
          context.read<GetConversationCubit>().getConversations(id: widget.id);
        } else if (state is SendMessageStateFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      child: Scaffold(
        appBar: ChatAppBar(name: widget.name, image: widget.image, screenWidth: screenWidth),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
          child: Column(
            children: [
              DateSeparator(screenWidth: screenWidth, date: widget.date),
              Expanded(
                child: BlocBuilder<GetConversationCubit, GetConversationState>(
                  builder: (context, state) {
                    if (state is GetConversationStateSuccess) {
                      if (state.conversations.isEmpty) {
                        return const Center(child: Text("لا توجد رسائل بعد"));
                      }
                      return MessageList(
                        messages: state.conversations,
                        screenWidth: screenWidth,
                      );
                    } else if (state is GetConversationStateFailure) {
                      return const Center(child: Text("حدث خطأ أثناء تحميل المحادثة"));
                    } else {
                      return Center(child: CircularProgressIndicator(
                        backgroundColor: AppColors.primaryColor,
                      ));
                    }
                  },
                ),
              ),
              MessageInput(controller: _controller, sendMessage: _sendMessage, screenWidth: screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      final state = context.read<GetConversationCubit>().state;
      if (state is GetConversationStateSuccess) {
        final message = _controller.text;
    final String receiverId = state.conversations.first.id.toString();

        context.read<GetConversationCubit>().addSentMessage(
          message: message,
        );
        context.read<SendMessageCubit>().sendMessage(
          id: receiverId,
          message: message,
        );

        _controller.clear();
      }
    }
  }
}
