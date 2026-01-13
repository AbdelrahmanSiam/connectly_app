import 'package:connectly/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class HomeViewAppBar extends StatelessWidget {
  const HomeViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface;

    return Row(
      children: [
        Text(
          "Connectly",
          style: AppTextStyles.textStyle32.copyWith(color: color),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.logout_outlined,
            size: 28,
            color: color,
          ),
        ),
      ],
    );
  }
}
