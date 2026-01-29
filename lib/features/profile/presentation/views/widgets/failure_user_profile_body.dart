import 'package:flutter/material.dart';

class FailureUserProfileBody extends StatelessWidget {
  const FailureUserProfileBody({
    super.key, required this.text,
  });
      final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            text,
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
