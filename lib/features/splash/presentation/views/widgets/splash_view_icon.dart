import 'package:connectly/core/utils/app_colors.dart';
import 'package:connectly/core/utils/app_text_styles.dart';
import 'package:connectly/core/utils/assets_data.dart';
import 'package:flutter/material.dart';

class SplashViewIcon extends StatelessWidget {
  const SplashViewIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
            radius: 100,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(AssetsData.logo))),
        Text(
          "Connectly",
          style: AppTextStyles.textStyle32.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
