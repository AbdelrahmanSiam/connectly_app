import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    this.imageUrl,
    this.radius = 60,
    this.showOnlineIndicator = false,
    this.isOnline = true,
    this.borderWidth = 4,
    this.showBoxShadow = true,
    this.onlineCircularSize = 24,
    this.onlineCircularPosition = 8,
  });

  final String? imageUrl;
  final double radius;
  final bool showOnlineIndicator;
  final bool isOnline;
  final double borderWidth;
  final bool showBoxShadow;
  final double onlineCircularSize;
  final double onlineCircularPosition;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0.5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: showBoxShadow
                ? [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : null,
          ),
          padding: EdgeInsets.all(borderWidth),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: CircleAvatar(
              radius: radius - borderWidth,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
                  ? NetworkImage(imageUrl!)
                  : null,
              child: imageUrl == null || imageUrl!.isEmpty
                  ? Icon(
                      Icons.person,
                      size: radius * 0.8,
                      color: Colors.grey.shade400,
                    )
                  : null,
            ),
          ),
        ),
        if (showOnlineIndicator)
          Positioned(
            bottom: onlineCircularPosition,
            right: onlineCircularPosition,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: onlineCircularSize,
              height: onlineCircularSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isOnline ? Colors.greenAccent : Colors.grey.shade400,
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
                boxShadow: isOnline
                    ? showBoxShadow
                        ? [
                            BoxShadow(
                              color: Colors.greenAccent.withOpacity(0.6),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ]
                        : null
                    : null,
              ),
            ),
          ),
      ],
    );
  }
}
