import 'package:connectly_app/core/utils/service_locator.dart';
import 'package:connectly_app/features/chat/presentation/manager/chat_cubit/chat_cubit.dart';
import 'package:connectly_app/features/chat/presentation/views/widgets/chat_view_app_bar.dart';
import 'package:connectly_app/features/chat/presentation/views/widgets/chat_view_body.dart';
import 'package:connectly_app/features/profile/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.chatId, required this.otherUser});
  final String chatId;
  final UserModel otherUser;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChatCubit>()..loadMessages(chatId),
      child: Scaffold(
        appBar: ChatViewAppBar(otherUser: otherUser),
        body: ChatViewBody(
          chatId: chatId,
          receiverId:otherUser.id,
        ),
      ),
    );
  }
}
