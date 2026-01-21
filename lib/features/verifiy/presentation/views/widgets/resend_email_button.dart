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
          child: const Text('Resend verification email'),
        );
  }
}
