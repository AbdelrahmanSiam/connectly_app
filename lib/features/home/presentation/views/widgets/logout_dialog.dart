import 'package:connectly_app/core/routing/app_router.dart';
import 'package:connectly_app/core/utils/app_colors.dart';
import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title:  Text('Logout',style: AppTextStyles.textStyle32.copyWith(color: AppColors.deepPrimary),),
      content:  Text(
        'Are you sure you want to logout?',
        style: AppTextStyles.textStyle22.copyWith(color: AppColors.primary),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child:  Text('Cancel',style: AppTextStyles.textStyle16.copyWith(color: AppColors.primary),),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // close dialog first
            context.pushReplacement(AppRouter.loginView);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child:  Text('OK',style: AppTextStyles.textStyle16.copyWith(color: AppColors.primary),),
        ),
      ],
    );
  }
}
