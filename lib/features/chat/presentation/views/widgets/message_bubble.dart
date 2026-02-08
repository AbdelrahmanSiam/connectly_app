import 'package:connectly_app/core/utils/app_colors.dart';
import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:connectly_app/features/chat/data/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel messageModel;
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.messageModel,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75, // to be responsive
        ),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primary : Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft:
                isMe ? const Radius.circular(18) : const Radius.circular(4),
            bottomRight:
                isMe ? const Radius.circular(4) : const Radius.circular(18),
          ),
        ),
        child: Text(
          messageModel.text,
          style: AppTextStyles.textStyle16.copyWith(color: isMe ? Colors.white : Colors.black,fontWeight: FontWeight.bold),
        ),
      ),
    )
    .animate().fadeIn(duration: 200.ms).scale(begin: Offset(0.8, 0.8) , curve: Curves.easeInOutBack);
  }
}
