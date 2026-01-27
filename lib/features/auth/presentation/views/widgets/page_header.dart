import 'package:connectly_app/core/utils/app_colors.dart';
import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({super.key, required this.header1, required this.header2});
  final String header1;
  final String header2;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Text(
          header1,
          style:
              AppTextStyles.textStyle32.copyWith(color: AppColors.deepPrimary),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          header2,
          style:
              AppTextStyles.textStyle22.copyWith(color: AppColors.deepPrimary),
        ),
      ],
    );
  }
}
