import 'package:connectly_app/features/profile/presentation/views/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

class CreateChatBottomSheet extends StatelessWidget {
  const CreateChatBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ListView.separated(
          itemBuilder: (context , index){
            // return UserListTile();
          },
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemCount: 10),
    );
  }
}

