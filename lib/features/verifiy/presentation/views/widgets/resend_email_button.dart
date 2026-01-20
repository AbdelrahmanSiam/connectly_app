import 'package:connectly_app/features/verifiy/presentation/manager/email_verification_cubit/email_verification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResendEmailButton extends StatelessWidget {
  const ResendEmailButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailVerificationCubit, EmailVerificationState>(
      builder: (context, state) {
        final isLoading = state is EmailVerificationLoadingState;

        return ElevatedButton(
          onPressed: isLoading
              ? null
              : () {
                  BlocProvider.of<EmailVerificationCubit>(context).sendVerificationEmail();
                },
          child: isLoading
              ? const CircularProgressIndicator()
              : const Text('Resend verification email'),
        );
      },
    );
  }
}
