import 'package:connectly_app/core/utils/app_colors.dart';
import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:connectly_app/features/chat/data/model/message_model.dart';
import 'package:connectly_app/features/chat/presentation/manager/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowEditDialog extends StatefulWidget {
  const ShowEditDialog({
    super.key,
    required this.chatId,
    required this.messageModel,
  });

  final String chatId;
  final MessageModel messageModel;

  @override
  State<ShowEditDialog> createState() => _ShowEditDialogState();
}

class _ShowEditDialogState extends State<ShowEditDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.messageModel.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSave(BuildContext context) {
    final newText = _controller.text.trim();
    if (newText.isEmpty || newText == widget.messageModel.text) return;

    context.read<ChatCubit>().editMessage(
          widget.chatId,
          widget.messageModel.messageId,
          newText,
        );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),side: BorderSide(color: AppColors.deepPrimary)
      ),
      title: Text(
        'Edit Message',
        style: AppTextStyles.textStyle22.copyWith(color: AppColors.deepPrimary),
      ),
      content: TextField(
        controller: _controller,
        maxLines: 3,
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Enter new message',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.deepPrimary)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.deepPrimary,width: 2),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade300,
          ),
          child: Text('Cancel',style: TextStyle(color: AppColors.primary),),
        ),
        ElevatedButton(
          onPressed: () => _onSave(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
          ),
          child: const Text('Save',style: TextStyle(color: Colors.white),),
        ),
      ],
    );
  }
}
