import 'package:connectly_app/core/routing/app_router.dart';
import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigatorToLoginSection extends StatelessWidget {
  const NavigatorToLoginSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account?",
            style: AppTextStyles.textStyle18
                .copyWith(color: Colors.black)),
        CustomTextButton(
          text: 'Login',
          onPressed: () {
            context.go(AppRouter.loginView);
          },
        ),
      ],
    );
  }
}

