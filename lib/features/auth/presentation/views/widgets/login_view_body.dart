import 'package:connectly_app/core/routing/app_router.dart';
import 'package:connectly_app/core/utils/app_colors.dart';
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
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
                controller: email,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                labelText: 'Password',
                isPassword: true,
                icon: Icons.password,
                controller: password,
              ),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailureState) {
                    CustomSnackBar.show(
                      context,
                      message: state.errMessage,
                      type: SnackBarType.error,
                    );
                  } else if (state is AuthSuccessState) {
                    CustomSnackBar.show(
                      context,
                      message: "Login Successful!",
                      type: SnackBarType.success,
                    );
                    (context).go(AppRouter.homeView);
                  } else if (state is ForgetPasswordState) {
                    CustomSnackBar.show(
                      context,
                      message: "Check your email to reset password. ",
                      type: SnackBarType.success,
                    );
                  } else if (state is ForgetPasswordFailureState) {
                    CustomSnackBar.show(
                      context,
                      message: state.errMessage,
                      type: SnackBarType.error,
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (email.text == null || email.text.trim().isEmpty) {
                            CustomSnackBar.show(
                              context,
                              message: "Please enter email first",
                              type: SnackBarType.error,
                            );
                          } else {
                            BlocProvider.of<AuthCubit>(context)
                                .forgetPassword(email: email.text);
                          }
                        },
                        child: Align(
                          alignment: Alignment.centerLeft
                          ,
                          child: Text("Forget password ? ",style: AppTextStyles.textStyle18.copyWith(color: AppColors.primary),)),
                      ),
                      const SizedBox(height: 50),
                      CustomAuthButton(
                        isLoading: state is AuthLoadingState,
                        buttonText: "Login",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context)
                                .login(email: email.text, password: password.text);
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.textStyle18
                          .copyWith(color: Colors.black)),
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
@override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

}
