import 'dart:io';

import 'package:connectly_app/core/routing/app_router.dart';
import 'package:connectly_app/core/utils/app_colors.dart';
import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:connectly_app/core/widgets/custom_snackbar.dart';
import 'package:connectly_app/features/auth/presentation/views/helpers/helper_methods.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/custom_auth_button.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/profile_image_picker.dart';
import 'package:connectly_app/features/profile/presentation/manager/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:connectly_app/features/profile/presentation/manager/user_cubit/user_cubit.dart';
import 'package:connectly_app/features/profile/presentation/views/helper/profile_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditProfileViewBody extends StatefulWidget {
  const EditProfileViewBody({super.key});

  @override
  State<EditProfileViewBody> createState() => _EditProfileViewBodyState();
}

class _EditProfileViewBodyState extends State<EditProfileViewBody> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController newName = TextEditingController();
  TextEditingController bio = TextEditingController();
  File? selectedImage;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserCubit>().currentUser;
    if (user != null) {
      newName.text = user.name;
      bio.text = user.bio;
      imageUrl = user.profilePictureUrl;
    }
  }

  @override
  void dispose() {
    newName.dispose();
    bio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                "Update your information",
                style: AppTextStyles.textStyle32.copyWith(color: AppColors.deepPrimary),
              ),
              const SizedBox(height: 40),
              ProfileImagePicker(
                imageFile: selectedImage, // new image
                imageUrl: imageUrl, // old image
                onTap: () async {
                  final image = await pickCameraPhoto();
                  if (image != null) {
                    setState(() {
                      selectedImage = image;
                      imageUrl = null;
                    });
                  }
                },
              ),
              SizedBox(
                height: 50,
              ),
              CustomTextFormField(
                labelText: 'Name',
                icon: Icons.person,
                controller: newName,
                validator: (value) {
                  return nullValidationMethod(value);
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                labelText: 'Bio',
                icon: Icons.edit_note,
                controller: bio,
                validator: (value) {
                  return nullValidationMethod(value);
                },
              ),
              SizedBox(
                height: 100,
              ),
              BlocConsumer<EditProfileCubit, EditProfileState>(
                listener: (context, state) {
                  if (state is EditProfileSuccessState) {
                    CustomSnackBar.show(
                      context,
                      message: "Profile updated ",
                      type: SnackBarType.success,
                    );
                    Navigator.pop(context);
                  } else if (state is EditProfileFailureState) {
                    CustomSnackBar.show(context,
                        message: state.errMessage, type: SnackBarType.error);
                  }
                },
                builder: (context, state) {
                  return CustomAuthButton(
                    isLoading: state is EditProfileLoadingState,
                    buttonText: "Save",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<EditProfileCubit>().updateProfile(
                            name: newName.text,
                            bio: bio.text,
                            newProfilePic: selectedImage);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
