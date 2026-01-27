import 'package:connectly_app/core/routing/app_router.dart';
import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:connectly_app/core/widgets/custom_snackbar.dart';
import 'package:connectly_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:connectly_app/features/auth/presentation/views/helpers/helper_methods.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/custom_auth_button.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/custom_text_button.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const PageHeader(
                  header1: 'Create Account',
                  header2: 'Register to get started'),
              const SizedBox(height: 100),
              CustomTextFormField(
                labelText: 'Name',
                controller: name,
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
                    return 'Confirm password is required';
                  }
                  return nullValidationMethod(value);
                },
              ),
              const SizedBox(height: 50),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailureState) {
                    CustomSnackBar.show(context,
                        message: state.errMessage, type: SnackBarType.error);
                  } else if (state is EmailNotVerifiedState) {
                    CustomSnackBar.show(
                      context,
                      message:
                          "Account created successfully! , Now verifiy you email and Check your Spam. ",
                      type: SnackBarType.success,
                    );
                    context.go(AppRouter.verifyView);
                  }
                },
                builder: (context, state) {
                  return CustomAuthButton(
                    isLoading: state is AuthLoadingState,
                    buttonText: "Register",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthCubit>(context).register(
                            email: email.text, password: password.text);
                        (context).push(AppRouter.loginView);
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }
}
