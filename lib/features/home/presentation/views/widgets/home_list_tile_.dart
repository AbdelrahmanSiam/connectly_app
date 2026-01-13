import 'package:connectly/core/utils/app_text_styles.dart';
import 'package:connectly/core/utils/assets_data.dart';
import 'package:flutter/material.dart';

class HomeListTileWidget extends StatelessWidget {
  const HomeListTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(AssetsData.logo),
            ),
            // Online Status Dot
            Positioned(
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
            ),
          ],
        ),
        title: Text(
          "Abdo",
          style: AppTextStyles.textStyle18,
        ),
        subtitle: Text("data"),
        trailing: Icon(Icons.check), // أيقونة للدردشة
        onTap: () {
          // لاحقًا: navigate to Chat Screen
        },
      ),
    );
  }
}
