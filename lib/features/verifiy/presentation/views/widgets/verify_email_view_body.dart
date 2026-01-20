import 'package:connectly_app/features/verifiy/presentation/manager/email_verification_cubit/email_verification_cubit.dart';
import 'package:connectly_app/features/verifiy/presentation/views/widgets/check_verification_button.dart';
import 'package:connectly_app/features/verifiy/presentation/views/widgets/resend_email_button.dart';
import 'package:connectly_app/features/verifiy/presentation/views/widgets/verify_email_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailViewBody extends StatelessWidget {
  const VerifyEmailViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmailVerificationCubit, EmailVerificationState>(
      listener: (context, state) {
        if (state is EmailVerificationSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Verification email sent')),
          );
        }

        if (state is EmailVerificationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            VerifyEmailHeader(),
            SizedBox(height: 40),
            ResendEmailButton(),
            SizedBox(height: 16),
            CheckVerificationButton(),
          ],
        ),
      ),
    );
  }
}
