import 'package:connectly_app/core/routing/app_router.dart';
import 'package:connectly_app/core/utils/app_colors.dart';
import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:connectly_app/features/home/presentation/views/widgets/home_view_menu.dart';
import 'package:connectly_app/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("Connect Ly" ,style: AppTextStyles.textStyle32.copyWith(color: AppColors.deepPrimary),),
            Spacer(),
             HomeViewMenu(),
          ],
        ),
      ],
    );
  }
}

