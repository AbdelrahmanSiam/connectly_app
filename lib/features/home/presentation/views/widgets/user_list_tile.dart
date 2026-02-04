import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:connectly_app/features/profile/data/model/user_model.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    super.key,
    required this.otherUserModel,
    this.onTap,
  });
  final UserModel otherUserModel;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ProfileAvatar(
        imageUrl: otherUserModel.profilePictureUrl,
        radius: 20,
        showOnlineIndicator: true,
        isOnline: otherUserModel.isOnline,
        borderWidth: 2,
        showBoxShadow: false,
        onlineCircularSize: 10,
        onlineCircularPosition: 1,
      ),
      title: Text(
        otherUserModel.name,
        style: AppTextStyles.textStyle18,
      ),
      subtitle: Text(
        otherUserModel.email,
        style: AppTextStyles.textStyle16
            .copyWith(fontWeight: FontWeight.bold, color: Colors.grey.shade600),
      ),
      onTap: onTap,
    );
  }
}
