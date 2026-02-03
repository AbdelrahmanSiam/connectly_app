import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

class CustomChatListTile extends StatelessWidget {
  const CustomChatListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22.0),
      child: Row(
        children: [
          ProfileAvatar(
            radius: 30,
            showOnlineIndicator: true,
            isOnline: true,
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
                "Abdelrahman",
                style: AppTextStyles.textStyle22,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "last message",
                style: AppTextStyles.textStyle16.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.grey.shade600),
              ),
            ],
          ),
          Spacer(),
          Text(
            "10:18 PM",
            style: AppTextStyles.textStyle16.copyWith(
                fontWeight: FontWeight.bold, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
