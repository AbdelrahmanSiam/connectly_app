import 'package:connectly_app/core/utils/app_colors.dart';
import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:connectly_app/features/home/presentation/views/widgets/home_view_menu.dart';
import 'package:flutter/material.dart';

class HomeViewAppBar extends StatelessWidget {
  const HomeViewAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Connect Ly" ,style: AppTextStyles.textStyle32.copyWith(color: AppColors.deepPrimary),),
        Spacer(),
         HomeViewMenu(),
      ],
    );
  }
}

