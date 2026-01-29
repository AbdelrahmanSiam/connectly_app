import 'package:flutter/material.dart';
import 'package:connectly_app/core/utils/app_text_styles.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({
    super.key,
    required this.icon,
    this.iconColor,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final Color? iconColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? Theme.of(context).primaryColor;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: effectiveIconColor.withOpacity(0.1),
        child: Icon(
          icon,
          color: effectiveIconColor,
          size: 22,
        ),
      ),

      title: Text(
        title,
        style: AppTextStyles.textStyle18.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),

      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: AppTextStyles.textStyle16.copyWith(
                color: Colors.grey.shade600,
              ),
            )
          : null,

      trailing: trailing ??
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey.shade400,
          ),

      onTap: onTap,

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}