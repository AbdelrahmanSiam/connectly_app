import 'package:connectly/core/utils/app_colors.dart';
import 'package:connectly/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key, required this.buttonText,
  });
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        buttonText,
        style: AppTextStyles.textStyle18.copyWith(color: Colors.white),
      ),
    );
  }
}
