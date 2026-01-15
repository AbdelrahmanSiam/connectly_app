import 'package:connectly/core/routing/app_router.dart';
import 'package:connectly/core/utils/app_text_styles.dart';
import 'package:connectly/features/home/data/models/user_model.dart';
import 'package:connectly/features/home/presentation/views/widgets/dot_widet.dart';
import 'package:connectly/features/home/presentation/views/widgets/profile_pic_widget.dart';
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
            ProfilePicWidget(userModel: userModel),
            userModel.onlineState
                ? DotWidget()
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
