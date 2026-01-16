import 'package:connectly/core/utils/app_colors.dart';
import 'package:connectly/features/chat/presentation/views/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';

class ChatViewBody extends StatelessWidget {
  const ChatViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ChatBubble(message: "message", isMe: false);
              }),
        ),
      ],
    );
  }
}
