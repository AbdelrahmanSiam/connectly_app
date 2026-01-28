import 'package:connectly_app/core/routing/app_router.dart';
import 'package:connectly_app/core/utils/app_colors.dart';
import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:connectly_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOutState) {
          Navigator.pop(context); // close dialog first
          context.pushReplacement(AppRouter.loginView);
        }
      },
      builder: (context, state) {
        final isLoading = state is LogoutLoadingState;

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Logout',
            style: AppTextStyles.textStyle32
                .copyWith(color: AppColors.deepPrimary),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: AppTextStyles.textStyle22.copyWith(color: AppColors.primary),
          ),
          actions: [
            TextButton(
              onPressed: isLoading
                  ? null
                  : () {
                      Navigator.pop(context);
                    },
              child: Text(
                'Cancel',
                style: AppTextStyles.textStyle16
                    .copyWith(color: AppColors.primary),
              ),
            ),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      BlocProvider.of<AuthCubit>(context).logout();
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: isLoading ? Colors.grey : Colors.red,
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'OK',
                      style: AppTextStyles.textStyle16
                          .copyWith(color: AppColors.primary),
                    ),
            ),
          ],
        );
      },
    );
  }
}
