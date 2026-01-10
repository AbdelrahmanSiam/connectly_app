import 'package:connectly/core/routing/app_router.dart';
import 'package:connectly/core/utils/app_colors.dart';
import 'package:connectly/core/utils/app_text_styles.dart';
import 'package:connectly/features/auth/presentation/views/widgets/custom_auth_button.dart';
import 'package:connectly/features/auth/presentation/views/widgets/custom_text_button.dart';
import 'package:connectly/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:connectly/features/auth/presentation/views/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const PageHeader(header1: 'Create Account', header2: 'Register to get started'),
            const SizedBox(height: 100),
            const CustomTextFormField(
              hintText: 'Email',
              icon: Icons.email,
            ),
            const SizedBox(height: 20),
            const CustomTextFormField(
              hintText: 'Password',
              isPassword: true,
              icon: Icons.password,
            ),
            const SizedBox(height: 50),
            const CustomAuthButton(
              buttonText: "Register",
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?",
                    style: AppTextStyles.textStyle16),
                CustomTextButton(
                  text: 'Login',
                  onPressed: () {
                    context.go(AppRouter.loginView);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
