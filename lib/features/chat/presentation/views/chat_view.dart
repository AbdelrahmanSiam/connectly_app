import 'package:connectly_app/core/utils/service_locator.dart';
import 'package:connectly_app/features/chat/presentation/manager/chat_cubit/chat_cubit.dart';
import 'package:connectly_app/features/chat/presentation/views/widgets/chat_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.chatId});
  final String chatId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<ChatCubit>()..loadMessages(chatId),
        child: ChatViewBody(
          chatId: chatId,
        ),
      ),
    );
  }
}
