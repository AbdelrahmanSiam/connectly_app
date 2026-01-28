import 'package:connectly_app/core/routing/app_router.dart';
import 'package:connectly_app/core/utils/app_colors.dart';
import 'package:connectly_app/features/home/presentation/views/widgets/logout_dialog.dart';
import 'package:connectly_app/features/home/presentation/views/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeViewMenu extends StatelessWidget {
  const HomeViewMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      iconSize: 32,
      iconColor: AppColors.deepPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onSelected: (value) {
        if (value == 'profile') {
          context.push(AppRouter.profileView);
        } else if (value == 'logout') {
          showDialog(
            context: context,
            builder: (_) => const LogoutDialog(),
          );
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'profile',
          child: MenuItem(
            icon: Icons.person_outline,
            text: 'Profile',
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: 'logout',
          child: MenuItem(
            icon: Icons.logout,
            text: 'Logout',
            isDanger: true,
          ),
        ),
      ],
    );
  }
}
