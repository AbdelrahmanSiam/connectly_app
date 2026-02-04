import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:connectly_app/features/home/data/model/chat_model.dart';
import 'package:connectly_app/features/profile/data/model/user_model.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomChatListTile extends StatelessWidget {
  const CustomChatListTile({
    super.key,
    required this.chatModel,
    required this.userModel,
  });
  final ChatModel chatModel;
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22.0),
      child: Row(
        children: [
          ProfileAvatar(
            imageUrl: userModel.profilePictureUrl,
            radius: 30,
            showOnlineIndicator: true,
            isOnline: userModel.isOnline,
            borderWidth: 3,
            showBoxShadow: false,
            onlineCircularSize: 15,
            onlineCircularPosition: 2,
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userModel.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.textStyle22,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                chatModel.lastMessage,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.textStyle16.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.grey.shade600),
              ),
            ],
          ),
          Spacer(),
          Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('hh:mm a').format(chatModel.lastMessageTime),
                    style: AppTextStyles.textStyle16,
                  ),
                  if (chatModel.lastSenderId == userModel.id)
                    const Icon(Icons.done_all, size: 16)
                ],
              ),
        ],
      ),
    );
  }
}
