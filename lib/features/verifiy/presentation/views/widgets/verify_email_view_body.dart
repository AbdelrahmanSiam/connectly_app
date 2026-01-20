import 'package:connectly_app/features/verifiy/presentation/manager/email_verification_cubit/email_verification_cubit.dart';
import 'package:connectly_app/features/verifiy/presentation/views/widgets/resend_email_button.dart';
import 'package:connectly_app/features/verifiy/presentation/views/widgets/verify_email_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailViewBody extends StatefulWidget {
  const VerifyEmailViewBody({super.key});

  @override
  State<VerifyEmailViewBody> createState() => _VerifyEmailViewBodyState();
}

class _VerifyEmailViewBodyState extends State<VerifyEmailViewBody> {
  @override
  void initState() {
    super.initState();
    // Send verification email automatically when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        print(
            "📧 VerifyEmailViewBody: Page loaded, initiating email verification...");
        BlocProvider.of<EmailVerificationCubit>(context)
            .sendVerificationEmail();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmailVerificationCubit, EmailVerificationState>(
      listener: (context, state) {
        if (state is EmailVerificationSentState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Verification email sent. Check your inbox'),
            ),
          );
        }

        if (state is EmailVerificationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
            ),
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
          ],
        ),
      ),
    );
  }
}
