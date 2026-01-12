import 'package:flutter/material.dart';

enum SnackBarType { success, error, warning }

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.success,
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
  }) {
    Color bgColor;
    IconData defaultIcon;

    switch (type) {
      case SnackBarType.success:
        bgColor = Colors.green.shade600;
        defaultIcon = Icons.check_circle;
        break;
      case SnackBarType.error:
        bgColor = Colors.red.shade600;
        defaultIcon = Icons.error;
        break;
      case SnackBarType.warning:
        bgColor = Colors.orange.shade700;
        defaultIcon = Icons.warning;
        break;
    }

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: duration,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon ?? defaultIcon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
