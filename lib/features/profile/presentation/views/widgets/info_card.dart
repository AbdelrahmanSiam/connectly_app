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
    final effectiveColor = color ?? Theme.of(context).primaryColor;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            effectiveColor.withOpacity(0.1),
            effectiveColor.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: effectiveColor.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: effectiveColor.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon Container
          if (icon != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: effectiveColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 28,
                color: effectiveColor,
              ),
            ),

          if (icon != null) const SizedBox(height: 12),

          // Value
          Text(
            value,
            style: AppTextStyles.textStyle22.copyWith(
              fontWeight: FontWeight.bold,
              color: effectiveColor,
            ),
          ),

          const SizedBox(height: 4),

          // Label
          Text(
            label,
            style: AppTextStyles.textStyle16.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}