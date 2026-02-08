import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:connectly_app/features/chat/data/model/message_model.dart';
import 'package:connectly_app/features/chat/presentation/manager/chat_cubit/chat_cubit.dart';
import 'package:connectly_app/features/chat/presentation/views/helper/chat_view_helper.dart';
import 'package:connectly_app/features/chat/presentation/views/widgets/message_action_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel messageModel;
  final bool isMe;
  final String chatId;

  const MessageBubble({
    super.key,
    required this.messageModel,
    required this.isMe,
    required this.chatId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (isMe && !messageModel.isDeleted) {
          showModalBottomSheet(
            context: context,
            builder: (sheetContext) {
              return BlocProvider.value(
                value: context.read<ChatCubit>(),
                child: MessageActionsBody(
                  chatId: chatId,
                  messageModel: messageModel,
                ),
              );
            },
          );
        }
      },
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          constraints: BoxConstraints(
            maxWidth:
                MediaQuery.of(context).size.width * 0.75, // to be responsive
          ),
          decoration: BoxDecoration(
            color: bubbleColor(messageModel, isMe),
            borderRadius: bubbleRadius(isMe),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                messageModel.isDeleted
                    ? '🚫 Message deleted'
                    : messageModel.text,
                style: AppTextStyles.textStyle18.copyWith(
                  color: isMe ? Colors.white : Colors.black,
                  fontStyle: messageModel.isDeleted ? FontStyle.italic : null,
                ),
              ),
              if (messageModel.isEdited && !messageModel.isDeleted)
                const SizedBox(height: 4),
              if (messageModel.isEdited && !messageModel.isDeleted)
                 Text(
                  'Edited',
                  style: AppTextStyles.textStyle16.copyWith(color: Colors.white70),
                ),
            ],
          ),
        ),
      )
          .animate()
          .fadeIn(duration: 200.ms)
          .scale(begin: Offset(0.8, 0.8), curve: Curves.easeInOutBack),
    );
  }
}
