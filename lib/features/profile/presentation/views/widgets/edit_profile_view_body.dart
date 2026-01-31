import 'package:connectly_app/features/auth/presentation/views/helpers/helper_methods.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/custom_auth_button.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/profile_image_picker.dart';
import 'package:flutter/material.dart';

class EditProfileViewBody extends StatefulWidget {
  const EditProfileViewBody({super.key});

  @override
  State<EditProfileViewBody> createState() => _EditProfileViewBodyState();
}

class _EditProfileViewBodyState extends State<EditProfileViewBody> {
  GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController newName = TextEditingController();
  final TextEditingController bio = TextEditingController();

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
                height: 70,
              ),
              ProfileImagePicker(),
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
                icon: Icons.merge_type,
                controller: bio,
                validator: (value) {
                  return nullValidationMethod(value);
                },
              ),
              SizedBox(
                height: 100,
              ),
              CustomAuthButton(
                // isLoading: state is AuthLoadingState,
                buttonText: "Save",
                onPressed: () {
                  if(formKey.currentState!.validate()){
                    
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
