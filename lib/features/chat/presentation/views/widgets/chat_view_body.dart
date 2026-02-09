import 'package:connectly_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:connectly_app/features/chat/presentation/manager/chat_cubit/chat_cubit.dart';
import 'package:connectly_app/features/chat/presentation/views/widgets/message_bubble.dart';
import 'package:connectly_app/features/chat/presentation/views/widgets/message_input_field.dart';
import 'package:connectly_app/core/widgets/custom_failure_body.dart';
import 'package:connectly_app/core/widgets/custom_initial_body.dart';
import 'package:connectly_app/features/profile/presentation/manager/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatViewBody extends StatelessWidget {
  const ChatViewBody({
    super.key,
    required this.chatId,
    required this.receiverId,
  });
  
  final String chatId, receiverId;

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    
    // ✅ Debug
    print('🔍 ChatViewBody - chatId: $chatId');
    print('🔍 ChatViewBody - receiverId: $receiverId');
    
    final currentUser = context.read<UserCubit>().currentUser;
    
    // ✅ Debug
    print('🔍 ChatViewBody - currentUser: $currentUser');
    print('🔍 ChatViewBody - currentUser.name: ${currentUser?.name}');
    
    if (currentUser == null) {
      return const Center(child: Text('User not loaded'));
    }

    return Column(
      children: [
        Expanded(
          child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state is ChatInitialState) {
                return const CustomInitialBody(
                  icon: Icons.edit_off,
                  text: "No messages yet, start Chatting.",
                );
              }
              if (state is ChatFailureState) {
                return CustomFailureBody(
                  text: 'Error: ${state.errMessage}',
                );
              }
              if (state is ChatSuccesState) {
                return ListView.builder(
                  itemCount: state.messageList.length,
                  itemBuilder: (context, index) {
                    final message = state.messageList[index];
                    
                    // ✅ Debug كل رسالة
                    print('🔍 Message ${index + 1}:');
                    print('   senderId: ${message.senderId}');
                    print('   senderName: ${message.senderName}');
                    print('   receiverId: ${message.receiverId}');
                    print('   text: ${message.text}');
                    
                    final isMe = message.senderId ==
                        context.read<AuthCubit>().currentUserId();
                    
                    return MessageBubble(
                      messageModel: message,
                      isMe: isMe,
                      chatId: chatId,
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        MessageInputField(
          controller: messageController,
          onSend: () {
            final text = messageController.text.trim();
            if (text.isEmpty) return;
            
            // ✅ Debug قبل الإرسال
            print('🔍 Sending message:');
            print('   chatId: $chatId');
            print('   text: $text');
            print('   senderName: ${currentUser.name}');
            print('   receiverId: $receiverId');
            
            context.read<ChatCubit>().sendMessage(
              chatId,
              text,
              currentUser.name,  // senderName
              receiverId,        // receiverId
            );
            messageController.clear();
          },
        )
      ],
    );
  }
}