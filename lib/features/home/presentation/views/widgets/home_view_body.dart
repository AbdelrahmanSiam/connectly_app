import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:connectly_app/features/home/presentation/views/widgets/custom_chat_list_tile.dart';
import 'package:connectly_app/features/home/presentation/views/widgets/home_view_app_bar.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeViewAppBar(),
        SizedBox(height: 20,),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder:(context , index) => CustomChatListTile()),
        ),
      ],
    );
  }
}

