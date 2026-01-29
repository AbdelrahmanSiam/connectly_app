import 'package:flutter/material.dart';
import 'package:connectly_app/core/utils/app_text_styles.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    this.icon,
    required this.label,
    required this.value,
    this.color,
  });

  final IconData? icon;
  final String label;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 32,
                color: color ?? Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 8),
            ],

            Text(
              value,
              style: AppTextStyles.textStyle22.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              label,
              style: AppTextStyles.textStyle16.copyWith(
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}