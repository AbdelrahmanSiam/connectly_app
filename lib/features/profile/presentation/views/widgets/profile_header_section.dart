import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({
    super.key,
    required this.name,      // ✅ أضف parameters
    required this.email,
    this.imageUrl,
    this.isOnline = false,
  });

  final String name;
  final String email;
  final String? imageUrl;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, 
      padding: const EdgeInsets.symmetric(vertical: 30),  
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF2C142C),
            Color.fromARGB(255, 221, 206, 221),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          ProfileAvatar(
            imageUrl: imageUrl,
            radius: 60,
            showOnlineIndicator: true,  
            isOnline: isOnline,
          ),
          const SizedBox(height: 16),
          
          Text(
            name,
            style: AppTextStyles.textStyle22.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,  
            ),
          ),
          const SizedBox(height: 4),
          
          Text(
            email,
            style: AppTextStyles.textStyle16.copyWith(  
              color: Colors.white70,  
            ),
          ),
        ],
      ),
    );
  }
}