import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:connectly_app/features/auth/presentation/views/helpers/helper_methods.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.icon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    //  this.onSaved,
      required this.controller,
  });
  final String labelText;
  final IconData icon;
  final bool isPassword;
  final TextInputType keyboardType; // خلي الـ keyboardType dynamic
  // final void Function(String?)? onSaved;
  final TextEditingController controller;


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
      // onSaved: widget.onSaved ,
      validator: (value) {
        return nullValidationMethod(value);
      },
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? isObscured : false, //is obscured depend on is pass or not if field is pass then make it obscure if not (email) do not make it obscure
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0XFF1C1C1E),
        prefixIcon: Icon(
          widget.icon,
          color: Colors.white,
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
                  color: Colors.white,
                ),
              )
            : null,
        labelText: widget.labelText,
        labelStyle: AppTextStyles.textStyle16.copyWith(color:Colors.white),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
      ),
    );
  }
}
