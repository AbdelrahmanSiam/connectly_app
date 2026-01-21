import 'package:connectly_app/core/routing/app_router.dart';
import 'package:connectly_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:connectly_app/features/verifiy/presentation/views/widgets/resend_email_button.dart';
import 'package:connectly_app/features/verifiy/presentation/views/widgets/verifiedButton.dart';
import 'package:connectly_app/features/verifiy/presentation/views/widgets/verify_email_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VerifyEmailViewBody extends StatelessWidget {
const VerifyEmailViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          context.go(AppRouter.homeView); // if email verified and logged in this is success state
        }

        if (state is AuthFailureState) {
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
          children: [
            VerifyEmailHeader(),
            SizedBox(height: 40),
            ResendEmailButton(),
            SizedBox(height: 16),
            Verifiedbutton(),
          ],
        ),
      ),
    );
  }
}
