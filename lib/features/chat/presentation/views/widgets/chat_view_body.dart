import 'package:connectly_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:connectly_app/features/chat/presentation/manager/chat_cubit/chat_cubit.dart';
import 'package:connectly_app/features/chat/presentation/views/widgets/message_bubble.dart';
import 'package:connectly_app/features/chat/presentation/views/widgets/message_input_field.dart';
import 'package:connectly_app/core/widgets/custom_failure_body.dart';
import 'package:connectly_app/core/widgets/custom_initial_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatViewBody extends StatelessWidget {
  const ChatViewBody({super.key, required this.chatId});
  final String chatId;
  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state is ChatInitialState) {
                return CustomInitialBody(
                  icon: Icons.edit_off,
                    text: "No messages yet , start Chatting. ");
              }
              if (state is ChatFailureState) {
                return CustomFailureBody(
                  text: 'Error: ${state.errMessage}',
                );
              }
              if (state is ChatSuccesState) {
                return ListView.builder(
                  reverse: true,
                  itemCount: state.messageList.length,
                  itemBuilder: (context, index) {
                    final isMe = state.messageList[index].senderId ==
                        context.read<AuthCubit>().currentUserId();
                    return MessageBubble(
                        messageModel: state.messageList[index], isMe: isMe);
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        MessageInputField(
            controller: messageController,
            onSend: () {
              context.read<ChatCubit>().sendMessage(
                    chatId,
                    messageController.text,
                  );
              messageController.clear();
            })
      ],
    );
  }
}
