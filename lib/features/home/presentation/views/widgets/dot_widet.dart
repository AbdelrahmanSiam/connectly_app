
import 'package:flutter/material.dart';

class DotWidget extends StatelessWidget {
  const DotWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.green, // online
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
        ),
      );
  }
}
