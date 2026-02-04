import 'package:connectly_app/features/chat/presentation/views/widgets/chat_view_body.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.chatId});
  final String chatId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatViewBody(chatId: chatId,),
    );
  }
}