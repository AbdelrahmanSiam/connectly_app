import 'package:connectly/core/utils/app_text_styles.dart';
import 'package:connectly/features/chat/presentation/views/widgets/chat_view_body.dart';
import 'package:connectly/features/home/data/models/user_model.dart';
import 'package:connectly/features/home/presentation/views/widgets/profile_pic_widget.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2C2C2C),
        leading: BackButton(),
        title: Row(
          children: [
            ProfilePicWidget(userModel: userModel),
            SizedBox(
              width: 10,
            ),
            Text(userModel.name, style: AppTextStyles.textStyle18),
          ],
        ),
      ),
      body: ChatViewBody(),
    );
  }
}
