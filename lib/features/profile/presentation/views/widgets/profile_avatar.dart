import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    this.imageUrl,  
    this.radius = 60,  
    this.showOnlineIndicator = false,  
    this.isOnline = false,
  });

  final String? imageUrl;  
  final double radius;
  final bool showOnlineIndicator;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // الصورة الرئيسية
        Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: radius,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
                ? NetworkImage(imageUrl!)  
                : null,
            child: imageUrl == null || imageUrl!.isEmpty
                ? Icon(
                    Icons.person,  
                    size: radius,
                    color: Colors.grey.shade600,
                  )
                : null,
          ),
        ),

        // Online Indicator
        if (showOnlineIndicator)  
          Positioned(
            bottom: 4,
            right: 4,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isOnline ? Colors.green : Colors.grey,
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
              ),
            ),
          ),
      ],
    );
  }
}