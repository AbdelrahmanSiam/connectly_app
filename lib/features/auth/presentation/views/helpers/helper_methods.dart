import 'package:connectly/core/utils/app_colors.dart';
import 'package:flutter/material.dart';


  
   String? nullValidationMethod(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is required';
    }
    return null;
  }

OutlineInputBorder  buildBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      color: AppColors.primary,
      width: 2,
    ),
  );

}