import 'package:connectly_app/core/utils/app_colors.dart';
import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:connectly_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResendEmailButton extends StatelessWidget {
  const ResendEmailButton({super.key,});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
          onPressed: () {
                    context
                        .read<AuthCubit>()
                        .resendVerificationEmail();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Verification email sent again'),
                      ),
                    );
                  },
          child:  Text('Resend verification email' , style: AppTextStyles.textStyle16.copyWith(color: AppColors.primary),),
        );
  }
}
