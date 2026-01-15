
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectly/core/utils/assets_data.dart';
import 'package:connectly/features/home/data/models/user_model.dart';
import 'package:flutter/material.dart';

class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundImage: userModel.profilePicUrl != null
          ? CachedNetworkImageProvider(userModel.profilePicUrl!)
          : AssetImage(AssetsData.logo) as ImageProvider,
    );
  }
}
