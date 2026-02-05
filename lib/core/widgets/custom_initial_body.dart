import 'package:flutter/material.dart';

class CustomInitialBody extends StatelessWidget {
  const CustomInitialBody({
    super.key, required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_off, size: 64, color: Colors.grey),
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
