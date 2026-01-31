import 'dart:io';

import 'package:connectly_app/core/routing/app_router.dart';
import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:connectly_app/core/widgets/custom_snackbar.dart';
import 'package:connectly_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:connectly_app/features/auth/presentation/views/helpers/helper_methods.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/custom_auth_button.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/custom_text_button.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/navigator_to_login_section.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/page_header.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/profile_image_picker.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/register_form_section.dart'
    show FormSection;
import 'package:connectly_app/features/profile/presentation/views/helper/profile_helper.dart';
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
  File? selectedImage;
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
              const PageHeaderSection(
                  header1: 'Create Account',
                  header2: 'Register to get started'),
              const SizedBox(height: 50),
              ProfileImagePicker(
                imageFile: selectedImage,
                onTap: () async {
                  final image = await pickCameraPhoto();
                  if (image != null) {
                    setState(() {
                      selectedImage = image;
                    });
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              FormSection(
                  name: name,
                  email: email,
                  password: password,
                  confirmPassword: confirmPassword),
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
                    GoRouter.of(context).push(AppRouter.verifyView);
                  }
                },
                builder: (context, state) {
                  return CustomAuthButton(
                    isLoading: state is AuthLoadingState,
                    buttonText: "Register",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (selectedImage == null) {
                          CustomSnackBar.show(
                            context,
                            message: "Please select profile image",
                            type: SnackBarType.error,
                          );
                          return;
                        }
                        BlocProvider.of<AuthCubit>(context).register(
                            email: email.text,
                            password: password.text,
                            name: name.text,
                            imageFile : selectedImage!
                            );
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              NavigatorToLoginSection(),
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
    name.dispose();
    super.dispose();
  }
}
