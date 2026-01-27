import 'package:connectly_app/core/routing/app_router.dart';
import 'package:connectly_app/core/utils/app_colors.dart';
import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Verifiedbutton extends StatelessWidget {
  const Verifiedbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
          onPressed:() {
                  context.go(AppRouter.loginView);
                },
          child:  Text('I Verified My Email', style: AppTextStyles.textStyle16.copyWith(color: AppColors.primary),),
        );
  }
}
