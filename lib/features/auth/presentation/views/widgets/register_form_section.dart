import 'package:connectly_app/features/auth/presentation/views/helpers/helper_methods.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class FormSection extends StatelessWidget {
  const FormSection({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          labelText: 'Name',
          controller: name,
          icon: Icons.person,
          validator: (value) {
            return nullValidationMethod(value);
          },
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          labelText: 'Email',
          icon: Icons.email,
          controller: email,
          validator: (value) {
            return nullValidationMethod(value);
          },
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          labelText: 'Password',
          isPassword: true,
          icon: Icons.password,
          controller: password,
          validator: (value) {
            return nullValidationMethod(value);
          },
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          labelText: 'Confirm password',
          isPassword: true,
          icon: Icons.password,
          controller: confirmPassword,
          validator: (value) {
            if (value != password.text) {
              return 'Confirm password is wrong';
            }
            return nullValidationMethod(value);
          },
        ),
      ],
    );
  }
}
