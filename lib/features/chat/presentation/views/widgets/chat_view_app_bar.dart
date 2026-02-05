import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:connectly_app/features/profile/data/model/user_model.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

class ChatViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final UserModel otherUser;

  const ChatViewAppBar({super.key, required this.otherUser});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      titleSpacing: 0,
      title: Row(
        children: [
          ProfileAvatar(
            imageUrl: otherUser.profilePictureUrl,
            radius: 25,
            showOnlineIndicator: true,
            isOnline: otherUser.isOnline,
            borderWidth: 3,
            showBoxShadow: false,
            onlineCircularSize: 15,
            onlineCircularPosition: -1,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                otherUser.name,
                style: AppTextStyles.textStyle18,
              ),
              Text(
                otherUser.isOnline ? 'Online' : 'Offline',
                style: AppTextStyles.textStyle16.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
