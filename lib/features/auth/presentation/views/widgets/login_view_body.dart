import 'package:connectly_app/core/routing/app_router.dart';
import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:connectly_app/core/widgets/custom_snackbar.dart';
import 'package:connectly_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/custom_auth_button.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/custom_text_button.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();

  String? email, password;

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
                  header1: "Welcome back!", header2: 'Login to continue'),
              const SizedBox(height: 100),
              CustomTextFormField(
                labelText: 'Email',
                icon: Icons.email,
                onSaved: (value) {
                  email = value;
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                labelText: 'Password',
                isPassword: true,
                icon: Icons.password,
                onSaved: (value) {
                  password = value;
                },
              ),
              const SizedBox(height: 50),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailureState) {
                    CustomSnackBar.show(
                      context,
                      message: state.errMessage,
                      type: SnackBarType.error,
                    );
                  }

                  if (state is AuthSuccessState) {
                    CustomSnackBar.show(
                      context,
                      message: "Login Successful!",
                      type: SnackBarType.success,
                    );
                    context.go(AppRouter.homeView);
                  }
                },
                builder: (context, state) {
                  return CustomAuthButton(
                    isLoading: state is AuthLoadingState,
                    buttonText: "Login",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!
                            .save(); // to save input data on fields
                        BlocProvider.of<AuthCubit>(context)
                            .login(email: email!, password: password!);
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?",
                      style: AppTextStyles.textStyle18),
                  CustomTextButton(
                    text: 'Register',
                    onPressed: () {
                      context.go(AppRouter.registerView);
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
}
