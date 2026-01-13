import 'package:connectly/core/utils/app_colors.dart';
import 'package:connectly/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class HomeViewSearchBar extends StatelessWidget {
  const HomeViewSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintStyle: AppTextStyles.textStyle18,
        hintText: 'Search',
        prefixIcon: Icon(
          Icons.search,
          size: 28,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.primary, // حدود التركيز متناسقة مع AppBar
            width: 2,
          ),
        ),
      ),
    );
  }
}
