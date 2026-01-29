import 'package:connectly_app/features/home/presentation/views/widgets/logout_dialog.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:connectly_app/core/utils/app_text_styles.dart';

class SettingsSection extends StatefulWidget {
  const SettingsSection({
    super.key,
    required this.onEditProfile,
  });

  final VoidCallback onEditProfile;

  @override
  State<SettingsSection> createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Row(
          children: [
            Icon(
              Icons.settings_outlined,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 8),
            Text(
              "Settings",
              style: AppTextStyles.textStyle18.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
    
        const SizedBox(height: 16),
    
        // Settings Tiles
        SettingTile(
          icon: Icons.edit_outlined,
          title: "Edit Profile",
          subtitle: "Update your information",
          onTap: widget.onEditProfile,
        ),
    
        SettingTile(
          icon: Icons.logout,
          iconColor: Colors.red,
          title: "Logout",
          subtitle: "Sign out of your account",
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => const LogoutDialog(),
            );
          },
        ),
      ],
    );
  }
}
