import 'package:connectly_app/features/chat/data/model/message_model.dart';
import 'package:connectly_app/features/chat/presentation/manager/chat_cubit/chat_cubit.dart';
import 'package:connectly_app/features/chat/presentation/views/widgets/show_edit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageActionsBody extends StatelessWidget {
  const MessageActionsBody({
    super.key,
    required this.chatId,
    required this.messageModel,
  });

  final String chatId;
  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit'),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return BlocProvider.value(
                    value: context.read<ChatCubit>(),
                    child: ShowEditDialog(
                      chatId: chatId,
                      messageModel: messageModel,
                    ),
                  );
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text('Delete'),
            onTap: () {
              Navigator.pop(context);
              context.read<ChatCubit>().deleteMessage(
                    chatId,
                    messageModel.messageId,
                  );
            },
          ),
        ],
      ),
    );
  }
}
