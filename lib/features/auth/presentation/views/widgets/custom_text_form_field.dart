import 'package:connectly_app/core/utils/app_colors.dart';
import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:connectly_app/features/auth/presentation/views/helpers/helper_methods.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
     this.icon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
      required this.controller, this.validator,
  });
  final String labelText;
  final IconData? icon;
  final bool isPassword;
  final TextInputType keyboardType; // خلي الـ keyboardType dynamic
  final TextEditingController controller;
  final String? Function(String?)? validator;


  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isObscured; // text is obscured or not?

  @override
  void initState() {
    isObscured = widget.isPassword; //  pass is is pass value to isObscured in beggining
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? isObscured : false, //is obscured depend on is pass or not if field is pass then make it obscure if not (email) do not make it obscure
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(
          widget.icon,
          color: AppColors.primary,
        ),
        suffixIcon: widget.isPassword  // Is field is pass ? if yes create Icon Button if not (email) return null
            ? IconButton(
                onPressed: () {
                  setState(
                    () {
                      isObscured = !isObscured;
                    },
                  );
                },
                icon: Icon(
                  isObscured ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.primary,
                ),
              )
            : null,
        labelText: widget.labelText,
        labelStyle: AppTextStyles.textStyle16.copyWith(color:AppColors.primary),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
      ),
    );
  }
}
