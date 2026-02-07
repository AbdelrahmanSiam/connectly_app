import 'package:flutter/material.dart';

class CustomInitialBody extends StatelessWidget {
  const CustomInitialBody({
    super.key, required this.text, this.icon = Icons.person_off,
  });
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            text,
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
