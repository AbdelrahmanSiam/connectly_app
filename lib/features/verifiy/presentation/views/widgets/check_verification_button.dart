import 'package:connectly_app/features/verifiy/presentation/manager/email_verification_cubit/email_verification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckVerificationButton extends StatelessWidget {
  const CheckVerificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<EmailVerificationCubit>().checkVerification();
      },
      child: const Text('I have verified my email'),
    );
  }
}
