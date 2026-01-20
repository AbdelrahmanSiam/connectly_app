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

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
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
                  header1: 'Create Account',
                  header2: 'Register to get started'),
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
                    CustomSnackBar.show(context,
                        message: state.errMessage, type: SnackBarType.error);
                  } else if (state is AuthSuccessState) {
                    CustomSnackBar.show(context,
                        message: "Account created successfully!", type: SnackBarType.success);
                    context.go(AppRouter.userProfileView, extra: {
                      'uid' : state.uid ,
                      'email' : state.email,
                    } );
                  }
                },
                builder: (context, state) {
                  return CustomAuthButton(
                    isLoading: state is AuthLoadingState,
                    buttonText: "Register",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        BlocProvider.of<AuthCubit>(context)
                            .register(email: email!, password: password!);
                      }
                    },
                  );
                },
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
      ),
    );
  }
}
