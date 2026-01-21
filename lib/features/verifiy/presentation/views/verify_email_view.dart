import 'package:connectly_app/features/verifiy/presentation/views/widgets/verify_email_view_body.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key,});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: VerifyEmailViewBody(),
      ),
    );
  }
}
