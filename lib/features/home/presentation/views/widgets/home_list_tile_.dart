import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectly/core/routing/app_router.dart';
import 'package:connectly/core/utils/app_text_styles.dart';
import 'package:connectly/core/utils/assets_data.dart';
import 'package:connectly/features/home/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeListTileWidget extends StatelessWidget {
  const HomeListTileWidget({
    super.key,
    required this.userModel,
  });
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: userModel.profilePicUrl != null
                  ? CachedNetworkImageProvider(userModel.profilePicUrl!)
                  : AssetImage(AssetsData.logo) as ImageProvider,
            ),
            userModel.onlineState
                ? Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.green, // online
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        title: Text(
          userModel.name,
          style: AppTextStyles.textStyle18,
        ),
        subtitle: Text(userModel.lastMessage),
        onTap: () {
          (context).go(AppRouter.chatView);
        },
      ),
    );
  }
}
