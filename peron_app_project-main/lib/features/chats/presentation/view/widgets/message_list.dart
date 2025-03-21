import 'package:flutter/material.dart';

class MessageList extends StatelessWidget {
  final List<Map<String, String>> messages;
  final double screenWidth;

  const MessageList({super.key, required this.messages, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context).textTheme;
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        bool isSent = messages[index]["isSent"] == "true";
        return Align(
          alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: screenWidth * 0.03),
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(color: isSent ? Colors.green[100] : Colors.grey[300], borderRadius: BorderRadius.circular(10)),
            child: Text(messages[index]["text"]!, style: theme.bodySmall!.copyWith(color: Color(0xff292828))),
          ),
        );
      },
    );
  }
}
