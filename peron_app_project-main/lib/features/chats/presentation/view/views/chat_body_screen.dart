import 'package:flutter/material.dart';

import '../widgets/chat_app_bar.dart';
import '../widgets/date_separator.dart';
import '../widgets/message_input.dart';
import '../widgets/message_list.dart';


class ChatBodyScreen extends StatefulWidget {
  final String name;
  final String image;
  const ChatBodyScreen({super.key, required this.name, required this.image});

  @override
  _ChatBodyScreenState createState() => _ChatBodyScreenState();
}

class _ChatBodyScreenState extends State<ChatBodyScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [
    {"text": "عاوزه استفسر عن سعر الشقة؟", "time": "9:36", "isSent": "true"},
    {"text": "وهل في عروض؟", "time": "9:37", "isSent": "true"},
    {"text": "معاك يافندم اتفضل ؟", "time": "9:38", "isSent": "false"},
    {"text": "للأسف مفيش عروض حاليا", "time": "9:38", "isSent": "false"},
    {"text": "تمام", "time": "9:39", "isSent": "true"},
  ];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add({"text": _controller.text, "time": "الآن", "isSent": "true"});
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: ChatAppBar(name: widget.name, image: widget.image, screenWidth: screenWidth),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 16),
        child: Column(
          children: [
            const Divider(thickness: 1),
            DateSeparator(screenWidth: screenWidth),
            Expanded(child: MessageList(messages: messages, screenWidth: screenWidth)),
            MessageInput(controller: _controller, sendMessage: _sendMessage, screenWidth: screenWidth),
          ],
        ),
      ),
    );
  }
}




