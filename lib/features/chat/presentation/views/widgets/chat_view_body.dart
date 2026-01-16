import 'package:connectly/features/chat/presentation/views/widgets/chat_bubble.dart';
import 'package:connectly/features/chat/presentation/views/widgets/chat_view_text_field.dart';
import 'package:flutter/material.dart';

class ChatViewBody extends StatelessWidget {
  const ChatViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return ChatBubble(message: "message", isMe: false);
                    },
                  ),
                ),
              ],
            ),
          ),
          ChatViewTextField(),
        ],
      ),
    );
  }
}
