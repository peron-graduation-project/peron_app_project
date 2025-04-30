import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback sendMessage;
  final double screenWidth;

  const MessageInput({super.key, required this.controller, required this.sendMessage, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.02),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "مراسله",
                hintStyle: theme.bodySmall!.copyWith(color: Color(0xff7D848D)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 123, 122, 122), width: 2),
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          CircleAvatar(
            radius: screenWidth * 0.06,
            backgroundColor: AppColors.primaryColor,
            child: IconButton(onPressed: sendMessage, icon: const Icon(Icons.send, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
